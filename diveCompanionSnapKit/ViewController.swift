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
    
    var siteImage = UIImageView()
    var siteTitle = UILabel()
    var siteLocation = UILabel()
    var siteDescription = UILabel()
    
    var diveSites: [DiveSite] = []
    var siteArrayIterator = 0
    let url: String = "https://raw.githubusercontent.com/mikok42/diverCompanion/master/diverCompanion/diverCompanion/siteData.json"
    let parser = JSONParser.sharedParser
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parser.readFromURL(fromURL: url) { [self] (data) in
            do {
                guard let data = data else { return }
                let tempdiveSites: [DiveSite] = try parser.parse(jsonData: data)
                diveSites = tempdiveSites
                DispatchQueue.main.async {
                    SnapKitLayout()
                }
            } catch {
                print(error)
            }
        }
        //SnapKitLayout()
    }
    
    private func SnapKitLayout() {
        imageSetup()
        descriptionSetup()
        locationSetup()
        titleSetup()
    }
    
    private func imageSetup() {
        siteImage.snp.makeConstraints { (img) in
            img.height.equalTo(298.66)
            img.width.equalTo(UIScreen.main.bounds.width)
            img.centerX.equalTo(view.center)
            img.top.equalTo(view.snp_topMargin)
            self.view.addSubview(siteImage)
        }
        siteImage.image = UIImage(named: diveSites[siteArrayIterator].pictureName)
    }
    private func titleSetup(){
        siteTitle.font = UIFont(name: "Avenir Next Bold", size: 21)
            siteTitle.snp.makeConstraints { (title) in
            title.topMargin.equalTo(310)
            self.view.addSubview(siteTitle)
        }
        siteTitle.text =  diveSites[siteArrayIterator].name
    }
    private func locationSetup() {
        siteLocation.font = UIFont(name: "Avenir Next Ultra Light", size: 17)
        siteLocation.snp.makeConstraints { (loc) in
            loc.topMargin.equalTo(340)
            self.view.addSubview(siteLocation)
        }
        siteLocation.text =  diveSites[siteArrayIterator].location
    }
    
    private func descriptionSetup() {
        siteDescription.font = UIFont(name: "Avenir Next Regular", size: 16)
        siteDescription.textAlignment = NSTextAlignment.natural
        siteDescription.lineBreakMode = NSLineBreakMode.byWordWrapping
        siteDescription.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        siteDescription.snp.makeConstraints { (desc) in
            desc.topMargin.equalTo(370)
            desc.width.equalTo(UIScreen.main.bounds.width - 50)
            self.view.addSubview(siteDescription)
        }
        siteDescription.text =  diveSites[siteArrayIterator].description
    }
}

