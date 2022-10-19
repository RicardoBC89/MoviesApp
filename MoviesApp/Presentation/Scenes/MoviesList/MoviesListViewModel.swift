final class MoviesListViewModel {

    var movies: Observable<[Movie]> = Observable([])
    private var paginaAtual: Int = 1
    private let moviesRepository: MoviesRepositoryProtocol
    
    init(repository: MoviesRepositoryProtocol = MoviesRepository()) {
        self.moviesRepository = repository
    }
    
    func fetchMovies(pagina: Int, completionHandler: (([Movie]) -> Void)? = nil) {
        moviesRepository.getMovies(pagina: pagina) { [weak self] movies in
            self?.movies.value += movies
            completionHandler?(movies)
        }
    }
    
    func nextPage(completionHandler: (([Movie]) -> Void)? = nil) {
        paginaAtual += 1
        fetchMovies(pagina: paginaAtual, completionHandler: completionHandler)
    }
}
