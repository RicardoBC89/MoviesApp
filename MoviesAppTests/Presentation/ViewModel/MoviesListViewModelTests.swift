//
//  MoviesListViewModelTests.swift
//  MoviesAppTests
//
//  Created by User on 13/10/22.
//

import XCTest
@testable import MoviesApp

final class MoviesListViewModelTests: XCTestCase {

    var viewModel: MoviesListViewModel!
    var mockRepository: MockMoviesRepository!
    let moviesPages: [MoviePage] = [
        MoviePage(page: 1,
                  totalPage: 2,
                  moviesPageArray: [
                    Movie(titulo: "Superman", ano: "2020", caminhoIMG: ""),
                    Movie(titulo: "Batman", ano: "2018", caminhoIMG: ""),
                    Movie(titulo: "Aquaman", ano: "2022", caminhoIMG: "")
                  ]),
        MoviePage(page: 2,
                  totalPage: 2,
                  moviesPageArray: [
                    Movie(titulo: "Superman 2", ano: "2022", caminhoIMG: ""),
                    Movie(titulo: "Batman 2", ano: "2020", caminhoIMG: ""),
                    Movie(titulo: "Aquaman 2", ano: "2024", caminhoIMG: "")
                  ])
    ]
    
    override func setUp()  {
        super.setUp()
        mockRepository = MockMoviesRepository()
        viewModel = MoviesListViewModel(repository: mockRepository)
    }

    override func tearDown()  {
        super.tearDown()
    }
    
    func testIfFirstPageLoads()  {
        //Prepare
        mockRepository.mockMovies = moviesPages[0].moviesPageArray
        let expectation = expectation(description: "Wait for movies update")
        
        //Execute
        viewModel.fetchMovies(pagina: 1) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        //Assert
        XCTAssertEqual(viewModel.movies.value.count, 3)
        XCTAssertEqual(viewModel.movies.value, moviesPages[0].moviesPageArray)
    }
    
    func testIfTwoPagesAreRequestedThenViewModelContainsTwoPages()  {
        //Prepare
        mockRepository.mockMovies = moviesPages[0].moviesPageArray
        let exp = expectation(description: "Wait movie update")
        
        //Execute
        viewModel.fetchMovies(pagina: 1) {
            exp.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        
        //Prepare
        mockRepository.mockMovies = moviesPages[1].moviesPageArray
        let exp2 = expectation(description: "Wait for Page update")
        
        //Execute
        viewModel.nextPage() {
            exp2.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        //Assert
        XCTAssertEqual(viewModel.movies.value.count, 6)
        XCTAssertEqual(viewModel.movies.value, moviesPages[0].moviesPageArray + moviesPages[1].moviesPageArray)
    }
}

extension Movie: Equatable {
    public static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.titulo == rhs.titulo &&
        lhs.ano == rhs.ano
    }
}
