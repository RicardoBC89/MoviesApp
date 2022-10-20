final class MoviesListViewModel {
    var movies: Observable<[Movie]> = Observable([])
    private let lastPage = 500
    private(set) var paginaAtual: Int = 1
    private let moviesRepository: MoviesRepositoryProtocol

    init(repository: MoviesRepositoryProtocol = MoviesRepository()) {
        self.moviesRepository = repository
    }

    func fetchMovies(pagina: Int) {
        guard pagina <= lastPage else { return }
        moviesRepository.getMovies(pagina: pagina) { [weak self] movies in
            self?.movies.value += movies
        }
    }

    func nextPage() {
        paginaAtual += 1
        fetchMovies(pagina: paginaAtual)
    }
}
