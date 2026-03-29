import { UseCase } from "onecore"
import { DB } from "query-core"
import { TemplateMap, useQuery } from "query-mappers"
import { UserController } from "./controller"
import { SqlUserRepository } from "./repository"
import { User, UserFilter, userModel, UserRepository, UserService } from "./user"

export * from "./controller"

export class UserUseCase extends UseCase<User, string, UserFilter> implements UserService {
  constructor(protected repository: UserRepository) {
    super(repository)
  }
  all(): Promise<User[]> {
    return this.repository.all()
  }
  getUsersOfRole(roleId: string): Promise<User[]> {
    return this.repository.getUsersOfRole(roleId)
  }
  assign(id: string, roles: string[]): Promise<number> {
    return this.repository.assign(id, roles)
  }
}

export function useUserController(db: DB, mapper?: TemplateMap): UserController {
  const query = useQuery("user", mapper, userModel, true)
  const repo = new SqlUserRepository(db, query)
  const service = new UserUseCase(repo)
  return new UserController(service)
}
