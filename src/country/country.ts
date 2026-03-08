import { Attributes, Filter, SearchResult } from "onecore"

export interface Country {
  countryCode: string
  countryName?: string
  nativeCountryName?: string
  decimalSeparator?: string
  groupSeparator?: string
  currencyCode?: string
  currencySymbol?: string
  currencyDecimalDigits?: number
  currencyPattern?: number
  currencySample?: string
  status?: string
}
export interface CountryFilter extends Filter {
  countryCode?: string
  countryName?: string
  nativeCountryName?: string
  decimalSeparator?: string
  groupSeparator?: string
  currencyCode?: string
  currencySymbol?: string
  currencyDecimalDigits?: number
  currencyPattern?: number
  currencySample?: string
  status?: string
}

export interface CountryRepository {
  search(filter: CountryFilter, limit: number, page?: number, fields?: string[]): Promise<SearchResult<Country>>
  load(id: string): Promise<Country | null>
  create(country: Country): Promise<number>
  update(country: Country): Promise<number>
  patch(country: Partial<Country>): Promise<number>
  delete(id: string): Promise<number>
}
export interface CountryService {
  search(filter: CountryFilter, limit: number, page?: number, fields?: string[]): Promise<SearchResult<Country>>
  load(id: string): Promise<Country | null>
  create(country: Country): Promise<number>
  update(country: Country): Promise<number>
  patch(country: Partial<Country>): Promise<number>
  delete(id: string): Promise<number>
}

export const countryModel: Attributes = {
  countryCode: {
    key: true,
    column: "country_code",
    length: 5,
  },
  countryName: {
    column: "country_name",
    length: 255,
  },
  nativeCountryName: {
    column: "native_country_name",
    length: 255,
  },
  decimalSeparator: {
    column: "decimal_separator",
    length: 3,
    operator: "=",
  },
  groupSeparator: {
    column: "group_separator",
    length: 3,
    operator: "=",
  },
  currencyCode: {
    column: "currency_code",
    length: 3,
  },
  currencySymbol: {
    column: "currency_symbol",
    length: 6,
  },
  currencyDecimalDigits: {
    column: "currency_decimal_digits",
    type: "integer",
    operator: "=",
  },
  currencyPattern: {
    column: "currency_pattern",
    type: "integer",
    operator: "=",
  },
  currencySample: {
    column: "currency_sample",
    length: 40,
  },
}
