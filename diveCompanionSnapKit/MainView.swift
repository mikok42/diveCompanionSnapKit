//
//  MainView.swift
//  diveCompanionSnapKit
//
//  Created by Mikołaj Linczewski on 22/04/2021.
//

import Foundation
import UIKit

protocol ButtonDelegate: AnyObject {
    func prevButtonPressed()
    func nextButtonPressed()
}

protocol ButtonDataSource: AnyObject {
    func homeButtonPressed() -> UIColor?
}

//extension ButtonDelegate {
//    func homeButtonPressed() {
//        print("home")
//    }
//}

class MainView: UIView {
    weak var buttonDelegate: ButtonDelegate?
    weak var buttonDataSource: ButtonDataSource?
    
    // MARK: Controlls
    private lazy var buttonStackView = UIStackView().then {
        $0.distribution = .fillEqually
        $0.alignment = .fill
        $0.contentMode = .scaleToFill
        $0.axis = .horizontal
        $0.spacing = 0
    }
    
    private lazy var siteImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var siteTitleLabel = UILabel().then {
        $0.font = UIFont(name: Constants.fontName + Constants.boldFontMod, size: 21)
    }
    
    private lazy var siteLocationLabel = UILabel().then {
        $0.font = UIFont(name: Constants.fontName + Constants.lightFontMod, size: 17)
    }
    
    private lazy var siteDescriptionLabel = UILabel().then {
        $0.font = UIFont(name: Constants.fontName, size: 16)
        $0.numberOfLines = 0
        $0.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }
    
    private lazy var prevButton = UIButton().then {
        $0.setTitle("⬅️", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        $0.backgroundColor = #colorLiteral(red: 0.3617562354, green: 0.5512250662, blue: 0.6475913525, alpha: 1)
        $0.addTarget(self, action: #selector(prevButtonLetGo(_:)), for: .touchUpInside)
        $0.addTarget(self, action: #selector(buttonLetGoOutside(_:)), for: .touchUpOutside)
        $0.addTarget(self, action: #selector(buttonTouched), for: .touchDown)
    }
    
    private lazy var nextButton = UIButton().then {
        $0.setTitle("➡️", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        $0.backgroundColor = #colorLiteral(red: 0.3617562354, green: 0.5512250662, blue: 0.6475913525, alpha: 1)
        $0.addTarget(self, action: #selector(nextButtonLetGo(_:)), for: .touchUpInside)
        $0.addTarget(self, action: #selector(buttonLetGoOutside(_:)), for: .touchUpOutside)
        $0.addTarget(self, action: #selector(buttonTouched), for: .touchDown)
    }
    
    private lazy var homeButton = UIButton().then {
        $0.setTitle("🏠", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        $0.backgroundColor = #colorLiteral(red: 0.9946475625, green: 0.8637236357, blue: 0.7171586156, alpha: 1)
        $0.addTarget(self, action: #selector(homeButtonLetGo(_:)), for: .touchUpInside)
        $0.addTarget(self, action: #selector(buttonLetGoOutside(_:)), for: .touchUpOutside)
        $0.addTarget(self, action: #selector(buttonTouched), for: .touchDown)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        addSubviews()
        setupSubviews()
    }
    
    // MARK: Public funcs
    func populate(siteTitle: String, siteDescription: String, siteLocation: String, siteImageName: String) {
        siteImageView.image = UIImage(named: siteImageName)
        siteTitleLabel.text = siteTitle
        siteLocationLabel.text = siteLocation
        siteDescriptionLabel.text = siteDescription
    }
    
    // MARK: Buttons
    @objc private func buttonLetGoOutside(_ sender: UIButton) {
        sender.alpha = 1
    }
    
    @objc private func buttonTouched(_ sender: UIButton) {
        sender.alpha = 0.5
    }
    
    @objc private func nextButtonLetGo(_ sender: UIButton) {
        sender.alpha = 1
        buttonDelegate?.nextButtonPressed()
    }
    
    @objc private func prevButtonLetGo(_ sender: UIButton) {
        sender.alpha = 1
        buttonDelegate?.prevButtonPressed()
    }
    
    @objc private func homeButtonLetGo(_ sender: UIButton) {
        sender.alpha = 1
        let colour = buttonDataSource?.homeButtonPressed()
        sender.backgroundColor = colour
        //buttonDelegate?.homeButtonPressed()
    }
    
    // MARK: Private funcs
    private func addSubviews() {
        [siteImageView, siteLocationLabel, siteDescriptionLabel, siteTitleLabel, prevButton, nextButton, homeButton, buttonStackView].forEach {
            addSubview($0)
        }
    }
    
    private func setupSubviews() {
        imageSetup()
        descriptionSetup()
        locationSetup()
        titleSetup()
        prevButtonSetup()
        nextButtonSetup()
        homeButtonSetup()
        setUpButtonView()
    }
    
    private func setUpButtonView() {
        buttonStackView.snp.makeConstraints {
            $0.bottom.equalTo(snp.bottom).inset(20)
            $0.leading.equalTo(snp.leading)
            $0.trailing.equalTo(snp.trailing)
            $0.height.equalTo(38)
        }
        buttonStackView.addSubview(prevButton)
        buttonStackView.addSubview(nextButton)
        buttonStackView.addSubview(homeButton)
    }
    
    private func prevButtonSetup() {
        prevButton.snp.makeConstraints {
            $0.width.equalTo(snp.width).dividedBy(3)
            $0.leading.equalTo(homeButton.snp.trailing)
        }
    }
    
    private func nextButtonSetup() {
        nextButton.snp.makeConstraints {
            $0.width.equalTo(snp.width).dividedBy(3)
            $0.leading.equalTo(prevButton.snp.trailing)
        }
    }
    
    private func homeButtonSetup() {
        homeButton.snp.makeConstraints {
            $0.leading.equalTo(snp.leading)
            $0.width.equalTo(snp.width).dividedBy(3)
        }
    }
    
    private func imageSetup() {
        siteImageView.snp.makeConstraints {
            $0.top.equalTo(snp.top)
            $0.leading.equalTo(snp.leading)
            $0.trailing.equalTo(snp.trailing)
            $0.height.lessThanOrEqualTo(snp.height).dividedBy(3)
        }
    }
    
    private func titleSetup() {
        siteTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(safeAreaLayoutGuide).inset(Constants.labelsMargins)
            $0.topMargin.equalTo(siteImageView.snp_bottomMargin).inset(-Constants.labelsDistance)
        }
    }
    
    private func locationSetup() {
        siteLocationLabel.snp.makeConstraints {
            $0.leading.equalTo(safeAreaLayoutGuide).inset(Constants.labelsMargins)
            $0.topMargin.equalTo(siteTitleLabel.snp_bottomMargin).inset(-Constants.labelsDistance)
        }
    }
    
    private func descriptionSetup() {
        siteDescriptionLabel.snp.makeConstraints {
            $0.leading.equalTo(safeAreaLayoutGuide).inset(Constants.labelsMargins)
            $0.topMargin.equalTo(siteLocationLabel.snp_bottomMargin).inset(-Constants.labelsDistance)
            $0.width.equalTo(snp.width).inset(30)
            $0.bottomMargin.lessThanOrEqualTo(buttonStackView.snp_topMargin).inset(Constants.labelsDistance)
        }
    }
}


