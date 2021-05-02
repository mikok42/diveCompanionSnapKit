//
//  TableViewController.swift
//  diveCompanionSnapKit
//
//  Created by Mikołaj Linczewski on 29/04/2021.
//

import Foundation
import UIKit
import SnapKit

class TableViewController: CustomViewController<CountryTableViewContainer> {
    let parser = JSONParser.sharedParser
    let url: String = " "
    var countries: [Country] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.tableDataSource = self
        customView.tableDelegate = self
      
        do {
            guard let localData = try? parser.readLocalFile(forName: "Countries") else { return }
            let tempCountries: [Country]? = try parser.parse(jsonData: localData)
            countries = tempCountries ?? []
            customView.layoutSubviews()
        } catch  {
            print(error)
        }
        countries.forEach() {
            print($0)
        }
        customView.countryTable.register(CountryCell.nib, forCellReuseIdentifier: CountryCell.identifier)
    }
}

extension TableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = customView.countryTable.dequeueReusableCell(withIdentifier: CountryCell.identifier, for: indexPath) as? CountryCell else { return UITableViewCell() }
        cell.configureCell(country: countries[indexPath.row])
        return cell
    }
    
    
}
