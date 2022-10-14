@testable import MoviesApp

class MockMoviesRepository: MoviesRepositoryProtocol {
    var mockMovies: [Movie] = []
    
    func getMovies(completionHandler: ([Movie]) -> Void) {
        completionHandler(mockMovies)
    }
}
