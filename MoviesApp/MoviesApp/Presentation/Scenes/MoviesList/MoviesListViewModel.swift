final class MoviesListViewModel {

    var movies: Observable<[Movie]> = Observable([])
    private let moviesRepository: MoviesRepositoryProtocol
    init(repository: MoviesRepositoryProtocol = MoviesRepository()) {
        self.moviesRepository = repository
    }
    
    func fetchMovies() {
        moviesRepository.getMovies(completionHandler: atualizaLista)
    }
    
    func atualizaLista(movies: [Movie]) {
        self.movies.value = movies
    }
}
