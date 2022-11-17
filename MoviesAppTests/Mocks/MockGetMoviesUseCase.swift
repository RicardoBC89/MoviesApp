@testable import MoviesApp
import XCTest

final class MockGetMoviesUseCase: GetMoviesUseCaseProtocol {
    var mockMovies: [Movie] = []
    var expectation: XCTestExpectation?
    var error: Error?
    
    func execute(pagina: Int, viewModelCompletionHandler completionHandler: @escaping ([Movie], Error?) -> Void) {
        expectation?.fulfill()
        if let error = error {
            completionHandler([], error)
        } else {
            completionHandler(mockMovies, nil)
        }
    }
}
