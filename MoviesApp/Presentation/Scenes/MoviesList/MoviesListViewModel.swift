import Foundation
final class MoviesListViewModel {
    var moviesObservable: Observable<[Movie]> = Observable([])
    var isLoading: Observable<Bool> = Observable(false)
    var errorObservable: Observable<Error?> = Observable(nil)
    private let lastPage = 500
    private(set) var paginaAtual: Int = 1
    private let getMoviesUseCase: GetMoviesUseCaseProtocol
    private var paginaAnterior: Int = 0
    
    init(getMoviesUseCase: GetMoviesUseCaseProtocol = GetMoviesUseCase()) {
        self.getMoviesUseCase = getMoviesUseCase
    }

    func fetchMovies(pagina: Int) {
        guard pagina <= lastPage, pagina != paginaAnterior else { return }
        paginaAnterior = pagina
        if let error = errorObservable.value as? NetworkError, error == .noMorePages { return }
        isLoading.value = true
        getMoviesUseCase.execute(pagina: pagina, viewModelCompletionHandler: { [weak self] movies, error in
            if let error = error {
                self?.errorObservable.value = error
            }
            self?.moviesObservable.value += movies
            self?.isLoading.value = false
        })
    }

    func nextPage() {
        if !isLoading.value {
            paginaAtual += 1
            fetchMovies(pagina: paginaAtual)
        }
    }
}
