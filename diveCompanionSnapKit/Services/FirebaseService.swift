//
//  FirebaseService.swift
//  diveCompanionSnapKit
//
//  Created by Mikołaj Linczewski on 27/05/2021.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

protocol FirebaseServiceProtocol {
    var firestore: Firestore { get }
    var alertDelegate: AlertDelegate? { get set}
    
    func signUpUser(username: String, email: String, gender: String, skillLevel: String, password: String,  completion: @escaping (()->()) )
    
    func signInUser(email: String, password: String, completion: @escaping ( ()->() ))
}

class FirebaseService: FirebaseServiceProtocol {
    var firestore: Firestore
    weak var alertDelegate: AlertDelegate?
    
    init() {
        self.firestore = Firestore.firestore()
    }
    
    func signUpUser(username: String, email: String, gender: String, skillLevel: String, password: String, completion: @escaping (()->())) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            guard error == nil else { print(error) ; return }
            completion()
            do {
                let fields = Userdata(username: username, email: email, password: password, uid: result!.user.uid, skillLevel: skillLevel, gender: gender)
                self.firestore.collection("users").document(result!.user.uid).setData(try fields.asDictionary()) { error in
                    guard error == nil else { print(error) ; return }
                    Firestore.firestore().collection("users").document("\(result!.user.uid)").getDocument { snapshot, error in
                        let data = snapshot?.data() ?? [:]
                        do {
                            let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
                            let user = try JSONDecoder().decode(Userdata.self, from: jsonData)
                            print(user)
                        } catch {
                            print(error)
                        }
                    }
                }
            } catch {
                print(error)
            }
            
        }
    }
    
    func signInUser(email: String, password: String, completion: @escaping ( ()->() )) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (result, error) in
            guard let self = self else { return }
            if let error = error as NSError? {
                switch AuthErrorCode(rawValue: error.code) {
                case .operationNotAllowed:
                    self.alertDelegate?.showAlert(title: "error", message: "logging in via email is disabled")
                    
                case .userDisabled:
                    self.alertDelegate?.showAlert(title: "error", message: "account disabled")
                    
                case .wrongPassword:
                    self.alertDelegate?.showAlert(title: "error", message: "lwrong password")
                    
                case .invalidEmail:
                    self.alertDelegate?.showAlert(title: "error", message: "email doesnt exist")
                    
                default:
                    self.alertDelegate?.showAlert(title: "error", message: error.localizedDescription)
                }
            } else {
                completion()
            }
        }
    }
    
    
}
