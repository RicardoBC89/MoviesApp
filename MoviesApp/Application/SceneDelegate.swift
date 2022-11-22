//
//  SceneDelegate.swift
//  MoviesApp
//
//  Created by User on 05/10/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        var initialViewController: UIViewController?
        if let _ = UserRepository().getUser() {
            initialViewController = MoviesListViewController(viewModel: MoviesListViewModel())
        } else {
            initialViewController = LoginViewController(viewModel: LoginViewModel())
        }
        guard let initialViewController = initialViewController else {
            fatalError("No initial view controller set")
        }
        let navagationController = UINavigationController(rootViewController: initialViewController)
        window?.rootViewController = navagationController
        window?.makeKeyAndVisible()
    }
}
