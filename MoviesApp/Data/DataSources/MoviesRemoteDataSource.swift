final class MoviesRemoteDataSource {
    private let service = NetworkService()
    func getMovies(pagina: Int, completionHandler: @escaping([Movie]) -> Void) {
        service.getMovies(pagina: pagina, completionHandler: completionHandler)
    }
}
