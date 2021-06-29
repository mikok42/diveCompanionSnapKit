//
//  SignUpViewController.swift
//  diveCompanionSnapKit
//
//  Created by Mikołaj Linczewski on 26/05/2021.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: CustomViewController<SignUpView> {
    weak var coordinator: MainCoordinator?
    private var serviceProvider: ServiceProviderProtocol
    private var genders: [Gender]
    
    init(serviceProvider: ServiceProviderProtocol) {
        self.serviceProvider = serviceProvider
        self.genders = Gender.allCases
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.signUpDelegate = self
        customView.genderPickerDataSource = self
        customView.genderPickerDelegate = self
        customView.genderTextFieldDelegate = self
        customView.reloadGenderPickerData()
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

extension SignUpViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        customView.hideGenderPicker()
        customView.genderTextFieldContents = genders[row].rawValue
    }
}

extension SignUpViewController: UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.genders[row].rawValue
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Gender.allCases.count
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        customView.showGenderPicker()
    }
}
