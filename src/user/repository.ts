import { Attributes, StringMap } from "onecore"
import { param } from "pg-extension"
import { buildMap, buildSort, buildToInsert, buildToInsertBatch, buildToUpdate, DB, SearchRepository, Statement } from "query-core"
import { User, UserFilter, userModel, UserRepository } from "./user"

export function buildQuery(filter: UserFilter): Statement {
  let query = `select * from users`
  const where: string[] = []
  const params = []
  let i = 1

  if (filter.userId) {
    where.push(`id = $${param(i++)}`);
    params.push(filter.userId);
  }

  if (filter.status && filter.status.length > 0) {
    const arr: string[] = []
    for (const status of filter.status) {
      params.push(status)
      arr.push(`${param(i++)}`)
    }
    where.push(`status in (${arr.join(",")})`)
  }

  if (filter.excluding && filter.excluding.length > 0) {
    const arr: string[] = []
    for (const id of filter.excluding) {
      params.push(id)
      arr.push(`${param(i++)}`)
    }
    where.push(`user_id not in (${arr.join(",")})`)
  }

  if (filter.email) {
    where.push(`email ilike $${param(i++)}`);
    params.push(`${filter.email}%`);
  }
  if (filter.username) {
    where.push(`username ilike $${param(i++)}`);
    params.push(`${filter.username}%`);
  }
  if (filter.displayName) {
    where.push(`display_name ilike $${param(i++)}`);
    params.push(`%${filter.displayName}%`);
  }

  if (filter.q) {
    const q = filter.q.replace(/%/g, "\\%").replace(/_/g, "\\_")
    where.push(`(email ilike ${param(i++)} or username ilike ${param(i++)} or display_name ilike ${param(i++)})`)
    params.push(`${q}%`, `%${q}%`, `%${q}%`)
  }

  if (where.length > 0) {
    query = query + ` where ` + where.join(` and `)
  }
  const orderBy = buildSort(filter.sort, userModel)
  if (orderBy) {
    query = query + ` order by ${orderBy}`
  }

  console.log(query)
  return { query, params }
}

const userRoleModel: Attributes = {
  userId: {
    column: "user_id",
    key: true,
  },
  roleId: {
    column: "role_id",
    key: true,
  },
}
interface UserRole {
  userId?: string
  roleId: string
}

export class SqlUserRepository extends SearchRepository<User, UserFilter> implements UserRepository {
  map: StringMap
  roleMap: StringMap
  attributes: Attributes
  constructor(protected db: DB) {
    super(db, "users", userModel, buildQuery)
    this.attributes = userModel
    this.map = buildMap(userModel)
    this.roleMap = buildMap(userRoleModel)
    this.getUsersOfRole = this.getUsersOfRole.bind(this)
    this.search = this.search.bind(this)
    this.create = this.create.bind(this)
    this.update = this.update.bind(this)
    this.patch = this.patch.bind(this)
    this.delete = this.delete.bind(this)
    this.assign = this.assign.bind(this)
  }
  getUsersOfRole(roleId: string): Promise<User[]> {
    if (!roleId || roleId.length === 0) {
      return Promise.resolve([])
    }
    const sql = `
      select u.*
      from user_roles ur
        inner join users u on u.user_id = ur.user_id
      where ur.role_id = ${this.db.param(1)}
      order by user_id`
    return this.db.query(sql, [roleId], this.map)
  }
  all(): Promise<User[]> {
    return this.db.query("select * from users order by user_id asc", undefined, this.map)
  }
  async load(id: string): Promise<User | null> {
    let query = `select * from users where user_id = ${this.db.param(1)}`
    let users = await this.db.query<User>(query, [id], this.map)
    if (!users || users.length === 0) {
      return null
    }
    const user = users[0]
    query = `select role_id from user_roles where user_id = ${this.db.param(1)}`
    const roles = await this.db.query<UserRole>(query, [id], this.roleMap)
    if (roles && roles.length > 0) {
      user.roles = roles.map((i) => i.roleId)
    }
    return user
  }
  create(user: User): Promise<number> {
    const stmts: Statement[] = []
    const stmt = buildToInsert(user, "users", userModel, this.db.param)
    stmts.push(stmt)
    if (user.roles) {
      insertUserRoles(stmts, user.userId, user.roles, this.db.param)
    }
    return this.db.executeBatch(stmts, true)
  }
  update(user: User): Promise<number> {
    const stmts: Statement[] = []
    const stmt = buildToUpdate(user, "users", userModel, this.db.param)
    let firstSuccess = false
    if (stmt.query) {
      stmts.push(stmt)
      firstSuccess = true
    }
    if (user.roles) {
      stmts.push({ query: `delete from user_roles where user_id = ${this.db.param(1)}`, params: [user.userId] })
      insertUserRoles(stmts, user.userId, user.roles, this.db.param)
    }
    return this.db.executeBatch(stmts, firstSuccess)
  }
  patch(user: User): Promise<number> {
    return this.update(user)
  }
  delete(id: string): Promise<number> {
    const stmts: Statement[] = []
    stmts.push({ query: `delete from user_roles where user_id = ${this.db.param(1)}`, params: [id] })
    stmts.push({ query: `delete from users where user_id = ${this.db.param(1)}`, params: [id] })
    return this.db.executeBatch(stmts)
  }
  assign(id: string, roles: string[]): Promise<number> {
    const stmts: Statement[] = []
    const query = `delete from user_roles where user_id = ${this.db.param(1)}`
    stmts.push({ query, params: [id] })
    if (roles && roles.length > 0) {
      insertUserRoles(stmts, id, roles, this.db.param)
    }
    return this.db.executeBatch(stmts)
  }
}

function insertUserRoles(stmts: Statement[], userId: string, roles: string[] | undefined, param: (i: number) => string): Statement[] {
  if (roles && roles.length > 0) {
    const userRoles = roles.map<UserRole>((i) => {
      const userRole: UserRole = { userId, roleId: i }
      return userRole
    })
    const stmt = buildToInsertBatch(userRoles, "user_roles", userRoleModel, param)
    if (stmt.query) {
      stmts.push(stmt)
    }
  }
  return stmts
}
