import { merge } from "config-plus"
import dotenv from "dotenv"
import express, { json } from "express"
import { allow, loadTemplates, MiddlewareLogger, resources } from "express-ext"
import http from "http"
import { createLogger } from "logger-core"
import { Pool } from "pg"
import { PoolManager } from "pg-extension"
import { buildTemplates, trim } from "query-mappers"
import { config, env } from "./config"
import { useContext } from "./context"
import { route, TokenVerifier } from "./route"

dotenv.config()
const cfg = merge(config, process.env, env, process.env.ENV)

const app = express()
const logger = createLogger(cfg.log)
resources.log = logger.error

const middleware = new MiddlewareLogger(logger.info, cfg.middleware)
app.use(allow(cfg.allow), json())

const verifier = new TokenVerifier(cfg.auth.token.secret, "account", "userId", "id")
app.use(verifier.verify)

const templates = loadTemplates(cfg.template, buildTemplates, trim, ["./config/query.xml"])
const pool = new Pool(cfg.db)
const db = new PoolManager(pool)
const ctx = useContext(db, logger, middleware, cfg, templates)
route(app, ctx)
http.createServer(app).listen(cfg.port, () => {
  console.log("Start server at port " + cfg.port)
})
