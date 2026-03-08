import { nanoid } from "nanoid"
import { DB, Notification, NotificationPort, Statement } from "onecore"

export function createNotification(sender: string, receiver: string, message: string, url?: string): Notification {
  const notification: Notification = { sender, receiver, message, url }
  return notification
}

export class NotificationAdapter implements NotificationPort {
  protected unread: string
  protected time: string
  protected url: string
  protected id: string
  protected sender: string
  protected receiver: string
  protected message: string
  protected status: string
  constructor(protected db: DB, protected table: string, unread?: string, time?: string, url?: string, id?: string, sender?: string, receiver?: string, message?: string, status?: string) {
    this.unread = unread && unread.length > 0 ? unread : "U"
    this.time = time && time.length > 0 ? time : "time"
    this.url = url && url.length > 0 ? url : "url"
    this.id = id && id.length > 0 ? id : "id"
    this.sender = sender && sender.length > 0 ? sender : "sender"
    this.receiver = receiver && receiver.length > 0 ? receiver : "receiver"
    this.message = message && message.length > 0 ? message : "message"
    this.status = status && status.length > 0 ? status : "status"
  }

  push(noti: Notification): Promise<number> {
    noti.id = nanoid(10)
    const sql = `
      insert into ${this.table} (
        ${this.id},
        ${this.sender},
        ${this.receiver},
        ${this.message},
        ${this.time},
        ${this.url},
        ${this.status}
      ) values (
        ${this.db.param(1)},
        ${this.db.param(2)},
        ${this.db.param(3)},
        ${this.db.param(4)},
        ${this.db.param(5)},
        ${this.db.param(6)},
        ${this.db.param(7)}
      )
    `
    return this.db.execute(sql, [noti.id, noti.sender, noti.receiver, noti.message, new Date(), noti.url, this.unread])
  }
  pushNotifications(notifications: Notification[]): Promise<number> {
    const query = `
      insert into ${this.table} (
        ${this.id},
        ${this.sender},
        ${this.receiver},
        ${this.message},
        ${this.time},
        ${this.url},
        ${this.status}
      ) values (
        ${this.db.param(1)},
        ${this.db.param(2)},
        ${this.db.param(3)},
        ${this.db.param(4)},
        ${this.db.param(5)},
        ${this.db.param(6)},
        ${this.db.param(7)}
      )
    `
    const now = new Date()
    const statements: Statement[] = []
    for (let noti of notifications) {
      noti.id = nanoid(10)
      const statement: Statement = { query, params: [noti.id, noti.sender, noti.receiver, noti.message, now, noti.url, this.unread] }
      statements.push(statement)
    }
    return this.db.executeBatch(statements)
  }
}