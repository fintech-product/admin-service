import { SearchController, Search as SearchManager, useSearchController } from "express-ext"
import { Log, Search } from "onecore"
import { DB, SearchBuilder, useGet } from "query-core"
import { AuditLog, AuditLogFilter, auditLogModel } from "./audit-log"
export * from "./audit-log"

export function useAuditLogController(log: Log, db: DB): SearchManager {
  const builder = new SearchBuilder<AuditLog, AuditLogFilter>(db, "audit_logs", auditLogModel)
  const getAuditLog = useGet<AuditLog, string>(db, "audit_logs", auditLogModel)
  return useSearchController(builder.search, getAuditLog, ["status"], ["time"])
  // return new AuditLogController(builder.search);
}
export class AuditLogController extends SearchController<AuditLog, AuditLogFilter> {
  constructor(log: Log, find: Search<AuditLog, AuditLogFilter>) {
    super(log, find)
    this.array = ["status"]
    this.dates = ["time"]
  }
}
