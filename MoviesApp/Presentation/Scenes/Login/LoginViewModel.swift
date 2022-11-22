//
//  LoginViewModel.swift
//  MoviesApp
//
//  Created by User on 21/11/22.
//

import UIKit

class LoginViewModel: NSObject {
    private let saveUserUseCase: SaveUserUseCaseProtocol
    
    init(saveUserUseCase: SaveUserUseCaseProtocol = SaveUserUseCase()) {
        self.saveUserUseCase = saveUserUseCase
    }
    
    func saveUser(age: String) {
        guard let ageInt = Int(age) else {
                    return
                }
        let user = User(age: ageInt)
        saveUserUseCase.execute(user: user)
    }
}
