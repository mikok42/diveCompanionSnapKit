//
//  SignUpView.swift
//  diveCompanionSnapKit
//
//  Created by Mikołaj Linczewski on 26/05/2021.
//

import Foundation
import SnapKit

protocol SignUpDelegate: AnyObject {
    func signUpPressed(fields: Userdata)
}

class SignUpView: UIView {
    weak var signUpDelegate: SignUpDelegate?
    
    init() {
        super.init(frame: .zero)
        backgroundColor = Constants.backgroundColour
        addSubviews()
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var email: String? { emailTextField.text }
    
    private lazy var signUpLabel = UILabel().then {
        $0.font = UIFont(name: Constants.fontName + Constants.boldFontMod, size: 21)
        $0.text = "Please sign up to use diveCompanion"
        $0.textAlignment = .center
        $0.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
    }
    
    private lazy var emailTextField = UITextField().then {
        $0.font = UIFont(name: Constants.fontName + Constants.lightFontMod, size: 15)
        $0.placeholder = "email"
        $0.autocorrectionType = .no
        $0.autocapitalizationType = .none
        $0.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
    }
    
    private lazy var usernameTextField = UITextField().then {
        $0.font = UIFont(name: Constants.fontName + Constants.lightFontMod, size: 15)
        $0.placeholder = "username"
        $0.autocorrectionType = .no
        $0.autocapitalizationType = .none
        $0.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
    }
    
    private lazy var passwordTextField = UITextField().then {
        $0.font = UIFont(name: Constants.fontName + Constants.lightFontMod, size: 15)
        $0.placeholder = "password"
        $0.autocorrectionType = .no
        $0.autocapitalizationType = .none
        $0.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
    }
    
    private lazy var signUpButton = UIButton().then {
        $0.titleLabel?.font = UIFont(name: Constants.fontName, size: 20)
        $0.setTitle("Sign up", for: .normal)
        $0.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        $0.backgroundColor = .blue
        
        $0.addTarget(self, action: #selector(buttonLetGoInside(_:)), for: .touchUpInside)
        $0.addTarget(self, action: #selector(signUpLetGoOutside(_:)), for: .touchUpOutside)
        $0.addTarget(self, action: #selector(buttonTouched), for: .touchDown)
    }
    
    @objc private func signUpLetGoOutside(_ sender: UIButton) {
        sender.alpha = 1
    }
    
    @objc private func buttonTouched(_ sender: UIButton) {
        sender.alpha = 0.5
    }
    
    @objc private func buttonLetGoInside(_ sender: UIButton) {
        sender.alpha = 1
        let username = usernameTextField.text
        let email = self.email
        let password = passwordTextField.text
    
        let userdata = Userdata(username: username, email: email, password: password)
        signUpDelegate?.signUpPressed(fields: userdata)
    }
    
    private func addSubviews() {
        [signUpLabel, emailTextField, usernameTextField, passwordTextField, signUpButton].forEach {
            addSubview($0)
        }
    }
    
    private func setupSubviews() {
        signUpLabelSetup()
        emailTextFieldSetup()
        usernameTextFieldSetup()
        passwordTextFieldSetup()
        signUpButtonSetup()
    }
    
    private func signUpLabelSetup() {
        signUpLabel.snp.makeConstraints {
            $0.top.equalTo(snp.top).inset(50)
            $0.leading.equalTo(snp.leading).inset(Constants.labelsDistance)
            $0.trailing.equalTo(snp.trailing).inset(Constants.labelsDistance)
            $0.height.equalTo(30)
        }
    }
    
    private func emailTextFieldSetup() {
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(signUpLabel.snp.bottom).inset(-Constants.labelsDistance)
            $0.leading.equalTo(snp.leading).inset(Constants.labelsDistance)
            $0.height.equalTo(30)
        }
    }
    
    private func usernameTextFieldSetup() {
        usernameTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).inset(-Constants.labelsDistance)
            $0.leading.equalTo(snp.leading).inset(Constants.labelsDistance)
            $0.height.equalTo(30)
        }
    }
    
    private func passwordTextFieldSetup() {
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(usernameTextField.snp.bottom).inset(-Constants.labelsDistance)
            $0.leading.equalTo(snp.leading).inset(Constants.labelsDistance)
            $0.height.equalTo(30)
        }
    }
    
    private func signUpButtonSetup() {
        signUpButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).inset(-Constants.labelsDistance)
            $0.leading.equalTo(snp.leading).inset(Constants.labelsDistance)
            $0.trailing.equalTo(snp.trailing).inset(Constants.labelsDistance)
            $0.height.equalTo(30)
        }
    }
}
