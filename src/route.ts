import { Application, NextFunction, Request, Response } from "express"
import { verify } from "jsonwebtoken"
import multer from "multer"
import { read, write } from "security-express"
import { ApplicationContext } from "./context"

export const approve = 8

const prefix = "Bearer "
export class TokenVerifier {
  constructor(
    private secret: string,
    private account: string,
    private userId: string,
    private id: string,
  ) {
    this.verify = this.verify.bind(this)
  }
  verify(req: Request, res: Response, next: NextFunction) {
    const data = req.headers["authorization"]
    if (data && data.startsWith(prefix)) {
      const token = data.substring(prefix.length)
      verify(token, this.secret, (err, decoded) => {
        if (err) {
          next()
        } else {
          res.locals[this.account] = decoded
          res.locals[this.userId] = (decoded as any)[this.id]
          next()
        }
      })
    } else {
      next()
    }
  }
}

export function route(app: Application, ctx: ApplicationContext, secure?: boolean): void {
  const parser = multer()
  app.get("/health", ctx.health.check)
  app.patch("/log", ctx.log.config)
  app.patch("/middleware", ctx.middleware.config)
  app.post("/authenticate", parser.none(), ctx.authentication.authenticate)

  const readRole = ctx.authorize("role", read)
  const writeRole = ctx.authorize("role", write)
  app.get("/privileges", readRole, ctx.privilege.all)
  app.put("/roles/:id/assign", writeRole, ctx.role.assign)
  app.post("/roles/search", readRole, ctx.role.search)
  app.get("/roles/search", readRole, ctx.role.search)
  app.get("/roles/:id", readRole, ctx.role.load)
  app.post("/roles", writeRole, ctx.role.create)
  app.put("/roles/:id", writeRole, ctx.role.update)
  app.patch("/roles/:id", writeRole, ctx.role.patch)
  app.delete("/roles/:id", writeRole, ctx.role.delete)

  const readUser = ctx.authorize("user", read)
  const writeUser = ctx.authorize("user", write)
  app.get("/roles", readUser, ctx.role.all)
  app.get("/users", readUser, ctx.user.getUsersOfRole)
  app.post("/users/search", readUser, ctx.user.search)
  app.get("/users/search", readUser, ctx.user.search)
  app.get("/users/:id", readUser, ctx.user.load)
  app.post("/users", writeUser, ctx.user.create)
  app.put("/users/:id", writeUser, ctx.user.update)
  app.patch("/users/:id", writeUser, ctx.user.patch)
  app.delete("/users/:id", writeUser, ctx.user.delete)

  const readAuditLog = ctx.authorize("audit_log", read)
  app.get("/audit-logs", readAuditLog, ctx.auditLog.search)
  app.post("/audit-logs/search", readAuditLog, ctx.auditLog.search)
  app.get("/audit-logs/search", readAuditLog, ctx.auditLog.search)

  const readCurrency = ctx.authorize("currency", read)
  const writeCurrency = ctx.authorize("currency", write)
  app.post("/currencies/search", readCurrency, ctx.currency.search)
  app.get("/currencies/search", readCurrency, ctx.currency.search)
  app.get("/currencies/:id", readCurrency, ctx.currency.load)
  app.post("/currencies", writeCurrency, ctx.currency.create)
  app.put("/currencies/:id", writeCurrency, ctx.currency.update)
  app.patch("/currencies/:id", writeCurrency, ctx.currency.patch)
  app.delete("/currencies/:id", writeCurrency, ctx.currency.delete)

  const readCountry = ctx.authorize("country", read)
  const writeCountry = ctx.authorize("country", write)
  app.post("/countries/search", readCountry, ctx.country.search)
  app.get("/countries/search", readCountry, ctx.country.search)
  app.get("/countries/:id", readCountry, ctx.country.load)
  app.post("/countries", writeCountry, ctx.country.create)
  app.put("/countries/:id", writeCountry, ctx.country.update)
  app.patch("/countries/:id", writeCountry, ctx.country.patch)
  app.delete("/countries/:id", writeCountry, ctx.country.delete)

  const readLocale = ctx.authorize("locale", read)
  const writeLocale = ctx.authorize("locale", write)
  app.post("/locales/search", readLocale, ctx.locale.search)
  app.get("/locales/search", readLocale, ctx.locale.search)
  app.get("/locales/:id", readLocale, ctx.locale.load)
  app.post("/locales", writeLocale, ctx.locale.create)
  app.put("/locales/:id", writeLocale, ctx.locale.update)
  app.patch("/locales/:id", writeLocale, ctx.locale.patch)
  app.delete("/locales/:id", writeLocale, ctx.locale.delete)
}
