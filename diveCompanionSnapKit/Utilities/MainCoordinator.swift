//
//  MainCoordinator.swift
//  diveCompanionSnapKit
//
//  Created by Mikołaj Linczewski on 11/05/2021.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    let serviceProvider: ServiceProviderProtocol
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.serviceProvider = ServiceProvider()
    }
    
    func goToMainView() {
        let viewController = TableViewController(serviceProvider: serviceProvider)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func goToSiteView(url: String) {
        let viewController = ViewController(serviceProvider: serviceProvider)
        viewController.url = url
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func goToSignUpView() {
        let viewController = SignUpViewController(serviceProvider: serviceProvider)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func goToSignInView() {
        let viewController = SignInViewController(serviceProvider: serviceProvider)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: false)
    }
}
