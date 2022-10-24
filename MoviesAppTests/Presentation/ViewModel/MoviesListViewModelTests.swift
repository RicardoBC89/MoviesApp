//
//  MoviesListViewModelTests.swift
//  MoviesAppTests
//
//  Created by User on 13/10/22.
//

import XCTest
@testable import MoviesApp

final class MoviesListViewModelTests: XCTestCase {
    private var viewModel: MoviesListViewModel!
    private var mockRepository: MockMoviesRepository!
    
    private let page1: [Movie] = [
        Movie(titulo: "Superman", ano: "2020", caminhoIMG: ""),
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
        mockRepository = MockMoviesRepository()
        viewModel = MoviesListViewModel(repository: mockRepository)
    }

    override func tearDown()  {
        super.tearDown()
    }
    
    func testIfFirstPageLoads()  {
        // Prepare
        mockRepository.mockMovies = page1
        mockRepository.expectation = expectation(description: "Single page load")
        
        // Execute
        viewModel.fetchMovies(pagina: 1)
        waitForExpectations(timeout: 5)

        // Assert
        XCTAssertEqual(viewModel.movies.value.count, page1.count)
        XCTAssertEqual(viewModel.movies.value, page1)
    }
    
    func testIfTwoPagesAreRequestedThenViewModelContainsTwoPages()  {
        // Prepare
        mockRepository.mockMovies = page1
        mockRepository.expectation = expectation(description: "Fist page load")

        // Execute
        viewModel.fetchMovies(pagina: 1)
        waitForExpectations(timeout: 5)
    
        mockRepository.mockMovies = page2
        mockRepository.expectation = expectation(description: "Second page load")

        viewModel.nextPage()
        waitForExpectations(timeout: 5)

        // Assert
        let allPages = page1 + page2
        XCTAssertEqual(viewModel.movies.value.count, allPages.count)
        XCTAssertEqual(viewModel.movies.value, allPages)
        XCTAssertEqual(viewModel.paginaAtual, 2)
    }
    
    func testIfTheRepositoryReturnsErrorThenViewModelContainsError() {
        //Prepare
        mockRepository.error = NetworkError.unexpected
        mockRepository.expectation = expectation(description: "Repository returns error")
        
        //Execute
        viewModel.fetchMovies(pagina: 1)
        waitForExpectations(timeout: 5)
        
        //Assert
        XCTAssertNotNil(viewModel.errorObservable.value)
    }
}

extension Movie: Equatable {
    public static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.titulo == rhs.titulo &&
        lhs.ano == rhs.ano
    }
}
