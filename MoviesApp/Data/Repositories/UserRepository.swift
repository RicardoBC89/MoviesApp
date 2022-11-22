//
//  UserRepository.swift
//  MoviesApp
//
//  Created by User on 09/11/22.
//

import Foundation
import SwiftyUserDefaults

protocol UserRepositoryProtocol {
    func getUser() -> User?
    func saveUser(user:User)
}

final class UserRepository: UserRepositoryProtocol {
    
    func getUser() -> User? {
        Defaults[key: DefaultsKeys.loggedInUser]
    }
    
    func saveUser(user: User) {
        Defaults[key: DefaultsKeys.loggedInUser] = user
    }
}

extension DefaultsKeys {
    static let loggedInUser = DefaultsKey<User?>("LoggedInUser")
}
