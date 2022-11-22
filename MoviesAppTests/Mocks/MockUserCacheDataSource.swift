@testable import MoviesApp

final class MockUserCacheDataSource: UserCacheDataSourceProtocol {
    var mockUser: User?
    var saveUserCallCount = 0
    
    func getUser() -> User? {
        mockUser
    }
    
    func saveUser(user: User) {
        saveUserCallCount += 1
    }
}
