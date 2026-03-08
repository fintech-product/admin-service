import { UseCase } from "onecore"
import { DB } from "query-core"
import { TemplateMap, useQuery } from "query-mappers"
import { RoleController } from "./controller"
import { SqlRoleRepository } from "./repository"
import { Role, RoleFilter, roleModel, RoleRepository, RoleService } from "./role"
export * from "./controller"

export class RoleUseCase extends UseCase<Role, string, RoleFilter> implements RoleService {
  constructor(protected repository: RoleRepository) {
    super(repository)
  }
  all(): Promise<Role[]> {
    return this.repository.all()
  }
  assign(id: string, users: string[]): Promise<number> {
    return this.repository.assign(id, users)
  }
}

export function useRoleController(db: DB, mapper?: TemplateMap): RoleController {
  const query = useQuery("role", mapper, roleModel, true)
  const repository = new SqlRoleRepository(db, query)
  const service = new RoleUseCase(repository)
  return new RoleController(service)
}
