//
//  AppDelegate.swift
//  SlideOutMenuLBTA
//
//  Created by MIF50 on 29/05/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
//        let vc = UINavigationController(rootViewController: HomeVC())
        window?.rootViewController = BaseSlidingVC()
        window?.makeKeyAndVisible()
        return true
    }
}

