

final class MoviesRepository: MoviesRepositoryProtocol {
    let rds = MoviesRemoteDataSource()
    let cds = MoviesCacheDataSource()
    
    func getMovies(pagina: Int, viewModelCompletionHandler: @escaping ([Movie], Error?) -> Void) {
        rds.getMovies(pagina: pagina, moviesRepositoryCompletionHandler: { [weak self] (movies, error) in
            if movies.isEmpty {
                guard let self = self else { return }
                let cacheMovies = pagina == 1 ? self.cds.getMovies() : []
                viewModelCompletionHandler(cacheMovies, cacheMovies.isEmpty ? NetworkError.noMorePages : nil)
            } else {
                if pagina == 1 {
                    self?.cds.deleteCache()
                }
                self?.cds.saveCache(movies: movies)
                viewModelCompletionHandler(movies, error)
            }
        })
    }
}
