import SwiftyUserDefaults

final class MoviesCacheDataSource {
    func getMovies() -> [Movie] {
        Defaults[key: DefaultsKeys.moviesInCache] ?? []
    }
    
    func saveCache(movies: [Movie]) {
        if Defaults[key: DefaultsKeys.moviesInCache] != nil {
            for movie in movies {
                Defaults[key: DefaultsKeys.moviesInCache]?.append(movie)
            }
        } else {
            Defaults[key: DefaultsKeys.moviesInCache] = movies
        }
    }
    
    func deleteCache() {
      Defaults.remove(DefaultsKeys.moviesInCache)
    }
}

extension DefaultsKeys {
    static let moviesInCache = DefaultsKey<[Movie]?>("MoviesInCache")
}
