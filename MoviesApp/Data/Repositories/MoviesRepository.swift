

final class MoviesRepository: MoviesRepositoryProtocol {
    let rds = MoviesRemoteDataSource()
    let cds = MoviesCacheDataSource()
    
    func getMovies(pagina: Int, completionHandler: @escaping ([Movie]) -> Void) {
        rds.getMovies(pagina: pagina, completionHandler: completionHandler)
    }
}
