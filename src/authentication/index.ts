import { AuthResult, Privilege, User } from 'authen-service';
import { Request, Response } from 'express';
import { Log } from 'onecore';

export class AuthenticationController<T extends User, ID> {
  constructor (public log: Log, public login: (user: T) => Promise<AuthResult>, public cookie?: boolean, public decrypt?: (cipherText: string) => string|undefined) {
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
