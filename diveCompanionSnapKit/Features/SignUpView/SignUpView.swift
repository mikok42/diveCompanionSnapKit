//
//  SignUpView.swift
//  diveCompanionSnapKit
//
//  Created by Mikołaj Linczewski on 26/05/2021.
//

import Foundation
import SnapKit

protocol SignUpDelegate: AnyObject {
    func signUpPressed(username: String?, email: String?, gender: String?, skillLevel: String?, password: String?)
    func signInPressed()
}

class SignUpView: UIView {
    weak var signUpDelegate: SignUpDelegate?
    
    var genderPickerDelegate: UIPickerViewDelegate? {
        get { genderPickerView.delegate }
        set { genderPickerView.delegate = newValue }
    }
    
    var genderPickerDataSource: UIPickerViewDataSource? {
        get { genderPickerView.dataSource }
        set { genderPickerView.dataSource = newValue }
    }
    
    var genderTextFieldContents: String? {
        get { genderTextField.text }
        set { genderTextField.text = newValue }
    }

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
    var username: String? { usernameTextField.text }
    var password: String? { passwordTextField.text }
    var gender: String? { genderTextField.text }
    var skillLevel: String? { skillLevelTextField.text }
    
    private lazy var signUpLabel = UILabel().then {
        $0.font = UIFont(name: Constants.fontName + Constants.boldFontMod, size: 21)
        $0.text = "Please sign up to use diveCompanion"
        $0.textAlignment = .center
        $0.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        $0.numberOfLines = 0
    }
    
    private lazy var emailTextField = TextFieldWithPadding(top: 1, left: 5, bottom: 1, right: 5).then {
        let placeholder = NSAttributedString(string: "email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        $0.attributedPlaceholder = placeholder
        $0.font = UIFont(name: Constants.fontName + Constants.lightFontMod, size: 15)
        $0.autocorrectionType = .no
        $0.autocapitalizationType = .none
        $0.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10.0
        $0.text = nil
    }
    
    private lazy var usernameTextField = TextFieldWithPadding(top: 1, left: 5, bottom: 1, right: 5).then {
        let placeholder = NSAttributedString(string: "username", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        $0.attributedPlaceholder = placeholder
        $0.font = UIFont(name: Constants.fontName + Constants.lightFontMod, size: 15)
        $0.autocorrectionType = .no
        $0.autocapitalizationType = .none
        $0.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10.0
        $0.text = nil
    }
    
    private lazy var passwordTextField = TextFieldWithPadding(top: 1, left: 5, bottom: 1, right: 5).then {
        let placeholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        $0.attributedPlaceholder = placeholder
        $0.font = UIFont(name: Constants.fontName + Constants.lightFontMod, size: 15)
        $0.autocorrectionType = .no
        $0.autocapitalizationType = .none
        $0.isSecureTextEntry = true
        $0.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10.0
        $0.text = nil
        $0.text = nil
    }
    
    private lazy var genderPickerView = UIPickerView().then {
        $0.isHidden = true
    }
    
    private lazy var genderTextField = TextFieldWithPadding(top: 1, left: 5, bottom: 1, right: 5).then {
        let placeholder = NSAttributedString(string: "gender", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        $0.attributedPlaceholder = placeholder
        $0.font = UIFont(name: Constants.fontName + Constants.lightFontMod, size: 15)
        $0.autocorrectionType = .no
        $0.autocapitalizationType = .none
        $0.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10.0
        $0.inputView = genderPickerView
        $0.text = nil
    }
    
    private lazy var skillLevelTextField = TextFieldWithPadding(top: 1, left: 5, bottom: 1, right: 5).then {
        let placeholder = NSAttributedString(string: "skill level", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        $0.attributedPlaceholder = placeholder
        $0.font = UIFont(name: Constants.fontName + Constants.lightFontMod, size: 15)
        $0.autocorrectionType = .no
        $0.autocapitalizationType = .none
        $0.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10.0
        $0.text = nil
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
    
    public func hideGenderPicker() {
        self.genderTextField.resignFirstResponder()
    }
    
    public func reloadGenderPickerData() {
        genderPickerView.reloadAllComponents()
    }
    
    @objc private func buttonLetGoOutside(_ sender: UIButton) {
        sender.alpha = 1
    }
    
    @objc private func buttonTouched(_ sender: UIButton) {
        sender.alpha = 0.5
    }
    
    @objc private func signUpLetGoInside(_ sender: UIButton) {
        sender.alpha = 1
        signUpDelegate?.signUpPressed(username: username, email: email, gender: gender, skillLevel: skillLevel, password: password)
    }
    
    @objc private func signInLetGoInside(_ sender: UIButton) {
        sender.alpha = 1
        signUpDelegate?.signInPressed()
    }
    
    private func addSubviews() {
        [signUpLabel, emailTextField, usernameTextField, passwordTextField, signUpButton, genderTextField, skillLevelTextField, signInButton, genderPickerView].forEach {
            addSubview($0)
        }
    }
    
    private func setupSubviews() {
        signUpLabelSetup()
        emailTextFieldSetup()
        usernameTextFieldSetup()
        passwordTextFieldSetup()
        signUpButtonSetup()
        genderTextFieldSetup()
        skillLevelTextFieldSetup()
        signInButtonSetup()
    }
    
    private func signUpLabelSetup() {
        signUpLabel.snp.makeConstraints {
            $0.top.equalTo(snp.top).inset(50)
            $0.leading.equalTo(snp.leading).inset(Constants.labelsDistance)
            $0.trailing.equalTo(snp.trailing).inset(Constants.labelsDistance)
        }
    }
    
    private func emailTextFieldSetup() {
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(signUpLabel.snp.bottom).inset(-Constants.labelsDistance)
            $0.leading.equalTo(snp.leading).inset(Constants.labelsDistance)
            $0.trailing.equalTo(snp.trailing).inset(Constants.labelsDistance)
            $0.height.equalTo(30)
        }
    }
    
    private func usernameTextFieldSetup() {
        usernameTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).inset(-Constants.labelsDistance)
            $0.leading.equalTo(snp.leading).inset(Constants.labelsDistance)
            $0.trailing.equalTo(snp.trailing).inset(Constants.labelsDistance)
            $0.height.equalTo(30)
        }
    }
    
    private func genderTextFieldSetup() {
        genderTextField.snp.makeConstraints {
            $0.top.equalTo(usernameTextField.snp.bottom).inset(-Constants.labelsDistance)
            $0.leading.equalTo(snp.leading).inset(Constants.labelsDistance)
            $0.trailing.equalTo(snp.trailing).inset(Constants.labelsDistance)
            $0.height.equalTo(30)
        }
    }
    
    private func skillLevelTextFieldSetup() {
        skillLevelTextField.snp.makeConstraints {
            $0.top.equalTo(genderTextField.snp.bottom).inset(-Constants.labelsDistance)
            $0.leading.equalTo(snp.leading).inset(Constants.labelsDistance)
            $0.trailing.equalTo(snp.trailing).inset(Constants.labelsDistance)
            $0.height.equalTo(30)
        }
    }
    
    private func passwordTextFieldSetup() {
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(skillLevelTextField.snp.bottom).inset(-Constants.labelsDistance)
            $0.leading.equalTo(snp.leading).inset(Constants.labelsDistance)
            $0.trailing.equalTo(snp.trailing).inset(Constants.labelsDistance)
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
    
    private func signInButtonSetup() {
        signInButton.snp.makeConstraints {
            $0.top.equalTo(signUpButton.snp.bottom).inset(-Constants.labelsDistance)
            $0.leading.equalTo(snp.leading).inset(Constants.labelsDistance)
            $0.trailing.equalTo(snp.trailing).inset(Constants.labelsDistance)
            $0.height.equalTo(30)
        }
    }
    
    private func genderPickerSetup() {
        genderPickerView.snp.makeConstraints {
            $0.top.equalTo(usernameTextField.snp.bottom).inset(-Constants.labelsDistance)
            $0.leading.equalTo(snp.leading).inset(Constants.labelsDistance)
            $0.trailing.equalTo(snp.trailing).inset(Constants.labelsDistance)
            $0.height.equalTo(30)
        }
    }
}
