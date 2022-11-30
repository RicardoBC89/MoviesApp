//
//  MoviesAppSnapshotTests.swift
//  MoviesAppSnapshotTests
//
//  Created by User on 29/11/22.
//

import XCTest
import SnapshotTesting
@testable import MoviesApp

final class MoviesAppSnapshotTests: XCTestCase {
    private let devices: [String: ViewImageConfig] = ["iPhoneSe": .iPhoneSe,
                                                      "iPhone8": .iPhone8,
                                                      "iPhoneXsMax": .iPhoneXsMax]
    
    func testLoginViewController() {
        let viewController: LoginViewController = LoginViewController(viewModel: LoginViewModel(), coordinator: MockAppCoordinator())
        let navagationController = UINavigationController(rootViewController: viewController)
        for device in devices {
            assertSnapshot(matching: navagationController,
                           as: .image(on: device.value),
                           named: device.key,
                           record: false)
        }
    }
    
    func testMoviesListViewController() {
        let mockGetMoviesUseCase = MockGetMoviesUseCase()
        let viewModel = MoviesListViewModel(getMoviesUseCase: mockGetMoviesUseCase)
        let viewController = MoviesListViewController(viewModel: viewModel, coordinator: MockAppCoordinator())
        let navagationController = UINavigationController(rootViewController: viewController)
        mockGetMoviesUseCase.mockMovies = [
            Movie(titulo: "Superman", ano: "2020", caminhoIMG: ""),
            Movie(titulo: "Batman", ano: "2018", caminhoIMG: ""),
            Movie(titulo: "Aquaman", ano: "2022", caminhoIMG: "")]
        
        for device in devices {
            assertSnapshot(matching: navagationController,
                           as: .image(on: device.value),
                           named: device.key,
                           record: false)
        }
    }
}

final class MockGetMoviesUseCase: GetMoviesUseCaseProtocol {
    var mockMovies: [Movie] = []
    var expectation: XCTestExpectation?
    var error: Error?
    
    func execute(pagina: Int, viewModelCompletionHandler completionHandler: @escaping ([Movie], Error?) -> Void) {
        expectation?.fulfill()
        if let error = error {
            completionHandler([], error)
        } else {
            completionHandler(mockMovies, nil)
        }
    }
}

final class MockAppCoordinator: AppCoordinator {
    init() {
        super.init(navigationController: UINavigationController())
    }
    
    override func start() {
    }
    
    override func navigateToMoviesList() {
    }
    
    override func navigateToMovieDetails(movieId: Int) {
    }
    
    override func navigateToLogin() {
    }
}

