
protocol MoviesRepositoryProtocol {
    func getMovies(pagina: Int, completionHandler: @escaping (MovieResponse?, Error?) -> Void)
}
