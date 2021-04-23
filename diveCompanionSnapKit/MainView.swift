//
//  MainView.swift
//  diveCompanionSnapKit
//
//  Created by Mikołaj Linczewski on 22/04/2021.
//

import Foundation
import UIKit



class MainView: UIView {
    lazy private var siteImageView: UIImageView = {
       let imageView = UIImageView()
       imageView.contentMode = .scaleAspectFill
       //subviewsArray.append(imageView)
       return imageView
   }()
   
   lazy private var siteTitleLabel: UILabel = {
       let titleLabel = UILabel()
       titleLabel.font = UIFont(name: "Avenir Next Bold", size: 21)
       //subviewsArray.append(titleLabel)
       return titleLabel
   }()
   
   lazy private var siteLocationLabel: UILabel = {
       let locationLabel = UILabel()
       locationLabel.font = UIFont(name: "Avenir Next Ultra Light", size: 17)
       //subviewsArray.append(locationLabel)
       return locationLabel
   }()
   
   lazy private var siteDescriptionLabel: UILabel = {
       let descriptionLabel = UILabel()
       descriptionLabel.font = UIFont(name: "Avenir Next Regular", size: 16)
       descriptionLabel.numberOfLines = 0
       descriptionLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
       //subviewsArray.append(descriptionLabel)
       return descriptionLabel
   }()

}
