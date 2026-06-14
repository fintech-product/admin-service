import { UseCase } from "onecore"
import { Locale, LocaleFilter, LocaleRepository, LocaleService } from "./locale"

export class LocaleUseCase extends UseCase<Locale, string, LocaleFilter> implements LocaleService {
  constructor(repository: LocaleRepository) {
    super(repository)
  }
}
