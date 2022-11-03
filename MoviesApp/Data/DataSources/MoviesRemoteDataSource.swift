final class MoviesRemoteDataSource {
    private let service = NetworkService()
    func getMovies(pagina: Int, completionHandler: @escaping([Movie], Error?) -> Void) {
        service.get<[Movie]>(endpoint: .popular, queryParameters: [["api_key": AppConfiguration.apiKey], ["page": String(pagina)]], completionHandler: completionHandler)
    }
}
