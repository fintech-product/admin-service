import { DB } from "onecore"
import { CurrencyController } from "./controller"
import { SqlCurrencyRepository } from "./repository"
import { CurrencyUseCase } from "./service"
export * from "./controller"
export * from "./currency"

export function useCurrencyController(db: DB): CurrencyController {
  const repository = new SqlCurrencyRepository(db)
  const service = new CurrencyUseCase(repository)
  return new CurrencyController(service)
}
