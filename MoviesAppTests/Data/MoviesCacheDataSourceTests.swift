
import XCTest
import SwiftyUserDefaults
@testable import MoviesApp

class MoviesCacheDataSourceTests: XCTestCase {
    private let page1: [Movie] = [
        Movie(titulo: "Superman", ano: "2020", caminhoIMG: ""),
        Movie(titulo: "Batman", ano: "2018", caminhoIMG: ""),
        Movie(titulo: "Aquaman", ano: "2022", caminhoIMG: "")
    ]
    private let page2 = [
        Movie(titulo: "Superman 2", ano: "2022", caminhoIMG: ""),
        Movie(titulo: "Batman 2", ano: "2020", caminhoIMG: ""),
        Movie(titulo: "Aquaman 2", ano: "2024", caminhoIMG: "")
    ]
    
    func testIfMoviesAreSavedInCache() {
        // Prepare
        let moviesCacheDataSource = MoviesCacheDataSource(key: DefaultsKeys.moviesInCacheTest)
        let moviesToBeSaved = page1
        moviesCacheDataSource.deleteCache()
        
        // Execute
        moviesCacheDataSource.saveCache(movies: moviesToBeSaved)
        let moviesSaved = moviesCacheDataSource.getMovies()
        
        // Assert
        XCTAssertEqual(moviesSaved, moviesToBeSaved)
        XCTAssertEqual(moviesSaved.count, moviesToBeSaved.count)
    }
    
    func testIfDeletedCacheAreDeleted() {
        // Prepare
        let moviesCacheDataSource = MoviesCacheDataSource(key: DefaultsKeys.moviesInCacheTest)
        let moviesToBeSaved = page1
        moviesCacheDataSource.deleteCache()
        
        // Execute
        moviesCacheDataSource.saveCache(movies: moviesToBeSaved)
        moviesCacheDataSource.deleteCache()
        let moviesSaved = moviesCacheDataSource.getMovies()
        
        // Assert
        XCTAssertEqual(moviesSaved, [])
        XCTAssertEqual(moviesSaved.count, 0)
    }
    
    func testIfTowPagesAreSaved() {
        // Prepare
        let moviesCacheDataSource = MoviesCacheDataSource(key: DefaultsKeys.moviesInCacheTest)
        let moviesToBeSaved = page1
        let moviesToBeSaved2 = page2
        moviesCacheDataSource.deleteCache()
        
        // Execute
        moviesCacheDataSource.saveCache(movies: moviesToBeSaved)
        moviesCacheDataSource.saveCache(movies: moviesToBeSaved2)
        let moviesSaved = moviesCacheDataSource.getMovies()
        
        // Assert
        XCTAssertEqual(moviesToBeSaved + moviesToBeSaved2, moviesSaved)
        XCTAssertEqual(moviesToBeSaved.count + moviesToBeSaved2.count, moviesSaved.count)
        XCTAssertTrue(page1.allSatisfy(moviesSaved.contains))
        XCTAssertTrue(page2.allSatisfy(moviesSaved.contains))
    }
}
