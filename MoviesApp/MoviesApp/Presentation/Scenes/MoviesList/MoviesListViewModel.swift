class MoviesListViewModel {

    var movies: Observable<[Movie]> = Observable([])
    let moviesRepository: MoviesRepositoryProtocol
    init(repository: MoviesRepositoryProtocol = MoviesRepository()) {
        self.moviesRepository = repository
        
    }
    func getMovies() {
        
        movies.value = moviesRepository.getMovies()
    }
}
