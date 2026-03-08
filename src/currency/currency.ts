import { Attributes, Filter, SearchResult } from "onecore"

export class Status {
  static readonly Draft = 'D'
  static readonly Submitted = 'S'
  static readonly Approved = 'A'
}

export interface Currency {
  code: string
  symbol?: string
  decimalDigits?: number
  status?: string
}
export interface CurrencyFilter extends Filter {
  code?: string
  symbol?: string
  decimalDigits?: number
  status?: string[]
}

export interface CurrencyRepository {
  search(filter: CurrencyFilter, limit: number, page?: number, fields?: string[]): Promise<SearchResult<Currency>>
  load(id: string): Promise<Currency | null>
  create(currency: Currency): Promise<number>
  update(currency: Currency): Promise<number>
  patch(currency: Partial<Currency>): Promise<number>
  delete(id: string): Promise<number>
}
export interface CurrencyService {
  search(filter: CurrencyFilter, limit: number, page?: number, fields?: string[]): Promise<SearchResult<Currency>>
  load(id: string): Promise<Currency | null>
  create(currency: Currency): Promise<number>
  update(currency: Currency): Promise<number>
  patch(currency: Partial<Currency>): Promise<number>
  delete(id: string): Promise<number>
}

export const currencyModel: Attributes = {
  code: {
    key: true,
    length: 3,
  },
  symbol: {
    length: 6,
    operator: "=",
  },
  decimalDigits: {
    column: "decimal_digits",
    type: "integer",
    operator: "=",
  },
}
