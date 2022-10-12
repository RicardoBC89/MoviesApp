class MoviesRepository {
    let rds = MoviesRemoteDataSource()
    let cds = MoviesCacheDataSource()
    
    func getMovies() -> [Movie] {
        return rds.getMovies()
    }
}

