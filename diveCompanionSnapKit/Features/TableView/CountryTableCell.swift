//
//  CountryTableCell.swift
//  diveCompanionSnapKit
//
//  Created by Mikołaj Linczewski on 30/04/2021.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

class CountryCell: UITableViewCell, Identifiable {
    
    private lazy var countryImageView = UIImageView().then {
        $0.contentMode = .scaleToFill
    }
    
    private lazy var countryNameLabel = UILabel().then {
        $0.font = UIFont(name: Constants.fontName, size: 20)
    }
    
    private lazy var selectionColour = UIView().then {
        $0.backgroundColor = #colorLiteral(red: 0.4071500789, green: 0.7962964484, blue: 0.7670197448, alpha: 1)
    }
    
    func configureCell(country: Country) {
        let fullURL = Constants.imageRepo  + country.imageName + ".jpg?raw=true"
        print("Mikołaj: \(fullURL)")
        countryImageView.kf.setImage(
            with: URL(string: fullURL),
            placeholder: UIImage(named: "salemWreck"),
            options: [.transition(.flipFromLeft(1))]
        )
        
        countryNameLabel.text = country.name
        backgroundColor = Constants.backgroundColour
        selectedBackgroundView = selectionColour
        
        guard let logoURL: URL = URL(string: Constants.imageRepo + "doge.png?raw=true") else { return }
        countryImageView.addLogoOverLay(url: logoURL)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [countryImageView, countryNameLabel].forEach {
            addSubview($0)
        }
        
        countryImageView.snp.makeConstraints {
            $0.leading.equalTo(snp.leading)
            $0.width.equalTo(snp.width).dividedBy(3)
            $0.height.equalTo(snp.height)
        }
        countryNameLabel.snp.makeConstraints {
            $0.leading.equalTo(countryImageView.snp.trailing).offset(10)
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol Identifiable: AnyObject {
    static var identifier: String { get }
}

extension Identifiable {
    static var identifier: String {
        return String(describing: self)
    }
}
