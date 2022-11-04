final class MoviesRemoteDataSource {
    private let service = NetworkService()
    
    func getMovies(pagina: Int, completionHandler: @escaping(MovieResponse?, Error?) -> Void) {
        service.get(endpoint: .popular, queryParameters: [["api_key": AppConfiguration.apiKey], ["page": String(pagina)]], completionHandler: completionHandler)
    }
}
