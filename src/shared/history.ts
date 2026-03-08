import { nanoid } from "nanoid";
import { DB, Transaction } from "onecore";

export class Action {
  static readonly Create = "C"
  static readonly Update = "U"
  static readonly Submit = "S"
  static readonly Approve = "A"
  static readonly Reject = "R"
  static readonly Delete = "D"
}
export const ignoreFields = ["id", "createdBy", "createdAt", "updatedBy", "updatedAt", "submittedBy", "submittedAt", "approvedBy", "approvedAt"]

export interface History<T> {
  id: string
  author: string
  time: Date
  action: string
  data: T
}

interface Position {
  position: number
}
export interface HistoryRepository<T> {
  create(id: string, author: string, action: string, data?: T | null, tx?: Transaction): Promise<number>
  getHistories(id: string, limit: number, nextPageToken?: string): Promise<History<T>[]>
}

export class HistoryAdapter<T> implements HistoryRepository<T> {
  protected ignoreFields: string[]
  protected historyId: string
  protected entity: string
  protected id: string
  protected author: string
  protected time: string
  protected action: string
  protected data: string
  constructor(protected db: DB, protected type: string, protected table: string, ignoreFields?: string[], historyId?: string, entity?: string, id?: string, author?: string, time?: string, action?: string, data?: string) {
    this.ignoreFields = ignoreFields || []
    this.historyId = historyId || "history_id"
    this.entity = entity || "entity"
    this.id = id || "id"
    this.author = author || "author"
    this.time = time || "time"
    this.action = action || "action"
    this.data = data || "data"
    this.create = this.create.bind(this)
    this.getHistories = this.getHistories.bind(this)
  }
  create(id: string, author: string, action: string, data?: T | null, tx?: Transaction): Promise<number> {
    const historyId = nanoid(10)
    let cloneObj: any = null
    if (data) {
      cloneObj = { ...data }
      if (this.ignoreFields && this.ignoreFields.length > 0) {
        const l = this.ignoreFields.length
        for (let i = 0; i < l; i++) {
          delete cloneObj[this.ignoreFields[i]]
        }
      }
    }
    const sql = `
      insert into ${this.table} (
        ${this.historyId},
        ${this.entity},
        ${this.id},
        ${this.author},
        ${this.time},
        ${this.action},
        ${this.data}
      ) values (
        ${this.db.param(1)},
        ${this.db.param(2)},
        ${this.db.param(3)},
        ${this.db.param(4)},
        ${this.db.param(5)},
        ${this.db.param(6)},
        ${this.db.param(7)}
      )`
    const db = tx ? tx : this.db
    return db.execute(sql, [historyId, this.type, id, author, new Date(), action, cloneObj])
  }
  async getHistories(id: string, limit: number, nextPageToken?: string): Promise<History<T>[]> {
    if (limit <= 0) {
      limit = 20
    }
    let offset = 0
    if (nextPageToken) {
      const query = `
        select position from 
          (select ${this.historyId}, row_number() over(order by ${this.time} desc) as position 
          from ${this.table} where ${this.id} = ${this.db.param(1)} and ${this.entity} = ${this.db.param(2)}) result 
        where ${this.historyId} = ${this.db.param(3)}`
      const pos = await this.db.query<Position>(query, [id, this.type, nextPageToken])
      if (pos.length > 0) {
        offset = pos[0].position
      }
    }
    const sql = `
      select ${this.historyId} as id, ${this.author} as author, ${this.time} as time, ${this.action} as action, ${this.data} as data
      from ${this.table}
      where ${this.id} = ${this.db.param(1)} and ${this.entity} = ${this.db.param(2)}
      order by ${this.time} desc limit ${limit} offset ${offset}`
    return this.db.query<History<T>>(sql, [id, this.type])
  }
}
