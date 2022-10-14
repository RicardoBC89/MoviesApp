
protocol MoviesRepositoryProtocol {
    func getMovies(completionHandler: ([Movie]) -> Void)
}
