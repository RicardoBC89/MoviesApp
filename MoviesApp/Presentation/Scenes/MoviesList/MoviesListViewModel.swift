final class MoviesListViewModel {

    var movies: Observable<[Movie]> = Observable([])
    private let lastPage = 500
    private var paginaAtual: Int = 1
    private let moviesRepository: MoviesRepositoryProtocol
    
    init(repository: MoviesRepositoryProtocol = MoviesRepository()) {
        self.moviesRepository = repository
    }
    
    func fetchMovies(pagina: Int, completionHandler: (() -> Void)? = nil) {
        if pagina > lastPage {
            completionHandler?()
        } else {
            moviesRepository.getMovies(pagina: pagina) { [weak self] movies in
                self?.movies.value += movies
                completionHandler?()
            }
        }
    }
    
    func nextPage(completionHandler: (() -> Void)? = nil) {
        paginaAtual += 1
        fetchMovies(pagina: paginaAtual, completionHandler: completionHandler)
    }
}
