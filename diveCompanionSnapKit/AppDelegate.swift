//
//  AppDelegate.swift
//  diveCompanionSnapKit
//
//  Created by Mikołaj Linczewski on 22/04/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let viewController = TableViewController()
       // viewController.countryIndex = 5
        window = UIWindow()
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        return true
    }
}

