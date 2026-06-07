import { DB } from "onecore"
import { Repository } from "sql-core"
import { Currency, CurrencyFilter, currencyModel, CurrencyRepository } from "./currency"

export class SqlCurrencyRepository extends Repository<Currency, string, CurrencyFilter> implements CurrencyRepository {
  constructor(db: DB) {
    super(db, "currency", currencyModel)
  }
}
