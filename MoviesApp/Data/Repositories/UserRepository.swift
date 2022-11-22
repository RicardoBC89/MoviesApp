//
//  UserRepository.swift
//  MoviesApp
//
//  Created by User on 09/11/22.
//

import Foundation

protocol UserRepositoryProtocol {
    func getUser() -> User?
    func saveUser(user:User)
}

final class UserRepository: UserRepositoryProtocol {
    var userCacheDataSource: UserCacheDataSourceProtocol
    
    init(userCacheDataSource: UserCacheDataSourceProtocol = UserCacheDataSource()) {
        self.userCacheDataSource = userCacheDataSource
        
    }
    
    func getUser() -> User? {
        userCacheDataSource.getUser()
    }
    
    func saveUser(user: User) {
        userCacheDataSource.saveUser(user: user)
    }
}
