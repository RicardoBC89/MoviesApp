final class MoviesRemoteDataSource {
    private let service = NetworkService()
    func getMovies(completionHandler: ([Movie]) -> Void) {
        service.getMovies(completionHandler: completionHandler)
    }
}
