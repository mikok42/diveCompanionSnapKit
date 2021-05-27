//
//  SignInViewController.swift
//  diveCompanionSnapKit
//
//  Created by Mikołaj Linczewski on 27/05/2021.
//

import Foundation
import FirebaseAuth

class SignInViewController: CustomViewController<SignInView> {
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
        coordinator?.goToSignUpView()
    }
    
    func signInPressed(email: String?, password: String?) {
        guard email != nil,
              password != nil
        else {
            showAlert(title: "fields empty", message: "Please fill out all fields")
            return
        }
    
        Auth.auth().signIn(withEmail: email!, password: password!) { [weak self] (result, error) in
            guard let self = self else { return }
            if let error = error as NSError? {
                switch AuthErrorCode(rawValue: error.code) {
                case .operationNotAllowed:
                    self.showAlert(title: "error", message: "logging in via email is disabled")
                    
                case .userDisabled:
                    self.showAlert(title: "error", message: "laccount disabled")
                    
                case .wrongPassword:
                    self.showAlert(title: "error", message: "lwrong password")
                    
                case .invalidEmail:
                    self.showAlert(title: "error", message: "email doesnt exist")
                    
                default:
                    self.showAlert(title: "error", message: error.localizedDescription)
                }
            } else {
                self.coordinator?.goToMainView()
            }
        }
    }
}
