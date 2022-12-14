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
    private var mockGetMoviesUseCase: MockGetMoviesUseCase!
    
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
        mockGetMoviesUseCase = MockGetMoviesUseCase()
        viewModel = MoviesListViewModel(getMoviesUseCase: mockGetMoviesUseCase)
    }

    override func tearDown()  {
        super.tearDown()
    }
    
    func testIfFirstPageLoads()  {
        // Prepare
        mockGetMoviesUseCase.mockMovies = page1
        mockGetMoviesUseCase.expectation = expectation(description: "Single page load")
        
        // Execute
        viewModel.fetchMovies(pagina: 1)
        waitForExpectations(timeout: 5)

        // Assert
        XCTAssertEqual(viewModel.moviesObservable.value.count, page1.count)
        XCTAssertEqual(viewModel.moviesObservable.value, page1)
    }
    
    func testIfTwoPagesAreRequestedThenViewModelContainsTwoPages()  {
        // Prepare
        mockGetMoviesUseCase.mockMovies = page1
        mockGetMoviesUseCase.expectation = expectation(description: "Fist page load")

        // Execute
        viewModel.fetchMovies(pagina: 1)
        waitForExpectations(timeout: 5)
    
        mockGetMoviesUseCase.mockMovies = page2
        mockGetMoviesUseCase.expectation = expectation(description: "Second page load")

        viewModel.nextPage()
        waitForExpectations(timeout: 5)

        // Assert
        let allPages = page1 + page2
        XCTAssertEqual(viewModel.moviesObservable.value.count, allPages.count)
        XCTAssertEqual(viewModel.moviesObservable.value, allPages)
        XCTAssertEqual(viewModel.paginaAtual, 2)
    }
    
    func testIfTheRepositoryReturnsErrorThenViewModelContainsError() {
        //Prepare
        mockGetMoviesUseCase.error = NetworkError.unexpected
        mockGetMoviesUseCase.expectation = expectation(description: "Repository returns error")
        
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
