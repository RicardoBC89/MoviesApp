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
        let viewModel =  MoviesListViewModel()
        let MoviesListNavagationController = UINavigationController (rootViewController: MoviesListViewController(viewModel: viewModel))
        window?.rootViewController=MoviesListNavagationController
        window?.makeKeyAndVisible()
    }
}
