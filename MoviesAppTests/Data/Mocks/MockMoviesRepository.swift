@testable import MoviesApp
import XCTest

class MockMoviesRepository: MoviesRepositoryProtocol {
    var mockMovies: [Movie] = []
    var expectation: XCTestExpectation?
    
    func getMovies(pagina: Int, completionHandler: @escaping ([Movie]) -> Void) {
        expectation?.fulfill()
        completionHandler(mockMovies)
    }
}
