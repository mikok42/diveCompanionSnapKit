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
    lazy private var siteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy private var siteTitleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont(name: "Avenir Next Bold", size: 21)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    lazy private var siteLocationLabel: UILabel = {
        let locationLabel = UILabel()
        locationLabel.font = UIFont(name: "Avenir Next Ultra Light", size: 17)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        return locationLabel
    }()
    
    lazy private var siteDescriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.font = UIFont(name: "Avenir Next Regular", size: 16)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return descriptionLabel
    }()
    
    lazy private var prevButton: UIButton = {
        let button = UIButton()
        button.setTitle("⬅️", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy private var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("➡️", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy private var homeButton: UIButton = {
        let button = UIButton()
        button.setTitle("🏠", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
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
    
    // MARK: Private funcs
    private func addSubviews() {
        [siteImageView, siteLocationLabel, siteDescriptionLabel, siteTitleLabel].forEach {
            addSubview($0)
        }
    }
    
    private func setupSubviews() {
        imageSetup()
        descriptionSetup()
        locationSetup()
        titleSetup()
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
            $0.topMargin.equalTo(siteImageView.snp_bottomMargin).inset(-20)
        }
    }
    
    private func locationSetup() {
        siteLocationLabel.snp.makeConstraints {
            $0.topMargin.equalTo(siteTitleLabel.snp_bottomMargin).inset(-15)
        }
    }
    
    private func descriptionSetup() {
        siteDescriptionLabel.snp.makeConstraints {
            $0.leading.equalTo(snp.leading).inset(8)
           // $0.trailing.equalTo(snp.trailing).inset(-40)
            $0.topMargin.equalTo(siteLocationLabel.snp_bottomMargin).inset(-15)
            $0.width.equalTo(snp.width).inset(30)
        }
    }
}


