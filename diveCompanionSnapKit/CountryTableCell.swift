//
//  CountryTableCell.swift
//  diveCompanionSnapKit
//
//  Created by Mikołaj Linczewski on 30/04/2021.
//

import Foundation
import UIKit
import SnapKit

class CountryCell: UITableViewCell {
    
    class var identifier: String {
        return String(describing: self)
    }
    
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    private lazy var countryImageView = UIImageView().then {
        $0.contentMode = .scaleToFill
    }
    
    private lazy var countryNameLabel = UILabel().then {
        $0.font = UIFont(name: Constants.fontName, size: 16)
    }
    
    func configureCell(country: Country) {
        countryNameLabel.text = country.name
        countryImageView.image = UIImage(named: country.imageName)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [countryImageView, countryNameLabel].forEach {
            addSubview($0)
        }
        
        countryImageView.snp.makeConstraints {
            $0.leading.equalTo(snp.leading)
            $0.width.equalTo(snp.width).dividedBy(3)
            $0.height.height.equalTo(70)
        }
        countryNameLabel.snp.makeConstraints {
            $0.leading.equalTo(countryImageView.snp.trailing)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

