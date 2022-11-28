import SwiftyUserDefaults

protocol MoviesCacheDataSourceProtocol {
    func getMovies() -> [Movie]
    func saveCache(movies: [Movie])
    func deleteCache()
}

final class MoviesCacheDataSource: MoviesCacheDataSourceProtocol {
    private let currentKey: DefaultsKey<[Movie]?>
    
    init(key: DefaultsKey<[Movie]?> = DefaultsKeys.moviesInCache) {
        currentKey = key
    }
    
    func getMovies() -> [Movie] {
        Defaults[key: currentKey] ?? []
    }
    
    func saveCache(movies: [Movie]) {
        if Defaults[key: currentKey] != nil {
            for movie in movies {
                Defaults[key: currentKey]?.append(movie)
            }
        } else {
            Defaults[key: currentKey] = movies
        }
    }
    
    func deleteCache() {
      Defaults.remove(currentKey)
    }
}

extension DefaultsKeys {
    static let moviesInCache = DefaultsKey<[Movie]?>("MoviesInCache")
    static let moviesInCacheTest = DefaultsKey<[Movie]?>("MoviesInCacheTest")
}
