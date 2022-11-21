@testable import MoviesApp
import XCTest

final class MockSaveUserUseCase: SaveUserUseCaseProtocol {
    var expectation: XCTestExpectation?
    var callCount: Int = 0
    
    func execute(user: User) {
        expectation?.fulfill()
        callCount += 1
    }
}
