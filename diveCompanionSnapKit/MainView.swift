//
//  MainView.swift
//  diveCompanionSnapKit
//
//  Created by Mikołaj Linczewski on 22/04/2021.
//

import Foundation
import UIKit

class MainView: UIView {
    
    // MARK: Controlls
    lazy private var buttonStackView: UIStackView = {
        let buttonStack = UIStackView()
        buttonStack.distribution = .fillEqually
        buttonStack.alignment = .fill
        buttonStack.contentMode = .scaleToFill
        buttonStack.axis = .horizontal
        buttonStack.spacing = 0
        return buttonStack
    }()
    
    lazy private var siteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy private var siteTitleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont(name: "Avenir Next Bold", size: 21)
        return titleLabel
    }()
    
    lazy private var siteLocationLabel: UILabel = {
        let locationLabel = UILabel()
        locationLabel.font = UIFont(name: "Avenir Next Ultra Light", size: 17)
        return locationLabel
    }()
    
    lazy private var siteDescriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.font = UIFont(name: "Avenir Next Regular", size: 16)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return descriptionLabel
    }()
    
    lazy private var prevButton: UIButton = {
        let button = UIButton()
        button.setTitle("⬅️", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.backgroundColor = UIColor.init(red: 92.0/255.0, green: 141.0/255.0, blue: 165.0/255.0, alpha: 1)
        button.addTarget(self, action: #selector(prevButtonLetGo(_:)), for: .touchUpInside)
        button.addTarget(self, action: #selector(buttonLetGoOutside(_:)), for: .touchUpOutside)
        button.addTarget(self, action: #selector(buttonTouched), for: .touchDown)
        return button
    }()
    
    lazy private var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("➡️", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.backgroundColor = UIColor(red: 92.0/255.0, green: 141.0/255.0, blue: 165.0/255.0, alpha: 1)
        button.addTarget(self, action: #selector(nextButtonLetGo(_:)), for: .touchUpInside)
        button.addTarget(self, action: #selector(buttonLetGoOutside(_:)), for: .touchUpOutside)
        button.addTarget(self, action: #selector(buttonTouched), for: .touchDown)
        return button
    }()
    
    lazy private var homeButton: UIButton = {
        let button = UIButton()
        button.setTitle("🏠", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.backgroundColor = UIColor(red: 254.0/255.0, green: 220.0/255.0, blue: 183.0/255.0, alpha: 1)
        button.addTarget(self, action: #selector(homeButtonLetGo(_:)), for: .touchUpInside)
        button.addTarget(self, action: #selector(buttonLetGoOutside(_:)), for: .touchUpOutside)
        button.addTarget(self, action: #selector(buttonTouched), for: .touchDown)
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
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
    @objc func buttonLetGoOutside(_ sender: UIButton) {
        sender.alpha = 1
    }
    
    @objc func buttonTouched(_ sender: UIButton) {
        sender.alpha = 0.5
    }
    
    @objc func nextButtonLetGo(_ sender: UIButton) {
        sender.alpha = 1
    }
    
    @objc func prevButtonLetGo(_ sender: UIButton) {
        sender.alpha = 1
    }
   
    @objc func homeButtonLetGo(_ sender: UIButton) {
        sender.alpha = 1
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
        }
    }
}


