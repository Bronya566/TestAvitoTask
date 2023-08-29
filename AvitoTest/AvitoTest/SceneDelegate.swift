//
//  SceneDelegate.swift
//  AvitoTest
//
//  Created by Дмитрий on 27.08.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let vc = ViewController(netwrokService: NetworkService(), alertFactory: AlertFactory())
        let navigationController = UINavigationController(rootViewController: vc)
        window = UIWindow(windowScene: scene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

