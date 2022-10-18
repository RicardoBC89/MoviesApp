final class MoviesListViewModel {

    var movies: Observable<[Movie]> = Observable([])
    private let moviesRepository: MoviesRepositoryProtocol
    init(repository: MoviesRepositoryProtocol = MoviesRepository()) {
        self.moviesRepository = repository
    }
    
    func fetchMovies() {
        moviesRepository.getMovies { [weak self] movies in
            self?.movies.value = movies
        }
    }
}
