import { Request, Response } from "express"
import { query } from "express-core-web"
import { getLocale, usLocale } from "locale-service"
import { en as adminEN } from "./admin/en"
import { vi as adminVI } from "./admin/vi"
import { en as authenticationEN } from "./authentication/en"
import { vi as authenticationVI } from "./authentication/vi"
import { en as countryEN } from "./country/en"
import { vi as countryVI } from "./country/vi"
import { en as commonEN } from "./en"
import { vi as commonVI } from "./vi"

export interface StringMap {
  [key: string]: string
}
export interface Resources {
  [key: string]: StringMap
}

const en: StringMap = {
  ...commonEN,
  ...authenticationEN,
  ...adminEN,
  ...countryEN,
}
const vi: StringMap = {
  ...commonVI,
  ...authenticationVI,
  ...adminVI,
  ...countryVI,
}

export const resources: Resources = {
  en: en,
  vi: vi,
}

export function getDateFormat(lang?: string): string {
  if (!lang) {
    return usLocale.dateFormat
  }
  const locale = getLocale(lang) || usLocale
  return locale.dateFormat
}
export function getLang(req: Request, res: Response): string {
  let lang = res.locals.lang
  if (!lang) {
    lang = query(req, "lang")
    if (lang !== "vi") {
      lang = "en"
    }
  }
  return lang
}
export function getResource(lang: string | Request): StringMap {
  if (lang) {
    if (typeof lang === "string") {
      const r = resources[lang]
      if (r) {
        return r
      }
    } else {
      const l = query(lang, "lang")
      if (l) {
        const r = resources[l]
        if (r) {
          return r
        }
      }
    }
  }
  return resources["en"]
}
export function getResourceByLang(lang: string): StringMap {
  if (lang) {
    const r = resources[lang]
    if (r) {
      return r
    }
  }
  return resources["en"]
}
