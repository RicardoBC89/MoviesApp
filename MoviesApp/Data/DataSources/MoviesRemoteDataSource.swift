final class MoviesRemoteDataSource {
    private let service = NetworkService()
    func getMovies(completionHandler: @escaping([Movie]) -> Void) {
        service.getMovies(completionHandler: completionHandler)
    }
}
