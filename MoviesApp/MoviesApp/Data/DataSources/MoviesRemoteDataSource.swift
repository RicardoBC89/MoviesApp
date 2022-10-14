final class MoviesRemoteDataSource {
    func getMovies(completionHandler: ([Movie]) -> Void) {
        var movieArray: [Movie] = []
        let movie = Movie(titulo: "Homi Aranha", ano: 2014)
        movieArray.append(movie)
        let movie2 = Movie(titulo: "Homi Aranha 2", ano: 2018)
        movieArray.append(movie2)
        completionHandler(movieArray)
    }
}
