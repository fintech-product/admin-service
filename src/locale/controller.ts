import { Request, Response } from "express"
import { format, fromRequest, handleError, isSuccessful, respondError } from "express-ext"
import { validate } from "xvalidators"
import { getResource } from "../resources"
import { Locale, LocaleFilter, localeModel, LocaleService } from "./locale"

export class LocaleController {
  constructor(private service: LocaleService) {
    this.search = this.search.bind(this)
    this.load = this.load.bind(this)
    this.create = this.create.bind(this)
    this.update = this.update.bind(this)
    this.patch = this.patch.bind(this)
    this.delete = this.delete.bind(this)
  }
  async search(req: Request, res: Response) {
    const filter = fromRequest<LocaleFilter>(req, ["status"])
    format(filter, undefined, ["firstDayOfWeek", "currencyDecimalDigits", "currencyPattern"])
    if (!filter.sort) {
      filter.sort = "code"
    }
    const { limit, page, fields } = filter
    try {
      const result = await this.service.search(filter, limit, page, fields)
      res.status(200).json(result)
    } catch (err) {
      handleError(err, res)
    }
  }
  async load(req: Request, res: Response) {
    const id = req.params.id as string
    try {
      const locale = await this.service.load(id)
      res.status(locale ? 200 : 404).json(locale).end()
    } catch (err) {
      handleError(err, res)
    }
  }
  async create(req: Request, res: Response) {
    const userId = res.locals.account.id
    const locale: Locale = req.body
    let language = res.locals.lang || "en"
    const resource = getResource(language)
    const errors = validate<Locale>(locale, localeModel, resource)
    if (errors.length > 0) {
      return respondError(res, errors)
    }
    try {
      const result = await this.service.create(locale)
      const status = isSuccessful(result) ? 201 : 409
      res.status(status).json(locale).end()
    } catch (err) {
      handleError(err, res)
    }
  }
  async update(req: Request, res: Response) {
    const id = req.params.id as string
    const userId = res.locals.account.id
    const locale: Locale = req.body
    let language = res.locals.lang || "en"
    const resource = getResource(language)
    const errors = validate<Locale>(locale, localeModel, resource)
    if (errors.length > 0) {
      return respondError(res, errors)
    }
    try {
      const result = await this.service.update(locale)
      const status = isSuccessful(result) ? 200 : 410
      res.status(status).json(locale).end()
    } catch (err) {
      handleError(err, res)
    }
  }
  async patch(req: Request, res: Response) {
    const id = req.params.id as string
    const userId = res.locals.account.id
    const locale: Locale = req.body
    let language = res.locals.lang || "en"
    const resource = getResource(language)
    const errors = validate<Locale>(locale, localeModel, resource, false, true)
    if (errors.length > 0) {
      return respondError(res, errors)
    }
    try {
      const result = await this.service.update(locale)
      const status = isSuccessful(result) ? 200 : 410
      res.status(status).json(locale).end()
    } catch (err) {
      handleError(err, res)
    }
  }
  async delete(req: Request, res: Response) {
    const id = req.params.id as string
    try {
      const result = await this.service.delete(id)
      res.status(result > 0 ? 200 : 410).json(result).end()
    } catch (err) {
      handleError(err, res)
    }
  }
}
