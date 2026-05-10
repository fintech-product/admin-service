import { DB, Repository } from "sql-core"
import { Locale, LocaleFilter, localeModel, LocaleRepository } from "./locale"
export * from "./controller"
export * from "./locale"

export class SqlLocaleRepository extends Repository<Locale, string, LocaleFilter> implements LocaleRepository {
  constructor(db: DB) {
    super(db, "locale", localeModel)
  }
}
