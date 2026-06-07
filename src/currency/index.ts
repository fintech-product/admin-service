import { DB, UseCase } from "onecore"
import { CurrencyController } from "./controller"
import { Currency, CurrencyFilter, CurrencyRepository, CurrencyService } from "./currency"
import { SqlCurrencyRepository } from "./repository"
export * from "./controller"
export * from "./currency"

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
