//
//  UserRepository.swift
//  MoviesApp
//
//  Created by User on 09/11/22.
//

import Foundation

protocol UserRepositoryProtocol {
    func getUser(viewModelCompletionHandler: @escaping (User?) -> Void)
}

final class UserRepository: UserRepositoryProtocol {
    var user = User(age: 15)
    
    func getUser(viewModelCompletionHandler: @escaping (User?) -> Void) {
        viewModelCompletionHandler(user)
    }
}
