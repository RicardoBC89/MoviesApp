
protocol MoviesRepositoryProtocol {
    func getMovies(pagina: Int, completionHandler: @escaping ([Movie]) -> Void)
}
