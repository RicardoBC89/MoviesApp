
import Foundation
import SwiftyUserDefaults

protocol UserCacheDataSourceProtocol {
    func getUser() -> User?
    func saveUser(user:User)
}

final class UserCacheDataSource: UserCacheDataSourceProtocol {
    
    func getUser() -> User? {
        Defaults[key: DefaultsKeys.loggedInUser]
    }
    
    func saveUser(user: User) {
        Defaults[key: DefaultsKeys.loggedInUser] = user
    }
    
    func deleteUserCache() {
      Defaults.remove(DefaultsKeys.loggedInUser)
    }
}

extension DefaultsKeys {
    static let loggedInUser = DefaultsKey<User?>("LoggedInUser")
}
