//
//  GetMoviesUseCaseTest.swift
//  MoviesAppTests
//
//  Created by User on 10/11/22.
//

import XCTest
@testable import MoviesApp

final class GetMoviesUseCaseTest: XCTestCase {
    private var mockMoviesRepository: MockMoviesRepository!
    private var getMoviesUseCase: GetMoviesUseCase!
    private var mockUserRepository: MockUserRepository!
    
    private let page1: [Movie] = [
        Movie(titulo: "Superman", ano: "2020", caminhoIMG: "", adult: true),
        Movie(titulo: "Batman", ano: "2018", caminhoIMG: ""),
        Movie(titulo: "Aquaman", ano: "2022", caminhoIMG: "")
    ]
    private let page2 = [
        Movie(titulo: "Superman 2", ano: "2022", caminhoIMG: ""),
        Movie(titulo: "Batman 2", ano: "2020", caminhoIMG: ""),
        Movie(titulo: "Aquaman 2", ano: "2024", caminhoIMG: "")
    ]
    
    
    override func setUp()  {
        super.setUp()
        mockMoviesRepository = MockMoviesRepository()
        mockUserRepository = MockUserRepository()
        getMoviesUseCase = GetMoviesUseCase(moviesRepository: mockMoviesRepository, userRepository: mockUserRepository)
    }

    func testAgeRestrictionFilter() {
        // Prepare
        let user2 = User(age: 15)
        
        mockUserRepository.mockUser = user2
        mockMoviesRepository.mockMovies = page1
        mockMoviesRepository.expectation = expectation(description: "Single page load")
        
        // Execute
        getMoviesUseCase.execute(pagina: 1) { movies, error in
            for movie in movies {
                if movie.adult == true {
                    // Assert
                    XCTFail("Esta vindo filme adulto")
                    return
                }
            }
        }
        waitForExpectations(timeout: 5)
    }
    
    func testAgeRestrictionFilterIsWorkingWhenEveryMoviePass() {
        // Prepare
        let user2 = User(age: 15)
        mockUserRepository.mockUser = user2
        mockMoviesRepository.mockMovies = page2
        mockMoviesRepository.expectation = expectation(description: "Second page load")
        
        // Execute
        getMoviesUseCase.execute(pagina: 2) { movies, error in
            // Assert
            XCTAssertEqual(self.page2.count, movies.count)
        }
        waitForExpectations(timeout: 5)
    }
    
    func testAgeRestrictionFilterIsWorkingWhenUserIsOverAge() {
        // Prepare
        let user1 = User(age: 25)
        mockMoviesRepository.mockMovies = page1
        mockMoviesRepository.expectation = expectation(description: "Single page load")
        mockUserRepository.mockUser = user1
        
        //Execute
        getMoviesUseCase.execute(pagina: 1) { movies, error in
            // Assert
            XCTAssertEqual(self.page1.count, movies.count)
        }
        waitForExpectations(timeout: 5)
    }
}
