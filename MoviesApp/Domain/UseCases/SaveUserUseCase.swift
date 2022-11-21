protocol SaveUserUseCaseProtocol {
    func execute(user: User)
}

final class SaveUserUseCase: SaveUserUseCaseProtocol {
    private let userRepository: UserRepositoryProtocol
    
    init(userRepository: UserRepositoryProtocol = UserRepository()) {
        self.userRepository = userRepository
    }
    
    
    func execute(user: User) {
        userRepository.saveUser(user: user)
    }
}
