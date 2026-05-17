import { Request, Response } from 'express';

export type Log = (msg: string) => void;
export interface User {
  step?: number;
  username: string;
  password: string;
  passcode?: string;
  ip?: string;
  device?: string;
}
export type Login = User;
export type AuthInfo = User;
export interface Privilege {
  id?: string;
  name: string;
  resource?: string;
  path?: string;
  icon?: string;
  sequence?: number;
  children?: Privilege[];
  permissions?: number;
}
export interface AuthResult<ID> {
  status: number | string;
  user?: UserAccount<ID>;
  message?: string;
}
export type Result<ID> = AuthResult<ID>;
export type LoginResult<ID> = AuthResult<ID>;
export interface UserAccount<ID> {
  id?: ID;
  username?: string;
  contact?: string;
  email?: string;
  phone?: string;
  displayName?: string;
  passwordExpiredTime?: Date;
  token?: string;
  tokenExpiredTime?: Date;
  newUser?: boolean;
  userType?: string;
  roles?: string[];
  privileges?: Privilege[];
  language?: string;
  dateFormat?: string;
  timeFormat?: string;
  gender?: string;
  imageURL?: string;
}
export class AuthenticationController<T extends User, ID> {
  constructor (public log: Log, public login: (user: T) => Promise<AuthResult<ID>>, public cookie?: boolean, public decrypt?: (cipherText: string) => string|undefined) {
    this.authenticate = this.authenticate.bind(this);
  }
  authenticate(req: Request, res: Response) {
    const user: T = req.body;
    if (!user.username || user.username.length === 0) {
      return res.status(401).end('username cannot be empty');
    }
    if (!user.password || user.password.length === 0) {
      return res.status(401).end('password cannot be empty');
    }
    if (user.step && user.step > 1 && (!user.passcode || user.passcode.length === 0)) {
      return res.status(401).end('passcode cannot be empty');
    }
    if (this.decrypt) {
      const p = this.decrypt(user.password);
      if (p === undefined) {
        return res.status(401).end('cannot decrypt password');
      } else {
        user.password = p;
      }
    }
    this.login(user).then(r => {
      const account = r.user;
      if (this.cookie && account && account.token && account.tokenExpiredTime) {
        res.status(200).cookie(
          'token', account.token,
          {
            sameSite: 'strict',
            path: '/',
            expires: account.tokenExpiredTime,
            httpOnly: true,
            secure: true,
          }).json(r).end();
      } else {
        res.status(200).json(r).end();
      }
    }).catch(err => handleError(err, res, this.log));
  }
}
export const AuthenticationHandler = AuthenticationController;
// tslint:disable-next-line:max-classes-per-file
export class PrivilegeController {
  constructor(private log: Log, public privileges: () => Promise<Privilege[]>) {
    this.all = this.all.bind(this);
  }
  all(req: Request, res: Response) {
    this.privileges().then(r => {
      res.json(r).end();
    }).catch(err => handleError(err, res, this.log));
  }
}
export const PrivilegesController = PrivilegeController;
export const PrivilegeHandler = PrivilegeController;
export const PrivilegesHandler = PrivilegeController;
export function handleError(err: any, res: Response, log?: (msg: string) => void) {
  if (log) {
    log(toString(err));
    res.status(500).end('Internal Server Error');
  } else {
    res.status(500).end(toString(err));
  }
}
export function toString(v: any): string {
  return typeof v === 'string' ? v : JSON.stringify(v);
}
