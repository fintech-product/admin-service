import { Attributes } from "onecore"
import { buildMap, buildToInsert, buildToInsertBatch, buildToUpdate, DB, SearchRepository, Statement, StringMap } from "query-core"
import { Query } from "query-mappers"
import { Role, RoleFilter, roleModel, RoleRepository } from "./role"

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
const roleModuleModel: Attributes = {
  roleId: {
    column: "role_id",
    key: true,
  },
  moduleId: {
    column: "module_id",
    key: true,
  },
  permissions: {
    type: "integer",
  },
}
interface UserRole {
  userId?: string
  roleId?: string
}
interface Module {
  moduleId?: string
  roleId?: string
  permissions?: number
}
export class SqlRoleRepository extends SearchRepository<Role, RoleFilter> implements RoleRepository {
  private roleModuleMap: StringMap
  map?: StringMap
  attributes: Attributes
  constructor(protected db: DB, query?: Query) {
    super(db, "roles", roleModel, query)
    this.attributes = roleModel
    this.metadata = this.metadata.bind(this)
    this.search = this.search.bind(this)
    this.all = this.all.bind(this)
    this.load = this.load.bind(this)
    this.create = this.create.bind(this)
    this.update = this.update.bind(this)
    this.patch = this.patch.bind(this)
    this.delete = this.delete.bind(this)
    this.assign = this.assign.bind(this)
    this.map = buildMap(roleModel)
    this.roleModuleMap = buildMap(roleModuleModel)
  }
  metadata(): Attributes {
    return roleModel
  }
  all(): Promise<Role[]> {
    return this.db.query("select * from roles order by role_id asc", undefined, this.map)
  }
  async load(id: string): Promise<Role | null> {
    let query = `select * from roles where role_id = ${this.db.param(1)}`
    const roles = await this.db.query<Role>(query, [id], this.map)
    if (!roles || roles.length === 0) {
      return null
    }
    const role = roles[0]
    query = `select module_id, permissions from role_modules where role_id = ${this.db.param(1)}`
    const modules = await this.db.query<Module>(query, [id], this.roleModuleMap)
    if (modules && modules.length > 0) {
      role.privileges = modules.map((i) => (i.permissions ? i.moduleId + " " + i.permissions.toString(16) : i.moduleId)) as any
    }
    return role
  }
  create(role: Role): Promise<number> {
    const stmts: Statement[] = []
    const stmt = buildToInsert(role, "roles", roleModel, this.db.param)
    stmts.push(stmt)
    insertRoleModules(stmts, role.roleId, role.privileges, this.db.param)
    return this.db.executeBatch(stmts, true)
  }
  update(role: Role): Promise<number> {
    const stmts: Statement[] = []
    const stmt = buildToUpdate(role, "roles", roleModel, this.db.param)
    let firstSuccess = false
    if (stmt.query) {
      stmts.push(stmt)
      firstSuccess = true
    }
    if (role.privileges) {
      const query = `delete from role_modules where role_id = ${this.db.param(1)}`
      stmts.push({ query, params: [role.roleId] })
      insertRoleModules(stmts, role.roleId, role.privileges, this.db.param)
    }
    return this.db.executeBatch(stmts, firstSuccess)
  }
  patch(role: Role): Promise<number> {
    return this.update(role)
  }
  delete(id: string): Promise<number> {
    const stmts: Statement[] = []
    stmts.push({ query: `delete from role_modules where role_id = ${this.db.param(1)}`, params: [id] })
    stmts.push({ query: `delete from roles where role_id = ${this.db.param(1)}`, params: [id] })
    return this.db.executeBatch(stmts)
  }
  assign(roleId: string, users: string[]): Promise<number> {
    const stmts: Statement[] = []
    stmts.push({ query: `delete from user_roles where role_id = ${this.db.param(1)}`, params: [roleId] })
    if (users && users.length > 0) {
      const userRoles: UserRole[] = users.map<UserRole>((u) => {
        return { roleId, userId: u }
      })
      const stmt = buildToInsertBatch<UserRole>(userRoles, "user_roles", userRoleModel, this.db.param)
      if (stmt.query) {
        stmts.push(stmt)
      }
    }
    return this.db.executeBatch(stmts)
  }
}

function insertRoleModules(stmts: Statement[], roleId: string, privileges: string[] | undefined, param: (i: number) => string): Statement[] {
  if (privileges && privileges.length > 0) {
    let permissions = 1
    const modules = privileges.map<Module>((i) => {
      const ms: Module = { roleId, moduleId: i, permissions }
      if (i.indexOf(" ") > 0) {
        const arr = i.split(" ")
        permissions = parseInt(arr[1], 16)
        if (isNaN(permissions)) {
          permissions = 0
        }
        ms.moduleId = arr[0]
        ms.permissions = permissions
      }
      return ms
    })
    const stmt = buildToInsertBatch(modules, "role_modules", roleModuleModel, param)
    if (stmt.query) {
      stmts.push(stmt)
    }
  }
  return stmts
}
