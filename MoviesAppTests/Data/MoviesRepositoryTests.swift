//
//  MoviesRepositoryTests.swift
//  MoviesAppTests
//
//  Created by User on 24/11/22.
//

import XCTest
@testable import MoviesApp

class MoviesRepositoryTests: XCTestCase {
    private var moviesRepository: MoviesRepository!
    private var mockMoviesRemoteDataSource: MockMoviesRemoteDataSource!
    private var mockMoviesCacheDataSource: MockMoviesCacheDataSource!
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
    
    override func setUp() {
        super.setUp()
        mockMoviesRemoteDataSource = MockMoviesRemoteDataSource()
        mockMoviesCacheDataSource = MockMoviesCacheDataSource()
        moviesRepository = MoviesRepository(moviesRemoteDataSource: mockMoviesRemoteDataSource, moviesCacheDataSource: mockMoviesCacheDataSource)
    }
    
    func testIfGetMoviesWork() {
        // Prepare
        let pagina = 1
        var returnedMovies: [Movie] = []
        var returnedError: Error? = nil
        let completionHandler = { (movies: [Movie], error: Error?) in
            returnedMovies = movies
            returnedError = error
        }
        mockMoviesRemoteDataSource.mockMovies = page1
        mockMoviesRemoteDataSource.mockError = nil
        mockMoviesRemoteDataSource.expectation = expectation(description: "Wait for movies")
        
        // Execute
        moviesRepository.getMovies(pagina: pagina, viewModelCompletionHandler: completionHandler)
        waitForExpectations(timeout: 5)
        
        // Assert
        XCTAssertEqual(returnedMovies, page1)
        XCTAssertNil(returnedError)
        XCTAssertEqual(mockMoviesCacheDataSource.saveCacheCallCount, 1)
        XCTAssertEqual(mockMoviesCacheDataSource.deleteCacheCallCount, 1)
    }
    
    func testIfNoMoviesFromRemoteFetchFromCache() {
        // Prepare
        let pagina = 1
        var returnedMovies: [Movie] = []
        var returnedError: Error? = nil
        let completionHandler = { (movies: [Movie], error: Error?) in
            returnedMovies = movies
            returnedError = error
        }
        mockMoviesRemoteDataSource.mockMovies = []
        mockMoviesRemoteDataSource.mockError = NetworkError.unexpected
        mockMoviesRemoteDataSource.expectation = expectation(description: "Wait for movie error")
        mockMoviesCacheDataSource.mockMovies = page1
        
        // Execute
        moviesRepository.getMovies(pagina: pagina, viewModelCompletionHandler: completionHandler)
        waitForExpectations(timeout: 5)
        
        // Assert
        XCTAssertEqual(returnedMovies, page1)
        XCTAssertEqual(returnedError as? NetworkError, NetworkError.noMorePages)
    }
    
    func testIfNoMoviesFromRemoteAndNoMoviesFromCache() {
        // Prepare
        let pagina = 1
        var returnedMovies: [Movie] = []
        var returnedError: Error? = nil
        let completionHandler = { (movies: [Movie], error: Error?) in
            returnedMovies = movies
            returnedError = error
        }
        mockMoviesRemoteDataSource.mockMovies = []
        mockMoviesRemoteDataSource.mockError = NetworkError.noInternet
        mockMoviesRemoteDataSource.expectation = expectation(description: "Wait for movie error")
        mockMoviesCacheDataSource.mockMovies = []
        
        // Execute
        moviesRepository.getMovies(pagina: pagina, viewModelCompletionHandler: completionHandler)
        waitForExpectations(timeout: 5)
        
        // Assert
        XCTAssertEqual(returnedMovies, [])
        XCTAssertEqual(returnedError as? NetworkError, NetworkError.noInternet)
    }
}
