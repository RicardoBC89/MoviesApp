import Accelerate

protocol MoviesRemoteDataSourceProtocol {
    func getMovies(pagina: Int, moviesRepositoryCompletionHandler: @escaping([Movie], Error?) -> Void)
}

final class MoviesRemoteDataSource: MoviesRemoteDataSourceProtocol {
    private let service = NetworkService()
    
    func getMovies(pagina: Int, moviesRepositoryCompletionHandler: @escaping([Movie], Error?) -> Void) {
        service.get(endpoint: .popular, queryParameters: [["api_key": AppConfiguration.apiKey], ["page": String(pagina)]], serviceCompletionHandler: { (moviesResponse: MovieResponse?, error: Error?) in
            moviesRepositoryCompletionHandler(moviesResponse?.results ?? [] , error)
        })
    }
}
