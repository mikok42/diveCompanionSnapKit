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
    var alertDelegate: AlertDelegate? { get set }
    var user: Userdata? { get }
    var hasSignedIn: Bool { get }
    
    func signUpUser(user: Userdata, completion: @escaping (()-> Void))
    func signInUser(email: String, password: String, completion: @escaping (()-> Void))
}

class FirebaseService: FirebaseServiceProtocol {

    private let firestore = Firestore.firestore()
    private let userRef = Firestore.firestore().collection("users")
    private let auth = Auth.auth()
    
    
    weak var alertDelegate: AlertDelegate?
    
    var user: Userdata?
    
    var hasSignedIn: Bool {
        user != nil
    }
    
    func signUpUser(user: Userdata, completion: @escaping (()-> Void)) {
        guard let email = user.email else { alertDelegate?.showAlert(title: "error", message: "email"); return }
        guard let password = user.password else { alertDelegate?.showAlert(title: "password", message: "email"); return }
        auth.createUser(withEmail: email, password: password) { [weak self] (result, error) in
            guard let self = self else { return }
            if let error = error { completion(); return }
            
            self.user = user
            do {
                self.userRef.document(result!.user.uid).setData(try user.asDictionary()) { error in
                    guard error == nil else { self.alertDelegate?.showAlert(title: "password", message: "save"); return }
                    completion()
                }
            } catch {
                print(error)
            }
        }
    }
    
    func signInUser(email: String, password: String, completion: @escaping (()-> Void)) {
        auth.signIn(withEmail: email, password: password) { [weak self] (result, error) in
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
                
                #warning("popraw ten --> ! ")
                self.userRef.document(result!.user.uid).getDocument { (document, error) in
                    guard let document = document else { return }
                    
                    do {
                        let user: Userdata = try document.decoded()
                        self.user = user
                    } catch {
                        print("Karol: - \(error.localizedDescription)")
                    }
                    
                }
                completion()
            }
        }
    }
    
    func logout() {
        try? Auth.auth().signOut()
        user = nil
    }
    
}

extension DocumentSnapshot {
    func decoded<Type: Decodable>() throws -> Type {
        let jsonData = try JSONSerialization.data(withJSONObject: data() ?? [:], options: [])
        let object = try JSONDecoder().decode(Type.self, from: jsonData)
        return object
    }
}

extension QuerySnapshot {
    
    func decoded<Type: Decodable>() throws -> [Type] {
        let objects: [Type] = try documents.map({ try $0.decoded() })
        return objects
    }
}
