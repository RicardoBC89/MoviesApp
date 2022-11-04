

final class MoviesRepository: MoviesRepositoryProtocol {
    let rds = MoviesRemoteDataSource()
    let cds = MoviesCacheDataSource()
    
    func getMovies(pagina: Int, completionHandler: @escaping (MovieResponse?, Error?) -> Void) {
        rds.getMovies(pagina: pagina, completionHandler: completionHandler)
    }
}
