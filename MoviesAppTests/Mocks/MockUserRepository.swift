@testable import MoviesApp
import XCTest

final class MockUserRepository: UserRepositoryProtocol {
    var mockUser: User? = nil
    
    func getUser() -> User? {
       mockUser
    }
    
    func saveUser(user: User) {
    }
}
