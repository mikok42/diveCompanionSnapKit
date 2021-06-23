//
//  SignInViewController.swift
//  diveCompanionSnapKit
//
//  Created by Mikołaj Linczewski on 27/05/2021.
//

import Foundation
import FirebaseAuth

protocol AlertDelegate: AnyObject {
    func showAlert(title: String, message: String)
}

class SignInViewController: CustomViewController<SignInView>, AlertDelegate {
    private var serviceProvider: ServiceProviderProtocol
    weak var coordinator: MainCoordinator?
    
    init(serviceProvider: ServiceProviderProtocol) {
        self.serviceProvider = serviceProvider
        super.init()
        customView.signInDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SignInViewController: SignInDelegate{
    func signUpPressed() {
        customView.redoConstraint {
            self.coordinator?.goToSignUpView()
        }
        
    }
    
    func signInPressed(email: String?, password: String?) {
        guard let email = email,
              let password = password
        else {
            showAlert(title: "fields empty", message: "Please fill out all fields")
            return
        }
        
        serviceProvider.firebaseService.alertDelegate = self
        serviceProvider.firebaseService.signInUser(email: email, password: password) {
            self.customView.redoConstraint {
                self.coordinator?.goToMainView()
            }
        }
    }
}
