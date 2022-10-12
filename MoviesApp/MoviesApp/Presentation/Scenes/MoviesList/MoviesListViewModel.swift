class MoviesListViewModel {

    var movies: Observable<[Movie]> = Observable([])
    let moviesRepository: MoviesRepository = MoviesRepository()
    func getMovies() {
        
        movies.value = moviesRepository.getMovies()
    }
}
