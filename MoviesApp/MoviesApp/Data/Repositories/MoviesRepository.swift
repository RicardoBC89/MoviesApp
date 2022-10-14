

final class MoviesRepository: MoviesRepositoryProtocol {
    let rds = MoviesRemoteDataSource()
    let cds = MoviesCacheDataSource()
    
    func getMovies() -> [Movie] {
        return rds.getMovies()
    }
}

