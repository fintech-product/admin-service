import { UseCase } from "onecore"
import { DB, Repository } from "query-core"
import { LocaleController } from "./controller"
import { Locale, LocaleFilter, localeModel, LocaleRepository, LocaleService } from "./locale"
export * from "./controller"
export * from "./locale"

export class SqlLocaleRepository extends Repository<Locale, string, LocaleFilter> implements LocaleRepository {
  constructor(db: DB) {
    super(db, "locale", localeModel)
  }
}
export class LocaleUseCase extends UseCase<Locale, string, LocaleFilter> implements LocaleService {
  constructor(repository: LocaleRepository) {
    super(repository)
  }
}

export function useLocaleController(db: DB): LocaleController {
  const repository = new SqlLocaleRepository(db)
  const service = new LocaleUseCase(repository)
  return new LocaleController(service)
}
