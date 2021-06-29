//
//  PasswordFieldWithIcon.swift
//  diveCompanionSnapKit
//
//  Created by Mikołaj Linczewski on 29/06/2021.
//

import Foundation
import UIKit
import SnapKit

class PasswordField: UIView, ProperView {
    let textFieldColor: UIColor
    let cornerRadius: CGFloat
    let textFieldInsets: UIEdgeInsets
    let fontSize: CGFloat
    
    var showPasssword: Bool
    var passwordIcons = ["🔒", "🔓"]
    
    var text: String? { passwordTextField.text }
    
    private lazy var passwordTextField = TextFieldWithPadding(insets: textFieldInsets).then {
        let placeholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        $0.attributedPlaceholder = placeholder
        $0.font = UIFont(name: Constants.fontName + Constants.lightFontMod, size: fontSize)
        $0.autocorrectionType = .no
        $0.autocapitalizationType = .none
        $0.isSecureTextEntry = !showPasssword
        $0.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        $0.backgroundColor = textFieldColor
        $0.layer.cornerRadius = cornerRadius
    }
    
    private lazy var showPasswordButton = UIButton().then {
        $0.setTitle(passwordIcons[showPasssword.Int()], for: .normal)
        $0.addTarget(self, action: #selector(showPasswordButtonPressed(_:)), for: .touchUpInside)
    }
    
    init(fontSize: CGFloat = 15, color: UIColor = .white, cornerRadius: CGFloat = 10.0, insets: UIEdgeInsets = UIEdgeInsets(top: 1, left: 5, bottom: 1, right: 5)) {
        self.cornerRadius = cornerRadius
        self.textFieldColor = color
        self.textFieldInsets = insets
        self.fontSize = fontSize
        self.showPasssword = false
        
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        self.addSubviews()
        self.setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        [passwordTextField, showPasswordButton].forEach { addSubview($0) }
    }
    
    func setupSubviews() {
        textFieldSetup()
        showPasswordButtonSetup()
    }
    
    @objc func showPasswordButtonPressed(_ sender: UIButton) {
        showPasssword = !showPasssword
        passwordTextField.isSecureTextEntry = showPasssword
        showPasswordButton.setTitle(passwordIcons[showPasssword.Int()], for: .normal)
    }
    
    private func showPasswordButtonSetup() {
        showPasswordButton.snp.makeConstraints {
            $0.trailing.equalTo(passwordTextField.snp.trailing)
            $0.top.equalTo(passwordTextField.snp.top)
            $0.bottom.equalTo(passwordTextField.snp.bottom)
        }
    }
    
    private func textFieldSetup() {
        passwordTextField.snp.makeConstraints {
            $0.leading.equalTo(snp.leading)
            $0.trailing.equalTo(snp.trailing)
        }
    }
}
