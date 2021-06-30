//
//  UserDetailsView.swift
//  diveCompanionSnapKit
//
//  Created by Mikołaj Linczewski on 29/06/2021.
//

import Foundation
import SnapKit
import FirebaseFirestore

protocol DetailsViewButtonsDelegate: AnyObject {
    func homeButtonPressed()
}

class UserDetailsView: UIView, ProperView {
    public var userName: String? {
        get { userNameLabel.text }
        set { userNameLabel.text = newValue ?? "diver" }
    }
    public var userEmail: String? {
        get { userEmailLabel.text }
        set { userEmailLabel.text = "email: \(newValue ??  "email")"}
    }
    public var userGender: String? {
        get { userGenderLabel.text }
        set { userGenderLabel.text = "gender: \(newValue ?? "gender")" }
    }
    public var userSkillLevel: String? {
        get { userSkillLevelLabel.text }
        set { userSkillLevelLabel.text = "skill level: \(newValue ?? "skills")" }
    }
    
    weak var buttonDelegate: DetailsViewButtonsDelegate?
    
    private lazy var userNameLabel = UILabel().then {
        $0.font = UIFont(name: Constants.fontName + Constants.boldFontMod, size: 21)
        $0.textAlignment = .center
    }
    
    private lazy var userEmailLabel = UILabel().then {
        $0.font = UIFont(name: Constants.fontName, size: 20)
    }
    
    private lazy var userSkillLevelLabel = UILabel().then {
        $0.font = UIFont(name: Constants.fontName, size: 20)
    }
    
    private lazy var userGenderLabel = UILabel().then {
        $0.font = UIFont(name: Constants.fontName, size: 20)
    }
    
    private lazy var homeButton = UIButton().then {
        $0.setTitle("🏠", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        $0.backgroundColor = #colorLiteral(red: 0.9946475625, green: 0.8637236357, blue: 0.7171586156, alpha: 1)
        $0.frame = CGRect(x: 0, y: 0, width: 45, height: 45)
        $0.layer.cornerRadius = 0.5 * $0.bounds.size.width
        
        $0.addTarget(self, action: #selector(homeButtonLetGo(_:)), for: .touchUpInside)
        $0.addTarget(self, action: #selector(buttonLetGoOutside(_:)), for: .touchUpOutside)
        $0.addTarget(self, action: #selector(buttonTouched), for: .touchDown)
    }
    
    init() {
        super.init(frame: .zero)
        addSubviews()
        setupSubviews()
        self.backgroundColor = Constants.backgroundColour
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func addSubviews() {
        [userNameLabel, userEmailLabel, userGenderLabel, userSkillLevelLabel, homeButton].forEach { addSubview($0) }
    }
    
    public func setupSubviews() {
        userNameLabelSetup()
        userEmailLabelSetup()
        userGenderLabelSetup()
        userSkillLevelLabelSetup()
        homeButtonSetup()
    }
    
    @objc private func buttonLetGoOutside(_ sender: UIButton) {
        sender.alpha = 1
    }
    
    @objc private func buttonTouched(_ sender: UIButton) {
        sender.alpha = 0.5
    }
    
    @objc private func homeButtonLetGo(_ sender: UIButton) {
        sender.alpha = 1
        buttonDelegate?.homeButtonPressed()
    }
    
    private func userNameLabelSetup() {
        userNameLabel.snp.makeConstraints {
            $0.leading.equalTo(snp.leading)
            $0.trailing.equalTo(snp.trailing)
            $0.top.equalTo(safeAreaLayoutGuide).offset(Constants.labelsMargins)
        }
    }
    
    private func userEmailLabelSetup() {
        userEmailLabel.snp.makeConstraints {
            $0.leading.equalTo(snp.leading)
            $0.trailing.equalTo(snp.trailing)
            $0.top.equalTo(userNameLabel.snp.bottom)
        }
    }
    
    private func userGenderLabelSetup() {
        userGenderLabel.snp.makeConstraints {
            $0.leading.equalTo(snp.leading)
            $0.trailing.equalTo(snp.trailing)
            $0.top.equalTo(userEmailLabel.snp.bottom).inset(-Constants.labelsMargins)
        }
    }
    
    private func userSkillLevelLabelSetup() {
        userSkillLevelLabel.snp.makeConstraints {
            $0.leading.equalTo(snp.leading)
            $0.trailing.equalTo(snp.trailing)
            $0.top.equalTo(userGenderLabel.snp.bottom).inset(-Constants.labelsMargins)
        }
    }
    
    private func homeButtonSetup() {
        homeButton.snp.makeConstraints {
            $0.centerX.equalTo(snp.centerX)
            $0.bottom.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(45)
            $0.width.equalTo(45)
        }
    }
}
