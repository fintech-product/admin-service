import { Request, Response } from "express"
import { format, fromRequest, handleError } from "express-core-web"
import { Log } from "onecore"
import { DB, Query } from "sql-core"
import { AuditLog, AuditLogFilter, auditLogModel, AuditLogService } from "./audit-log"
export * from "./audit-log"

export function useAuditLogController(log: Log, db: DB): AuditLogController {
  const query = new Query<AuditLog, string, AuditLogFilter>(db, "audit_logs", auditLogModel)
  return new AuditLogController(query);
}
export class AuditLogController {
  constructor(protected query: AuditLogService) {
    this.search = this.search.bind(this)
  }
  async search(req: Request, res: Response) {
    const filter = fromRequest<AuditLogFilter>(req)
    format(filter, ["time"])
    if (!filter.sort) {
      filter.sort = "-time"
    }
    const { limit, page, fields } = filter
    try {
      const result = await this.query.search(filter, limit, page, fields)
      res.status(200).json(result)
    } catch (err) {
      handleError(err, res)
    }
  }
}
