

final class MoviesRepository: MoviesRepositoryProtocol {
    let rds = MoviesRemoteDataSource()
    let cds = MoviesCacheDataSource()
    
    func getMovies(pagina: Int, viewModelCompletionHandler: @escaping ([Movie], Error?) -> Void) {
        rds.getMovies(pagina: pagina, viewModelCompletionHandler: viewModelCompletionHandler)
    }
}
