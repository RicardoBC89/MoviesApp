@testable import MoviesApp

class MockMoviesRepository: MoviesRepositoryProtocol {
    var mockMovies: [Movie] = []
    
    func getMovies(pagina: Int, completionHandler: @escaping ([Movie]) -> Void) {
        completionHandler(mockMovies)
    }
}
