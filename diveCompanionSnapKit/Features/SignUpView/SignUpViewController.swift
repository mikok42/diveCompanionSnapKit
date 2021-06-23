//
//  SignUpViewController.swift
//  diveCompanionSnapKit
//
//  Created by Mikołaj Linczewski on 26/05/2021.
//

//Auth.auth().currentUser
//Auth.auth().signOut()
//Userserwis 55 - 74 => ładnie
//offset textfielda

import Foundation
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: CustomViewController<SignUpView> {
    weak var coordinator: MainCoordinator?
    private var serviceProvider: ServiceProviderProtocol
    
    init(serviceProvider: ServiceProviderProtocol) {
        self.serviceProvider = serviceProvider
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.signUpDelegate = self
    }
}

extension SignUpViewController: SignUpDelegate {
    func signInPressed() {
        coordinator?.goToSignInView()
    }
    
    func signUpPressed(username: String?, email: String?, gender: String?, skillLevel: String?, password: String?) {
        [email, username, gender, skillLevel, password].forEach {
            if $0?.isEmpty ?? true {
                showAlert(title: "fields empty", message: "Please fill out all fields")
                return
            }
        }
        let userdata = Userdata(username: username, email: email, password: password, skillLevel: skillLevel, gender: gender)
        serviceProvider.firebaseService.signUpUser(user: userdata) {
            self.coordinator?.goToMainView()
        }
    }
}
