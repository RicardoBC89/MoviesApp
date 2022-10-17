
protocol MoviesRepositoryProtocol {
    func getMovies(completionHandler: @escaping ([Movie]) -> Void)
}
