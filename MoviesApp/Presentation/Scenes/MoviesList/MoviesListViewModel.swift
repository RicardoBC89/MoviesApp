import Foundation
final class MoviesListViewModel {
    var movies: Observable<[Movie]> = Observable([])
    var isLoading: Observable<Bool> = Observable(false)
    private let lastPage = 500
    private(set) var paginaAtual: Int = 1
    private let moviesRepository: MoviesRepositoryProtocol

    init(repository: MoviesRepositoryProtocol = MoviesRepository()) {
        self.moviesRepository = repository
    }

    func fetchMovies(pagina: Int) {
        guard pagina <= lastPage else { return }
        isLoading.value = true
        moviesRepository.getMovies(pagina: pagina) { [weak self] movies in
            self?.movies.value += movies
            self?.isLoading.value = false
        }
    }

    func nextPage() {
        paginaAtual += 1
        fetchMovies(pagina: paginaAtual)
    }
}
