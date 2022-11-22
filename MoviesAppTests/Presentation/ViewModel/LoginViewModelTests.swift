//
//  LoginViewModelTests.swift
//  MoviesAppTests
//
//  Created by User on 21/11/22.
//

import XCTest
@testable import MoviesApp

class LoginViewModelTests: XCTestCase {
    private var mockSaveUserUseCase: MockSaveUserUseCase!
    private var viewModel: LoginViewModel!
    
    override func setUp() {
        mockSaveUserUseCase = MockSaveUserUseCase()
        viewModel = LoginViewModel(saveUserUseCase: mockSaveUserUseCase)
    }
    
    func testIfSaveUserUseCaseIsCalled() {
        // Prepare
        mockSaveUserUseCase.callCount = 0
        
        // Execute
        viewModel.saveUser(age: "10")
        
        // Assert
        XCTAssertEqual(mockSaveUserUseCase.callCount, 1)
    }
}
