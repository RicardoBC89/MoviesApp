//
//  GetMoviesUseCaseTest.swift
//  MoviesAppTests
//
//  Created by User on 10/11/22.
//

import XCTest
@testable import MoviesApp

class GetMoviesUseCaseTest: XCTestCase {
    var mockMoviesRepository: MockMoviesRepository!
    var getMoviesUseCase: GetMoviesUseCase!
    
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
        getMoviesUseCase = GetMoviesUseCase(moviesRepository: mockMoviesRepository)
    }

    func testAgeRestrictionFilter() {
        // Prepare
        mockMoviesRepository.mockMovies = page1
        mockMoviesRepository.expectation = expectation(description: "Single page load")
        
        // Assert
        getMoviesUseCase.execute(pagina: 1) { movies, error in
            for movie in movies {
                if movie.adult == true {
                    XCTFail("Esta vindo filme adulto")
                    return
                }
            }
        }
        waitForExpectations(timeout: 5)
    }
    
    func testAgeRestrictionFilterIsWorkingWhenEveryMoviePass() {
        // Prepare
        mockMoviesRepository.mockMovies = page2
        mockMoviesRepository.expectation = expectation(description: "Second page load")
        
        // Assert
        getMoviesUseCase.execute(pagina: 2) { movies, error in
            XCTAssertEqual(self.page2.count, movies.count)
        }
        waitForExpectations(timeout: 5)
    }
}

