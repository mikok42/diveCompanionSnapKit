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
    
    func configureCell(country: Country) {
        countryNameLabel.text = country.name
        countryImageView.image = UIImage(named: country.imageName)
        backgroundColor = #colorLiteral(red: 0.5125905286, green: 1, blue: 0.9507776416, alpha: 1)
        selectionStyle = .gray
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
