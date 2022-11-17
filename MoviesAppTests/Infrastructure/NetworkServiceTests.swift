//
//  NetworkServiceTests.swift
//  MoviesAppTests
//
//  Created by User on 04/11/22.
//

@testable import MoviesApp
import XCTest
import OHHTTPStubs

class NetworkServiceTests: XCTestCase {
    private let networkService = NetworkService()
   
    func testWhenMockDataPassedThenReturnsMovies() {
        let movieMock =  Movie(titulo: "Homi-Aranha", ano: "2022-10-06", caminhoIMG: "/b6IRp6Pl2Fsq37r9jFhGoLtaqHm.jpg", adult: false)
        let movieResponseMock = ["page": 1, "results": [
            ["title": "Homi-Aranha", "release_date": "2022-10-06", "poster_path": "/b6IRp6Pl2Fsq37r9jFhGoLtaqHm.jpg", "adult": false]
        ]] as [String : Any]
        stub(condition: isMethodGET()) { _ in
          return HTTPStubsResponse(
            jsonObject: movieResponseMock,
            statusCode: 200,
            headers: [ "Content-Type": "application/json" ]
          )
        }
        let exp = expectation(description: "Movies return")
        var moviesResponse: MovieResponse?
        var e: Error?
        networkService.get(endpoint: .popular, queryParameters: [["api_key": AppConfiguration.apiKey], ["page": String(1)]]) {(response: MovieResponse?, error: Error?) in
            guard let response = response else {
                XCTFail()
                return
            }
            moviesResponse = response
            e = error
            exp.fulfill()
        }
        waitForExpectations(timeout: 5)
        guard let moviesResponse = moviesResponse else {
            XCTFail()
            return
        }

        XCTAssertEqual(moviesResponse.page, 1)
        XCTAssertEqual(moviesResponse.results, [movieMock] )
        XCTAssertNil(e)
    }
    
    func testWhenMockDataFailThenReturnsError() {
        stub(condition: isMethodGET()) { _ in
          return HTTPStubsResponse(
            jsonObject: [],
            statusCode: 500,
            headers: [ "Content-Type": "application/json" ]
          )
        }
        let exp = expectation(description: "Movies do not return")
        var e: Error?
        networkService.get(endpoint: .popular, queryParameters: [["api_key": AppConfiguration.apiKey], ["page": String(1)]]) {(response: MovieResponse?, error: Error?) in
            guard response == nil else {
                XCTFail()
                return
            }
            e = error
            exp.fulfill()
        }
        waitForExpectations(timeout: 5)
        XCTAssertNotNil(e)
        XCTAssertEqual( e as? NetworkError, NetworkError.internalServerError)
    }
//    func testWhenNoInternetConnectionIsAvailable() {
//        stub(condition: isMethodGET()) { _ in
//            let notConnectedError = NSError(domain: NSURLErrorDomain, code: URLError.notConnectedToInternet.rawValue)
//            return HTTPStubsResponse(error:notConnectedError)
//        }
//        let exp = expectation(description: "No intrnet error to return")
//        var e: Error?
//        networkService.get(endpoint: .popular, queryParameters: [["api_key": AppConfiguration.apiKey], ["page": String(1)]]) {(response: MovieResponse?, error: Error?) in
//            guard let error = error else {
//                XCTFail()
//                return
//            }
//            e = error
//            exp.fulfill()
//        }
//        waitForExpectations(timeout: 5)
//        XCTAssertNotNil(e)
//        XCTAssertEqual(e as? NetworkError, NetworkError.noInternet)
//    }
}
