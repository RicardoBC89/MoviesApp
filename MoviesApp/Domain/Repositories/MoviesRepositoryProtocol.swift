
protocol MoviesRepositoryProtocol {
    func getMovies(pagina: Int, viewModelCompletionHandler: @escaping ([Movie], Error?) -> Void)
}
