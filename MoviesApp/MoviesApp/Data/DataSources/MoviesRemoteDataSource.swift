class MoviesRemoteDataSource {
    func getMovies () -> [Movie] {
        var movieArray: [Movie] = []
        let movie = Movie(titulo: "Homi Aranha", ano: 2014)
        movieArray.append(movie)
        let movie2 = Movie(titulo: "Homi Aranha 2", ano: 2018)
        movieArray.append(movie2)
        return movieArray
    }
}
