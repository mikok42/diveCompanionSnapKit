//
//  MainCoordinator.swift
//  diveCompanionSnapKit
//
//  Created by Mikołaj Linczewski on 11/05/2021.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func goToMainView() {
        let viewController = TableViewController()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func goToSiteView(url: String) {
        let viewController = ViewController()
        viewController.url = url
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: false)
    }
}
