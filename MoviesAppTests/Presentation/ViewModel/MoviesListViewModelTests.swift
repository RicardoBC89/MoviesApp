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
    
    override func setUp()  {
        super.setUp()
        mockRepository = MockMoviesRepository()
        viewModel = MoviesListViewModel(repository: mockRepository)
    }

    override func tearDown()  {
        super.tearDown()
    }

    func testIfMoviesAreLoaded()  {
        //Prepare
        let movie1 = Movie(titulo: "Superman", ano: 2020)
        let movie2 = Movie(titulo: "Batman", ano: 2018)
        let movie3 = Movie(titulo: "Aquaman", ano: 2022)
        let movies = [movie1, movie2, movie3]
        mockRepository.mockMovies = movies
        
        //Execute
        viewModel.fetchMovies()

        //Assert
        XCTAssertEqual(viewModel.movies.value.count, 3)
        XCTAssertEqual(viewModel.movies.value, movies)
    }
}

extension Movie: Equatable {
    public static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.titulo == rhs.titulo &&
        lhs.ano == rhs.ano
    }
}
