import { Request, Response } from "express"
import { fromRequest, handleError, isSuccessful, respondError } from "express-ext"
import { validate } from "xvalidators"
import { getResource } from "../resources"
import { Role, RoleFilter, roleModel, RoleService } from "./role"

export class RoleController {
  constructor(private service: RoleService) {
    this.all = this.all.bind(this)
    this.search = this.search.bind(this)
    this.load = this.load.bind(this)
    this.create = this.create.bind(this)
    this.update = this.update.bind(this)
    this.patch = this.patch.bind(this)
    this.delete = this.delete.bind(this)
    this.assign = this.assign.bind(this)
  }
  async all(req: Request, res: Response) {
    try {
      const roles = await this.service.all()
      res.status(200).json(roles).end()
    } catch (err) {
      handleError(err, res)
    }
  }
  async search(req: Request, res: Response) {
    const filter = fromRequest<RoleFilter>(req, ["status"])
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
      const role = await this.service.load(id)
      res.status(role ? 200 : 404).json(role).end()
    } catch (err) {
      handleError(err, res)
    }
  }
  async create(req: Request, res: Response) {
    const userId = res.locals.account.id
    const role: Role = req.body
    role.createdBy = userId
    role.updatedBy = userId
    let language = res.locals.lang || "en"
    const resource = getResource(language)
    const errors = validate<Role>(role, roleModel, resource)
    if (errors.length > 0) {
      return respondError(res, errors)
    }
    try {
      const result = await this.service.create(role)
      const status = isSuccessful(result) ? 201 : 409
      res.status(status).json(role).end()
    } catch (err) {
      handleError(err, res)
    }
  }
  async update(req: Request, res: Response) {
    const id = req.params.id as string
    const userId = res.locals.account.id
    const role: Role = req.body
    role.roleId = id
    role.updatedBy = userId
    let language = res.locals.lang || "en"
    const resource = getResource(language)
    const errors = validate<Role>(role, roleModel, resource)
    if (errors.length > 0) {
      return respondError(res, errors)
    }
    try {
      const result = await this.service.update(role)
      const status = isSuccessful(result) ? 200 : 410
      res.status(status).json(role).end()
    } catch (err) {
      handleError(err, res)
    }
  }
  async patch(req: Request, res: Response) {
    const id = req.params.id as string
    const userId = res.locals.account.id
    const role: Role = req.body
    role.roleId = id
    role.updatedBy = userId
    let language = res.locals.lang || "en"
    const resource = getResource(language)
    const errors = validate<Role>(role, roleModel, resource, false, true)
    if (errors.length > 0) {
      return respondError(res, errors)
    }
    try {
      const result = await this.service.patch(role)
      const status = isSuccessful(result) ? 200 : 410
      res.status(status).json(role).end()
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
  async assign(req: Request, res: Response) {
    const id = req.params.id
    const users: string[] = req.body
    if (!Array.isArray(users)) {
      res.status(400).end(`Body must be an array`)
    } else {
      try {
        const result = await this.service.assign(id, users)
        res.status(200).json(result).end()
      } catch (err) {
        handleError(err, res)
      }
    }
  }
}
