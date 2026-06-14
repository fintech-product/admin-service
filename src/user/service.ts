import { UseCase } from "onecore"
import { User, UserFilter, UserRepository, UserService } from "./user"

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
