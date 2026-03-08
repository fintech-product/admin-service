import { nanoid } from "nanoid"
import { UseCase } from "onecore"
import { DB } from "query-core"
import { TemplateMap } from "query-mappers"
import { UserController } from "./controller"
import { SqlUserRepository } from "./repository"
import { User, UserFilter, UserRepository, UserService } from "./user"

export * from "./controller"

export class UserUseCase extends UseCase<User, string, UserFilter> implements UserService {
  constructor(protected repository: UserRepository) {
    super(repository)
    this.create = this.create.bind(this);
  }
  all(): Promise<User[]> {
    return this.repository.all()
  }
  create(user: User): Promise<number> {
    user.userId = nanoid(10)
    return this.repository.create(user)
  }
  getUsersOfRole(roleId: string): Promise<User[]> {
    return this.repository.getUsersOfRole(roleId)
  }
  assign(id: string, roles: string[]): Promise<number> {
    return this.repository.assign(id, roles)
  }
}

export function useUserController(db: DB, mapper?: TemplateMap): UserController {
  // const query = useQuery("user", mapper, userModel, true)
  const repo = new SqlUserRepository(db)
  const service = new UserUseCase(repo)
  return new UserController(service)
}
