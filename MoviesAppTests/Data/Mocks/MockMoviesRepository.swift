@testable import MoviesApp
import XCTest

class MockMoviesRepository: MoviesRepositoryProtocol {
    var mockMovies: [Movie] = []
    var expectation: XCTestExpectation?
    var error: Error?
    
    func getMovies(pagina: Int, completionHandler: @escaping ([Movie], Error?) -> Void) {
        expectation?.fulfill()
        if let error = error {
            completionHandler([], error)
        } else {
            completionHandler(mockMovies, nil)
        }
    }
}
