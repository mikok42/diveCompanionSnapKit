//
//  ViewController.swift
//  diveCompanionSnapKit
//
//  Created by Mikołaj Linczewski on 22/04/2021.
//

import UIKit
import SnapKit
import SwiftUI

class ViewController: UIViewController {
    
    @IBOutlet var MainView: MainView!
    
    lazy private var siteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        subviewsArray.append(imageView)
        return imageView
    }()
    
    lazy private var siteTitleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont(name: "Avenir Next Bold", size: 21)
        subviewsArray.append(titleLabel)
        return titleLabel
    }()
    
    lazy private var siteLocationLabel: UILabel = {
        let locationLabel = UILabel()
        locationLabel.font = UIFont(name: "Avenir Next Ultra Light", size: 17)
        subviewsArray.append(locationLabel)
        return locationLabel
    }()
    
    lazy private var siteDescriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.font = UIFont(name: "Avenir Next Regular", size: 16)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        subviewsArray.append(descriptionLabel)
        return descriptionLabel
    }()
    
    var diveSites: [DiveSite] = []
    var siteArrayIterator = 0
    var subviewsArray: [UIView] = []
    let url: String = "https://raw.githubusercontent.com/mikok42/diverCompanion/master/diverCompanion/diverCompanion/siteData.json"
    let parser = JSONParser.sharedParser
    
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        layoutSubviews()
        
        parser.readFromURL(fromURL: url) { [self] (data) in
            do {
                guard let data = data else { return }
                let tempdiveSites: [DiveSite] = try parser.parse(jsonData: data)
                diveSites = tempdiveSites
//                DispatchQueue.main.async {
//                    
//                }
                assignElements()
            } catch {
                print(error)
            }
        }
    }
    
    private func addSubviews() {
        subviewsArray.forEach {
            view.addSubview($0)
        }
    }
    
    private func layoutSubviews() {
        imageSetup()
        descriptionSetup()
        locationSetup()
        titleSetup()
    }
    
    private func assignElements() {
        siteImageView.image = UIImage(named: diveSites[siteArrayIterator].pictureName)
        siteTitleLabel.text = diveSites[siteArrayIterator].name
        siteLocationLabel.text = diveSites[siteArrayIterator].location
        siteDescriptionLabel.text = diveSites[siteArrayIterator].description
    }
    
    private func imageSetup() {
        siteImageView.snp.makeConstraints { img in
            img.height.equalTo(view.snp.height).dividedBy(3)
            img.width.equalTo(view.bounds.width)
            img.centerX.equalTo(view.center)
            img.top.equalTo(view.snp.top)
        }
    }
    
    private func titleSetup() {
        siteTitleLabel.snp.makeConstraints {
            $0.topMargin.equalTo(310)
        }
    }
    
    private func locationSetup() {
        siteLocationLabel.snp.makeConstraints {
            $0.topMargin.equalTo(340)
        }
    }
    
    private func descriptionSetup() {
        siteDescriptionLabel.snp.makeConstraints {
            $0.topMargin.equalTo(370)
            $0.width.equalTo(UIScreen.main.bounds.width - 50)
        }
    }
}

//$0,najpierw setup
//buttony
//add i layout
//main view
//cykl życia view controllera

