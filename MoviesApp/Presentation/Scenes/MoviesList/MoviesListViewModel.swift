import Foundation
final class MoviesListViewModel {
    var movies: Observable<[Movie]> = Observable([])
    var isLoading: Observable<Bool> = Observable(false)
    var errorObservable: Observable<Error?> = Observable(nil)
    private let lastPage = 500
    private(set) var paginaAtual: Int = 1
    private let moviesRepository: MoviesRepositoryProtocol
    private let userRepository: UserRepository

    init(repository: MoviesRepositoryProtocol = MoviesRepository(),
         userRepository: UserRepository = UserRepository()) {
        self.moviesRepository = repository
        self.userRepository = userRepository
    }

    func fetchMovies(pagina: Int) {
        guard pagina <= lastPage else { return }
        isLoading.value = true
        userRepository.getUser(viewModelCompletionHandler: { user in
            print(user?.age)
        })
        moviesRepository.getMovies(pagina: pagina, viewModelCompletionHandler: { [weak self] movies, error in
            self?.isLoading.value = false
            if let error = error {
                self?.errorObservable.value = error
            }
            self?.movies.value += movies
        })
    }

    func nextPage() {
        paginaAtual += 1
        fetchMovies(pagina: paginaAtual)
    }
    
    
}
