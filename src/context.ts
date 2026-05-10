import { AuthenticationController, PrivilegeController } from "authen-express"
import { Authenticator, initializeStatus, PrivilegeRepository, PrivilegesReader, SqlAuthConfig, User, useUserRepository } from "authen-service"
import { compare, hash } from "bcryptjs"
import { HealthController, LogController, Logger, Middleware, MiddlewareController, resources } from "express-core-web"
import { buildJwtError, generateToken, Payload, verify } from "jsonwebtoken-plus"
import { StringMap } from "onecore"
import { TemplateMap } from "query-mappers"
import { Authorize, Authorizer, PrivilegeLoader, useToken } from "security-express"
import { createChecker, DB } from "sql-core"
import { check } from "types-validation"
import { createValidator } from "validation-core"
import { AuditLogController, useAuditLogController } from "./audit-log"
import { CountryController, useCountryController } from "./country"
import { CurrencyController, useCurrencyController } from "./currency"
import { LocaleController, useLocaleController } from "./locale"
import { RoleController, useRoleController } from "./role"
import { UserController, useUserController } from "./user"

resources.createValidator = createValidator
resources.check = check

export interface Config {
  cookie?: boolean
  auth: SqlAuthConfig
  map: StringMap
  sql: {
    allPrivileges: string
    privileges: string
    permission: string
  }
}

export interface ApplicationContext {
  health: HealthController
  log: LogController
  middleware: MiddlewareController
  authorize: Authorize
  authentication: AuthenticationController<User, string>
  privilege: PrivilegeController
  role: RoleController
  user: UserController
  auditLog: AuditLogController
  locale: LocaleController
  country: CountryController
  currency: CurrencyController
}

export class Comparator {
  constructor(saltOrRounds?: string | number) {
    this.saltOrRounds = (saltOrRounds ? saltOrRounds : 10);
    this.compare = this.compare.bind(this);
    this.hash = this.hash.bind(this);
  }
  saltOrRounds: string | number;
  compare(data: string, encrypted: string): Promise<boolean> {
    return compare(data, encrypted);
  }
  hash(data: string): Promise<string> {
    return hash(data, this.saltOrRounds);
  }
}

export function useContext(db: DB, logger: Logger, midLogger: Middleware, cfg: Config, mapper?: TemplateMap): ApplicationContext {
  const log = new LogController(logger)
  const middleware = new MiddlewareController(midLogger)
  const sqlChecker = createChecker(db)
  const health = new HealthController([sqlChecker])

  const auth = cfg.auth
  const privilegeLoader = new PrivilegeLoader(cfg.sql.permission, db.query)
  const token = useToken<Payload>(auth.token.secret, verify, buildJwtError, cfg.cookie)
  const authorizer = new Authorizer<Payload>(token, privilegeLoader.privilege, buildJwtError, true)

  const status = initializeStatus(auth.status)
  const privilegeRepository = new PrivilegeRepository(db.query, cfg.sql.privileges)
  const userRepository = useUserRepository<string, SqlAuthConfig>(db, auth, cfg.map)
  const authenticator = new Authenticator(
    status,
    compare,
    generateToken,
    auth.token,
    auth.payload,
    auth.account,
    userRepository,
    privilegeRepository.privileges,
    auth.lockedMinutes,
    auth.maxPasswordFailed,
  )
  const authentication = new AuthenticationController(logger.error, authenticator.authenticate, cfg.cookie)
  const privilegesLoader = new PrivilegesReader(db.query, cfg.sql.allPrivileges)
  const privilege = new PrivilegeController(logger.error, privilegesLoader.privileges)

  const role = useRoleController(db, mapper)
  const user = useUserController(db, mapper)
  const auditLog = useAuditLogController(db)

  const locale = useLocaleController(db)
  const country = useCountryController(db)
  const currency = useCurrencyController(db)

  return { health, log, middleware, authorize: authorizer.authorize, authentication, privilege, role, user, auditLog, locale, country, currency }
}
