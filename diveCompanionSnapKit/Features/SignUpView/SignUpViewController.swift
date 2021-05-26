//
//  SignUpViewController.swift
//  diveCompanionSnapKit
//
//  Created by Mikołaj Linczewski on 26/05/2021.
//
//userdata jako codable
//servicy
//parametry w signupview
//login
//ładniej
import Foundation
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: CustomViewController<SignUpView> {
    weak var coordinator: MainCoordinator?
    private let fstore = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.signUpDelegate = self
    }
}

extension SignUpViewController: SignUpDelegate {
    func signUpPressed(fields: Userdata) {
        guard fields.email != nil,
              fields.username != nil
        else {
            showAlert(viewController: self, title: "fields empty", message: "Please fill out all fields")
            return
        }
        Auth.auth().createUser(withEmail: fields.email!, password: fields.password!) { (result, error) in
            guard error == nil else {
                print(error)
                return
            }
            self.fstore.collection("users").document(result!.user.uid).setData(["email" : fields.email!, "username" : fields.username!, "uid" : result!.user.uid]) { error in
                if error == nil {
                    print(error)
                }
                self.coordinator?.goToMainView()
            }
        }
    }
}
