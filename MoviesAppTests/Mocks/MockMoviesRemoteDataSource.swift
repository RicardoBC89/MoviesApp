//
//  MockMoviesRemoteDataSource.swift
//  MoviesAppTests
//
//  Created by User on 24/11/22.
//

import Foundation
@testable import MoviesApp
import XCTest

final class MockMoviesRemoteDataSource: MoviesRemoteDataSourceProtocol {
    var mockMovies: [Movie] = []
    var mockError: Error?
    var expectation: XCTestExpectation?
    
    func getMovies(pagina: Int, moviesRepositoryCompletionHandler: @escaping ([Movie], Error?) -> Void) {
        moviesRepositoryCompletionHandler(mockMovies, mockError)
        expectation?.fulfill()
    }
}
