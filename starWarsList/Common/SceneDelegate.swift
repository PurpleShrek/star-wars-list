//
//  SceneDelegate.swift
//  starWarsList
//
//  Created by Aleksei Zaitsev on 14/12/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        loadVC(windowScene)
    }
    
    private func loadVC(_ scene: UIWindowScene) {
        window = UIWindow(windowScene: scene)
        let rootVC = MainViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
    }
}
