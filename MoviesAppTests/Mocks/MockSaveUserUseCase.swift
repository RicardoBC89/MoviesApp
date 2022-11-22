@testable import MoviesApp
import XCTest

final class MockSaveUserUseCase: SaveUserUseCaseProtocol {
    var callCount: Int = 0
    
    func execute(user: User) {
        callCount += 1
    }
}
