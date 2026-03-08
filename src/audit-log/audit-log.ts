import { Attributes, Filter, SearchResult, TimeRange } from "onecore"

export interface AuditLog {
  id: string
  resource: string
  userId: string
  ip: string
  action: string
  time: Date
  email: string
  status: string
  remark?: string
}
export interface AuditLogFilter extends Filter {
  id?: string
  resource?: string
  userId?: string
  ip?: string
  action?: string
  time?: TimeRange
  status?: string
}

export interface AuditLogService {
  search(filter: AuditLogFilter, limit: number, page?: number, fields?: string[]): Promise<SearchResult<AuditLog>>
  load(id: string): Promise<AuditLog | null>
}

export const auditLogModel: Attributes = {
  id: {
    key: true,
    length: 40,
  },
  resource: {
    operator: "=",
  },
  userId: {
    column: "user_id",
    required: true,
    length: 40,
    operator: "=",
  },
  ip: {},
  action: {
    operator: "=",
  },
  time: {
    type: "datetime",
  },
  status: {
    length: 1,
    operator: "=",
  },
  remark: {},
}
