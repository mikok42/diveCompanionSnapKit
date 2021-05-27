//
//  SignInView.swift
//  diveCompanionSnapKit
//
//  Created by Mikołaj Linczewski on 26/05/2021.
//

import Foundation
import SnapKit

protocol SignInDelegate: AnyObject {
    func signInPressed(email: String?, password: String?)
    func signUpPressed()
}

class SignInView: UIView {
    weak var signInDelegate: SignInDelegate?
    
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
    var password: String? { passwordTextField.text }
    
    private lazy var signInLabel = UILabel().then {
        $0.font = UIFont(name: Constants.fontName + Constants.boldFontMod, size: 21)
        $0.text = "Please sign in to use diveCompanion"
        $0.textAlignment = .center
        $0.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        $0.numberOfLines = 0
    }
    
    private lazy var emailTextField = UITextField().then {
        let placeholder = NSAttributedString(string: "email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        $0.attributedPlaceholder = placeholder
        $0.font = UIFont(name: Constants.fontName + Constants.lightFontMod, size: 15)
        $0.autocorrectionType = .no
        $0.autocapitalizationType = .none
        $0.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10.0
    }
    
    private lazy var passwordTextField = UITextField().then {
        let placeholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        $0.attributedPlaceholder = placeholder
        $0.font = UIFont(name: Constants.fontName + Constants.lightFontMod, size: 15)
        $0.autocorrectionType = .no
        $0.autocapitalizationType = .none
        $0.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10.0
    }
    
    private lazy var signInButton = UIButton().then {
        $0.titleLabel?.font = UIFont(name: Constants.fontName, size: 20)
        $0.setTitle("Sign in", for: .normal)
        $0.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        $0.backgroundColor = .blue
        $0.layer.cornerRadius = 10.0
        
        $0.addTarget(self, action: #selector(signInLetGoInside(_:)), for: .touchUpInside)
        $0.addTarget(self, action: #selector(buttonLetGoOutside(_:)), for: .touchUpOutside)
        $0.addTarget(self, action: #selector(buttonTouched), for: .touchDown)
    }
    
    private lazy var signUpButton = UIButton().then {
        $0.titleLabel?.font = UIFont(name: Constants.fontName, size: 20)
        $0.setTitle("Sign up", for: .normal)
        $0.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        $0.backgroundColor = .blue
        $0.layer.cornerRadius = 10.0
        
        $0.addTarget(self, action: #selector(signUpLetGoInside(_:)), for: .touchUpInside)
        $0.addTarget(self, action: #selector(buttonLetGoOutside(_:)), for: .touchUpOutside)
        $0.addTarget(self, action: #selector(buttonTouched), for: .touchDown)
    }
    
    @objc private func buttonLetGoOutside(_ sender: UIButton) {
        sender.alpha = 1
    }
    
    @objc private func buttonTouched(_ sender: UIButton) {
        sender.alpha = 0.5
    }
    
    @objc private func signInLetGoInside(_ sender: UIButton) {
        sender.alpha = 1
        signInDelegate?.signInPressed(email: email, password: password)
    }
    
    @objc private func signUpLetGoInside(_ sender: UIButton) {
        sender.alpha = 1
        signInDelegate?.signUpPressed()
    }
    
    private func addSubviews() {
        [signInLabel, emailTextField, passwordTextField, signInButton, signUpButton].forEach {
            addSubview($0)
        }
    }
    
    private func setupSubviews() {
        signInLabelSetup()
        emailTextFieldSetup()
        passwordTextFieldSetup()
        signInButtonSetup()
        signUpButtonSetup()
    }
    
    private func signInLabelSetup() {
        signInLabel.snp.makeConstraints {
            $0.top.equalTo(snp.top).inset(50)
            $0.leading.equalTo(snp.leading).inset(Constants.labelsDistance)
            $0.trailing.equalTo(snp.trailing).inset(Constants.labelsDistance)
        }
    }
   
    private func emailTextFieldSetup() {
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(signInLabel.snp.bottom).inset(-Constants.labelsDistance)
            $0.leading.equalTo(snp.leading).inset(Constants.labelsDistance)
            $0.trailing.equalTo(snp.trailing).inset(Constants.labelsDistance)
            $0.height.equalTo(30)
        }
    }

    private func passwordTextFieldSetup() {
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).inset(-Constants.labelsDistance)
            $0.leading.equalTo(snp.leading).inset(Constants.labelsDistance)
            $0.trailing.equalTo(snp.trailing).inset(Constants.labelsDistance)
            $0.height.equalTo(30)
        }
    }

    private func signInButtonSetup() {
        signInButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).inset(-Constants.labelsDistance)
            $0.leading.equalTo(snp.leading).inset(Constants.labelsDistance)
            $0.trailing.equalTo(snp.trailing).inset(Constants.labelsDistance)
            $0.height.equalTo(30)
        }
    }
    
    private func signUpButtonSetup() {
        signUpButton.snp.makeConstraints {
            $0.top.equalTo(signInButton.snp.bottom).inset(-Constants.labelsDistance)
            $0.leading.equalTo(snp.leading).inset(Constants.labelsDistance)
            $0.trailing.equalTo(snp.trailing).inset(Constants.labelsDistance)
            $0.height.equalTo(30)
        }
    }
}
