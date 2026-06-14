import { DB } from "sql-core"
import { LocaleController } from "./controller"
import { SqlLocaleRepository } from "./repository"
import { LocaleUseCase } from "./service"
export * from "./controller"
export * from "./locale"

export function useLocaleController(db: DB): LocaleController {
  const repository = new SqlLocaleRepository(db)
  const service = new LocaleUseCase(repository)
  return new LocaleController(service)
}
