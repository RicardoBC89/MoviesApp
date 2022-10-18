@testable import MoviesApp

class MockMoviesRepository: MoviesRepositoryProtocol {
    var mockMovies: [Movie] = []
    
    func getMovies(completionHandler: @escaping ([Movie]) -> Void) {
        completionHandler(mockMovies)
    }
}
