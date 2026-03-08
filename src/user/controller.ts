import { Request, Response } from "express"
import { fromRequest, handleError, isSuccessful, queryParam, respondError } from "express-ext"
import { validate } from "xvalidators"
import { getResource } from "../resources"
import { User, UserFilter, userModel, UserService } from "./user"

export class UserController {
  constructor(protected service: UserService) {
    this.all = this.all.bind(this)
    this.search = this.search.bind(this)
    this.load = this.load.bind(this)
    this.create = this.create.bind(this)
    this.update = this.update.bind(this)
    this.patch = this.patch.bind(this)
    this.delete = this.delete.bind(this)
    this.getUsersOfRole = this.getUsersOfRole.bind(this)
  }
  async all(req: Request, res: Response) {
    const roleId = req.query.roleId as string
    try {
      if (roleId) {
        const users = await this.service.getUsersOfRole(roleId)
        res.status(200).json(users).end()
      } else {
        const users = await this.service.all()
        res.status(200).json(users).end()
      }
    } catch (err) {
      handleError(err, res)
    }
  }
  async search(req: Request, res: Response) {
    const filter = fromRequest<UserFilter>(req, ["status", "excluding"])
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
      const user = await this.service.load(id)
      res.status(user ? 200 : 404).json(user).end()
    } catch (err) {
      handleError(err, res)
    }
  }
  async create(req: Request, res: Response) {
    const userId = res.locals.account.id
    const user: User = req.body
    user.createdBy = userId
    user.updatedBy = userId
    let language = res.locals.lang || "en"
    const resource = getResource(language)
    const errors = validate<User>(user, userModel, resource, true)
    if (errors.length > 0) {
      return respondError(res, errors)
    }
    try {
      const result = await this.service.create(user)
      const status = isSuccessful(result) ? 201 : 409
      res.status(status).json(user).end()
    } catch (err) {
      handleError(err, res)
    }
  }
  async update(req: Request, res: Response) {
    const id = req.params.id as string
    const userId = res.locals.account.id
    const user: User = req.body
    user.userId = id
    user.updatedBy = userId
    let language = res.locals.lang || "en"
    const resource = getResource(language)
    const errors = validate<User>(user, userModel, resource, true)
    if (errors.length > 0) {
      return respondError(res, errors)
    }
    try {
      const result = await this.service.update(user)
      const status = isSuccessful(result) ? 200 : 410
      res.status(status).json(user).end()
    } catch (err) {
      handleError(err, res)
    }
  }
  async patch(req: Request, res: Response) {
    const id = req.params.id as string
    const userId = res.locals.account.id
    const user: User = req.body
    user.userId = id
    user.updatedBy = userId
    let language = res.locals.lang || "en"
    const resource = getResource(language)
    const errors = validate<User>(user, userModel, resource, true, true)
    if (errors.length > 0) {
      return respondError(res, errors)
    }
    try {
      const result = await this.service.patch(user)
      const status = isSuccessful(result) ? 200 : 410
      res.status(status).json(user).end()
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
  async getUsersOfRole(req: Request, res: Response) {
    const roleId = queryParam(req, res, "roleId")
    if (roleId) {
      try {
        const users = await this.service.getUsersOfRole(roleId)
        res.status(200).json(users).end()
      } catch (err) {
        handleError(err, res)
      }
    }
  }
}
