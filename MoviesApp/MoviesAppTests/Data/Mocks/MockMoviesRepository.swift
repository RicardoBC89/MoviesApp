@testable import MoviesApp

class MockMoviesRepository: MoviesRepositoryProtocol {
    let mockMovies: [Movie] = []
    
    func getMovies() -> [Movie] {
        mockMovies
    }
    

}
