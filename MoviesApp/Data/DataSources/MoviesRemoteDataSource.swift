import Accelerate
final class MoviesRemoteDataSource {
    private let service = NetworkService()
    
    func getMovies(pagina: Int, viewModelCompletionHandler: @escaping([Movie], Error?) -> Void) {
        service.get(endpoint: .popular, queryParameters: [["api_key": AppConfiguration.apiKey], ["page": String(pagina)]], serviceCompletionHandler: { (moviesResponse: MovieResponse?, error: Error?) in
            viewModelCompletionHandler(moviesResponse?.results ?? [] , error)
        })
    }
}
