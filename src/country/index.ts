import { DB } from "onecore"
import { CountryController } from "./controller"
import { SqlCountryRepository } from "./repository"
import { CountryUseCase } from "./service"
export * from "./controller"
export * from "./country"

export function useCountryController(db: DB): CountryController {
  const repository = new SqlCountryRepository(db)
  const service = new CountryUseCase(repository)
  return new CountryController(service)
}
