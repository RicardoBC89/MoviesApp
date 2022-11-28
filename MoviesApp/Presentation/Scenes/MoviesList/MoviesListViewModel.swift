import Foundation
final class MoviesListViewModel {
    var movies: Observable<[Movie]> = Observable([])
    var isLoading: Observable<Bool> = Observable(false)
    var errorObservable: Observable<Error?> = Observable(nil)
    private let lastPage = 500
    private(set) var paginaAtual: Int = 1
    private let getMoviesUseCase: GetMoviesUseCaseProtocol
    private var isFetchingNextPage: Bool = false

    init(getMoviesUseCase: GetMoviesUseCaseProtocol = GetMoviesUseCase()) {
        self.getMoviesUseCase = getMoviesUseCase
    }

    func fetchMovies(pagina: Int) {
        guard pagina <= lastPage else { return }
        isLoading.value = true
        isFetchingNextPage = true
        getMoviesUseCase.execute(pagina: pagina, viewModelCompletionHandler: { [weak self] movies, error in
            self?.isFetchingNextPage = false
            self?.isLoading.value = false
            if let error = error {
                self?.errorObservable.value = error
            }
            self?.movies.value += movies
        })
    }

    func nextPage() {
        if !isFetchingNextPage {
            paginaAtual += 1
            fetchMovies(pagina: paginaAtual)
        }
    }
}
