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
        do {
            guard let localData = try? parser.readLocalFile(forName: "Countries") else { return }
            let tempCountries: [Country]? = try parser.parse(jsonData: localData)
            countries = tempCountries ?? []
        } catch  {
            print(error)
        }
        customView.countryTable.delegate = self
        customView.countryTable.dataSource = self
        customView.tableDataSource = self
        customView.tableDelegate = self
        customView.countryTable.register(CountryCell.self, forCellReuseIdentifier: CountryCell.identifier)
    }
}

extension TableViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = customView.countryTable.dequeueReusableCell(withIdentifier: CountryCell.identifier, for: indexPath) as? CountryCell else { return UITableViewCell() }
        cell.configureCell(country: countries[indexPath.row])
        print (":(")
        return cell
    }
    
    
}
