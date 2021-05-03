//
//  TableView.swift
//  diveCompanionSnapKit
//
//  Created by Mikołaj Linczewski on 29/04/2021.
//

import Foundation
import UIKit

final class CountryTableViewContainer: UIView {
    var tableDataSource: UITableViewDataSource?
    var tableDelegate: UITableViewDelegate?
    
    var countryTable = UITableView().then {
        $0.backgroundColor = #colorLiteral(red: 0.5125905286, green: 1, blue: 0.9507776416, alpha: 1)
        $0.rowHeight = 70
        
    }
    
    override func layoutSubviews() {
        addSubviews()
        setupSubview()
        print(":)")
    }
    
    private func addSubviews() {
        addSubview(countryTable)
    }
    
    private func setupSubview() {
        countryTable.snp.makeConstraints {
            $0.leading.equalTo(snp.leading)
            $0.trailing.equalTo(snp.trailing)
            $0.height.equalTo(snp.height)
        }
    }
}

