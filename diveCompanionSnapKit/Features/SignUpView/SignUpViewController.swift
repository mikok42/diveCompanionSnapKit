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
        guard email != nil,
              username != nil,
              gender != nil,
              skillLevel != nil,
              password != nil
        else {
            showAlert(viewController: self, title: "fields empty", message: "Please fill out all fields")
            return
        }
        Auth.auth().createUser(withEmail: email!, password: password!) { (result, error) in
            guard error == nil else { print(error) ; return }
            do {
                let fields = Userdata(username: username, email: email, password: password, uid: result!.user.uid, skillLevel: skillLevel, gender: gender)
                self.fstore.collection("users").document(result!.user.uid).setData(try fields.asDictionary()) { error in
                    guard error == nil else { print(error) ; return }
                    self.coordinator?.goToMainView()
                }
            } catch {
                print(error)
            }
            
        }
        serviceProvider.userSettings.hasSignedUp = true
        serviceProvider.userSettings.username = username!
    }
}
