//
//  AppDelegate.swift
//  diveCompanionSnapKit
//
//  Created by Mikołaj Linczewski on 22/04/2021.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var coordinator: MainCoordinator?
    var serviceProvider: ServiceProviderProtocol?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let navigationController = UINavigationController()
        navigationController.setNavigationBarHidden(true, animated: false)
        
        FirebaseApp.configure()
        coordinator = MainCoordinator(navigationController: navigationController)
        serviceProvider = ServiceProvider()
        
        let hasSignedIn = serviceProvider?.firebaseService.hasSignedIn ?? false
        hasSignedIn ? coordinator?.goToMainView() : coordinator?.goToSignInView()
        
        window = UIWindow()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
 
    }
}

