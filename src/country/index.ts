import { UseCase } from "onecore"
import { DB, Repository } from "query-core"
import { CountryController } from "./controller"
import { Country, CountryFilter, CountryRepository, CountryService, countryModel } from "./country"
export * from "./controller"
export * from "./country"

export class SqlCountryRepository extends Repository<Country, string, CountryFilter> implements CountryRepository {
  constructor(db: DB) {
    super(db, "country", countryModel)
  }
}
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
