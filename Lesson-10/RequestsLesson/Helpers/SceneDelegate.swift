//
//  SceneDelegate.swift
//  RequestsLesson
//
//  Created by Ильдар Залялов on 13.12.2019.
//  Copyright © 2019 Ildar Zalyalov. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene
        
        let navigationController = UINavigationController()
        
        
        DataStoreManager.shared.getUserData { (user) in
            if let currentUser = user {
                
                let destVC = PostsViewController()                                
                
                NetworkManager.shared.authToken = currentUser.token
                
                navigationController.viewControllers = [destVC]
                
                destVC.configure(with: currentUser)
                
            } else {
                navigationController.viewControllers = [LoginViewController()]
            }
        }
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}

