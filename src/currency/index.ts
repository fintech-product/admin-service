import { UseCase } from "onecore"
import { DB, Repository } from "query-core"
import { CurrencyController } from "./controller"
import { Currency, CurrencyFilter, currencyModel, CurrencyRepository, CurrencyService } from "./currency"
export * from "./controller"
export * from "./currency"

export class SqlCurrencyRepository extends Repository<Currency, string, CurrencyFilter> implements CurrencyRepository {
  constructor(db: DB) {
    super(db, "currency", currencyModel)
  }
}
export class CurrencyUseCase extends UseCase<Currency, string, CurrencyFilter> implements CurrencyService {
  constructor(repository: CurrencyRepository) {
    super(repository)
  }
}

export function useCurrencyController(db: DB): CurrencyController {
  const repository = new SqlCurrencyRepository(db)
  const service = new CurrencyUseCase(repository)
  return new CurrencyController(service)
}
