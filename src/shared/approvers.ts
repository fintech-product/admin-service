import { ApproversPort, DB } from "onecore"

interface ID {
  id: string
}
export class ApproversAdapter implements ApproversPort {
  constructor(protected db: DB, protected entity: string) {
    this.getApprovers = this.getApprovers.bind(this)
  }
  getApprovers(): Promise<string[]> {
    const query = `
      select
        distinct ur.user_id as id
      from role_modules r
        join user_roles ur on ur.role_id = r.role_id
        join users u on u.user_id = ur.user_id
      where
        r.module_id = ${this.db.param(1)}
        and (r.permissions & 9) = 9
        and u.status = 'A'`
    return this.db.query<ID>(query, [this.entity]).then((v) => v.map(({ id }) => id))
  }
}
