import { DB, UseCase } from "onecore"
import { CountryController } from "./controller"
import { Country, CountryFilter, CountryRepository, CountryService } from "./country"
import { SqlCountryRepository } from "./repository"
export * from "./controller"
export * from "./country"

export class CountryUseCase extends UseCase<Country, string, CountryFilter> implements CountryService {
  constructor(repository: CountryRepository) {
    super(repository)
  }
}

export function useCountryController(db: DB): CountryController {
  const repository = new SqlCountryRepository(db)
  const service = new CountryUseCase(repository)
  return new CountryController(service)
}
