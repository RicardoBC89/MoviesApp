@testable import MoviesApp

class MockMoviesRepository: MoviesRepositoryProtocol {
    var mockMovies: [Movie] = []
    
    func getMovies() -> [Movie] {
        mockMovies
    }
    

}
