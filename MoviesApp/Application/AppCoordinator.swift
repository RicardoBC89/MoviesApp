import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    var childCoordinator: [Coordinator] { get set }
    func start()
}

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinator: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        if let _ = UserRepository().getUser() {
           navigateToMoviesList()
        } else {
            navigateToLogin()
        }
    }
    
    func navigateToMoviesList() {
        let viewModel = MoviesListViewModel()
        let viewController = MoviesListViewController(viewModel: viewModel, coordinator: self)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func navigateToMovieDetails(movieId: Int) {
       //let viewModel = MovieDetailsViewModel(movieId: movieId)
        let viewController = MovieDetailsViewController(movieId: movieId) // passar esse movieId para o MovieDetailViewModel
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func navigateToLogin() {
        let viewModel = LoginViewModel()
        let viewController = LoginViewController(viewModel: viewModel, coordinator: self)
        navigationController.viewControllers = [viewController]
    }
}
