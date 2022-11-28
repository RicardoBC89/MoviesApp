
import Foundation
@testable import MoviesApp

final class MockMoviesCacheDataSource: MoviesCacheDataSourceProtocol {
    var mockMovies: [Movie] = []
    var saveCacheCallCount: Int = 0
    var deleteCacheCallCount: Int = 0
    
    func getMovies() -> [Movie] {
        mockMovies
    }
    
    func saveCache(movies: [Movie]) {
        saveCacheCallCount += 1
    }
    
    func deleteCache() {
        deleteCacheCallCount += 1
    }
}
