//
//  UserDetailsViewController.swift
//  diveCompanionSnapKit
//
//  Created by Mikołaj Linczewski on 29/06/2021.
//

import Foundation
import FirebaseFirestore

class UserDetailsViewController: CustomViewController<UserDetailsView> {
    weak var coordinator: MainCoordinator?
    private var serviceProvider: ServiceProviderProtocol
    
    var currentUser: Userdata?
    
    init(serviceProvider: ServiceProviderProtocol) {
        self.serviceProvider = serviceProvider
        super.init()
        currentUser = serviceProvider.firebaseService.getCurrentUser()
        customView.buttonDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        populateView()
    }
    
    func populateView() {
        customView.userEmail = currentUser?.email
        customView.userGender = currentUser?.gender
        customView.userName = currentUser?.username
        customView.userSkillLevel = currentUser?.skillLevel
    }
}

extension UserDetailsViewController: DetailsViewButtonsDelegate {
    func homeButtonPressed() {
        navigationController?.popViewController(animated: false)
    }
    
    
}
