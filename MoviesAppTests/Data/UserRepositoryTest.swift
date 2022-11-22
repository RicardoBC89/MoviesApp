//
//  UserRepositoryTest.swift
//  MoviesAppTests
//
//  Created by User on 22/11/22.
//

import XCTest
@testable import MoviesApp

class UserRepositoryTest: XCTestCase {
   private var userRepository: UserRepository!
   private var mockUserCacheDataSource: MockUserCacheDataSource!
    
    override func setUp() {
        super.setUp()
        mockUserCacheDataSource = MockUserCacheDataSource()
        userRepository = UserRepository(userCacheDataSource: mockUserCacheDataSource)
    }
    
    func testIfUserIsSaved() {
        // Prepare
        let mockUser = User(age: 20)
        mockUserCacheDataSource.mockUser = mockUser
        mockUserCacheDataSource.saveUserCallCount = 0
        
        // Execute
        userRepository.saveUser(user: mockUser)
        
        // Assert
        XCTAssertEqual(userRepository.getUser(), mockUser)
        XCTAssertEqual(mockUserCacheDataSource.saveUserCallCount, 1)
    }
}
