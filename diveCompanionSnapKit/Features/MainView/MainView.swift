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
    func homeButtonPressed()
}

//protocol ButtonDataSource: AnyObject {
//    func homeButtonPressed() -> UIColor?
//}

//extension ButtonDelegate {
//    func homeButtonPressed() {
//        print("home")
//    }
//}


class MainView: UIView {
    weak var buttonDelegate: ButtonDelegate?
    
    init() {
        super.init(frame: .zero)
        backgroundColor = #colorLiteral(red: 0.5125905286, green: 1, blue: 0.9507776416, alpha: 1)
        addSubviews()
        setupSubviews()
        addGestures()
        fadeIn(duration: 0.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Controlls
    private lazy var buttonStackView = UIStackView().then {
        $0.distribution = .fillEqually
        $0.alignment = .fill
        $0.axis = .horizontal
        $0.spacing = 0
        $0.alpha = 0
    }

    private lazy var textView = UITextView().then {
        $0.isEditable = false
        $0.isScrollEnabled = true
        $0.isUserInteractionEnabled = true
        $0.font = UIFont(name: Constants.fontName, size: 16)
        $0.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        $0.backgroundColor = superview?.backgroundColor
        $0.bounces = true
        $0.alpha = 0
    }
    
    private lazy var siteImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.alpha = 0
    }
    
    private lazy var siteTitleLabel = UILabel().then {
        $0.font = UIFont(name: Constants.fontName + Constants.boldFontMod, size: 21)
        $0.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        $0.alpha = 0
    }
    
    private lazy var siteLocationLabel = UILabel().then {
        $0.font = UIFont(name: Constants.fontName + Constants.lightFontMod, size: 17)
        $0.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        $0.alpha = 0

    }

    private lazy var prevButton = UIButton().then {
        $0.setTitle("⬅️", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        $0.backgroundColor = #colorLiteral(red: 0.3617562354, green: 0.5512250662, blue: 0.6475913525, alpha: 1)
        $0.addTarget(self, action: #selector(prevButtonLetGo(_:)), for: .touchUpInside)
        $0.addTarget(self, action: #selector(buttonLetGoOutside(_:)), for: .touchUpOutside)
        $0.addTarget(self, action: #selector(buttonTouched), for: .touchDown)
        $0.alpha = 0
    }
    
    private lazy var nextButton = UIButton().then {
        $0.setTitle("➡️", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        $0.backgroundColor = #colorLiteral(red: 0.3617562354, green: 0.5512250662, blue: 0.6475913525, alpha: 1)
        $0.addTarget(self, action: #selector(nextButtonLetGo(_:)), for: .touchUpInside)
        $0.addTarget(self, action: #selector(buttonLetGoOutside(_:)), for: .touchUpOutside)
        $0.addTarget(self, action: #selector(buttonTouched), for: .touchDown)
        $0.alpha = 0
    }
    
    private lazy var homeButton = UIButton().then {
        $0.setTitle("🏠", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        $0.backgroundColor = #colorLiteral(red: 0.9946475625, green: 0.8637236357, blue: 0.7171586156, alpha: 1)
        $0.addTarget(self, action: #selector(homeButtonLetGo(_:)), for: .touchUpInside)
        $0.addTarget(self, action: #selector(buttonLetGoOutside(_:)), for: .touchUpOutside)
        $0.addTarget(self, action: #selector(buttonTouched), for: .touchDown)
        $0.alpha = 0
    }
    
    private lazy var leftSwipe = UISwipeGestureRecognizer().then {
        $0.direction = .right
        $0.addTarget(self, action: #selector(swipeLeft(_:)))
    }
    
    private lazy var upSwipe = UISwipeGestureRecognizer().then {
        $0.direction = .down
        $0.addTarget(self, action: #selector(swipeUp(_:)))
    }
    
    private lazy var rightSwipe = UISwipeGestureRecognizer().then {
        $0.direction = .left
        $0.addTarget(self, action: #selector(swipeRight(_:)))
    }

    
    // MARK: Public funcs
    func populate(siteTitle: String, siteDescription: String, siteLocation: String, siteImageName: String) {
        let fullURL = Constants.imageRepo  + siteImageName + ".jpg?raw=true"
        siteImageView.kf.setImage(
            with: URL(string: fullURL),
            placeholder: UIImage(named: "salemWreck"),
            options: [.transition(.fade(1))]
        )
        siteTitleLabel.text = siteTitle
        siteLocationLabel.text = siteLocation
        textView.text = siteDescription
    }
    
    func fadeIn(duration: Double, _ completion: (() -> Void)? = nil) {
        super.fadeIn(viewsToAnimate: [buttonStackView, prevButton, nextButton, homeButton, textView, siteTitleLabel, siteLocationLabel, siteImageView], duration: duration) {
            completion?()
        }
    }
    
    func fadeOut(duration: Double, _ completion: (() -> Void)? = nil) {
        super.fadeOut(viewsToAnimate: [buttonStackView, prevButton, nextButton, homeButton, textView, siteTitleLabel, siteLocationLabel, siteImageView], duration: duration) {
            completion?()
        }
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
        buttonDelegate?.homeButtonPressed()
    }
    
    @objc private func swipeRight(_ sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            buttonDelegate?.nextButtonPressed()
        }
    }
    
    @objc private func swipeLeft(_ sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            buttonDelegate?.prevButtonPressed()
        }
    }
    
    @objc private func swipeUp(_ sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            buttonDelegate?.homeButtonPressed()
        }
    }
    
    // MARK: Private funcs
    private func addSubviews() {
        [buttonStackView, textView, siteTitleLabel, siteLocationLabel, siteImageView].forEach {
            addSubview($0)
        }
    }
    
    private func addGestures() {
        [leftSwipe, rightSwipe, upSwipe].forEach { addGestureRecognizer($0) }
    }
    
    private func setupSubviews() {
        imageSetup()
        textViewSetup()
        locationSetup()
        titleSetup()
        setUpButtonView()
        prevButtonSetup()
        nextButtonSetup()
        homeButtonSetup()
    }
    
    private func textViewSetup() {
        textView.snp.makeConstraints {
            $0.top.equalTo(siteLocationLabel.snp.bottom).inset(-Constants.labelsDistance)
            $0.leading.equalTo(siteTitleLabel.snp.leading)
            $0.trailing.equalTo(safeAreaLayoutGuide).inset(Constants.labelsMargins)
            $0.bottom.equalTo(buttonStackView.snp.top).inset(-Constants.labelsDistance)
        }
    }
    
    private func setUpButtonView() {
        [prevButton, nextButton, homeButton].forEach { buttonStackView.addSubview($0) }
        buttonStackView.snp.makeConstraints {
            $0.bottom.equalTo(snp.bottom).inset(20)
            $0.leading.equalTo(snp.leading)
            $0.trailing.equalTo(snp.trailing)
            $0.height.equalTo(38)
        }
    }
    
    private func prevButtonSetup() {
        prevButton.snp.makeConstraints {
            $0.leading.equalTo(homeButton.snp.trailing)
            $0.width.equalTo(buttonStackView.snp.width).dividedBy(buttonStackView.subviews.count)
        }
    }

    private func nextButtonSetup() {
        nextButton.snp.makeConstraints {
            $0.leading.equalTo(prevButton.snp.trailing)
            $0.trailing.equalTo(buttonStackView.snp.trailing)
            $0.width.equalTo(buttonStackView.snp.width).dividedBy(buttonStackView.subviews.count)
        }
    }

    private func homeButtonSetup() {
        homeButton.snp.makeConstraints {
            $0.leading.equalTo(buttonStackView.snp.leading)
            $0.width.equalTo(buttonStackView.snp.width).dividedBy(buttonStackView.subviews.count)
        }
    }

    private func imageSetup() {
        siteImageView.snp.makeConstraints {
            $0.top.equalTo(snp.top)
            $0.leading.equalTo(snp.leading)
            $0.trailing.equalTo(snp.trailing)
            $0.height.equalTo(snp.height).dividedBy(3)
        }
    }
    
    private func titleSetup() {
        siteTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(safeAreaLayoutGuide).inset(Constants.labelsMargins)
            $0.top.equalTo(siteImageView.snp.bottom)
        }
    }
    
    private func locationSetup() {
        siteLocationLabel.snp.makeConstraints {
            $0.leading.equalTo(siteTitleLabel.snp.leading)
            $0.top.equalTo(siteTitleLabel.snp.bottom).inset(-Constants.labelsDistance)
        }
    }
}

