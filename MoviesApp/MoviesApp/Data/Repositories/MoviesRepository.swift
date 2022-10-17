

final class MoviesRepository: MoviesRepositoryProtocol {
    let rds = MoviesRemoteDataSource()
    let cds = MoviesCacheDataSource()
    
    func getMovies(completionHandler: @escaping ([Movie]) -> Void) {
        rds.getMovies(completionHandler: completionHandler)
    }
}
