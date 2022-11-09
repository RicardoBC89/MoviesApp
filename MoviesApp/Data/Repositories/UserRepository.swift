//
//  UserRepository.swift
//  MoviesApp
//
//  Created by User on 09/11/22.
//

import Foundation

final class UserRepository {
    var user = User(age: 15)
    
    func getUser(viewModelCompletionHandler: @escaping (User?) -> Void) {
        viewModelCompletionHandler(user)
    }
}
