@testable import MoviesApp
import XCTest

final class MockUserRepository: UserRepositoryProtocol {
    var mockUser: User? = nil
    var expectation: XCTestExpectation?
    var error: Error?
    
    func getUser(viewModelCompletionHandler completionHandler: @escaping (User?) -> Void) {
        expectation?.fulfill()
        if error != nil {
            completionHandler(nil)
        } else {
            completionHandler(mockUser)
        }
    }
}
