//
//  SceneDelegate.swift
//  SlideOutMenuLBTA
//
//  Created by MIF50 on 29/05/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        window?.rootViewController = BaseSlidingVC()
        window?.makeKeyAndVisible()
    }
}

