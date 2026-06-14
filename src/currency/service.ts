import { UseCase } from "onecore"
import { Currency, CurrencyFilter, CurrencyRepository, CurrencyService } from "./currency"

export class CurrencyUseCase extends UseCase<Currency, string, CurrencyFilter> implements CurrencyService {
  constructor(repository: CurrencyRepository) {
    super(repository)
  }
}
