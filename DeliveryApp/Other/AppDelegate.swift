//
//  AppDelegate.swift
//  DeliveryApp
//
//  Created by Farhad on 2/18/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        startApp()
        
        return true
    }
        
    private func startApp() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        
        // start from this view controller
        let vc = DeliveryListVC()
        let nav = UINavigationController(rootViewController: vc)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }
}

