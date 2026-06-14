import { UseCase } from "onecore"
import { Country, CountryFilter, CountryRepository, CountryService } from "./country"

export class CountryUseCase extends UseCase<Country, string, CountryFilter> implements CountryService {
  constructor(repository: CountryRepository) {
    super(repository)
  }
}
