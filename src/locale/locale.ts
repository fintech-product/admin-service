import { Attributes, Filter, SearchResult } from "onecore"

export interface Locale {
  code: string
  name?: string
  nativeName?: string
  countryCode?: string
  countryName?: string
  nativeCountryName?: string
  dateFormat?: string
  firstDayOfWeek?: number
  decimalSeparator?: string
  groupSeparator?: string
  currencyCode?: string
  currencySymbol?: string
  currencyDecimalDigits?: number
  currencyPattern?: number
  currencySample?: string
}

export interface LocaleFilter extends Filter {
  code?: string
  name?: string
  nativeName?: string
  countryCode?: string
  countryName?: string
  nativeCountryName?: string
  dateFormat: string
  firstDayOfWeek?: number
  decimalSeparator?: string
  groupSeparator?: string
  currencyCode?: string
  currencySymbol?: string
  currencyDecimalDigits?: number
  currencyPattern?: number
  currencySample?: string
}

export interface LocaleRepository {
  search(filter: LocaleFilter, limit: number, page?: number, fields?: string[]): Promise<SearchResult<Locale>>
  load(id: string): Promise<Locale | null>
  create(locale: Locale): Promise<number>
  update(locale: Locale): Promise<number>
  patch(locale: Partial<Locale>): Promise<number>
  delete(id: string): Promise<number>
}
export interface LocaleService {
  search(filter: LocaleFilter, limit: number, page?: number, fields?: string[]): Promise<SearchResult<Locale>>
  load(id: string): Promise<Locale | null>
  create(locale: Locale): Promise<number>
  update(locale: Locale): Promise<number>
  patch(locale: Partial<Locale>): Promise<number>
  delete(id: string): Promise<number>
}

export const localeModel: Attributes = {
  code: {
    key: true,
    length: 40,
  },
  name: {
    length: 255,
  },
  nativeName: {
    column: "native_name",
    length: 255,
  },
  countryCode: {
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
  dateFormat: {
    column: "date_format",
    length: 14,
  },
  firstDayOfWeek: {
    column: "first_day_of_week",
    type: "integer",
    operator: "=",
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
    operator: "=",
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
