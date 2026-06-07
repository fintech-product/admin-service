import { DB } from "onecore"
import { Repository } from "sql-core"
import { Country, CountryFilter, countryModel, CountryRepository } from "./country"
export * from "./controller"
export * from "./country"

export class SqlCountryRepository extends Repository<Country, string, CountryFilter> implements CountryRepository {
  constructor(db: DB) {
    super(db, "country", countryModel)
  }
}
