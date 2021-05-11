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
    weak var coordinator: MainCoordinator?
    
    override init() {
        super.init()
        getCountryData()
        customView.countryTable.delegate = self
        customView.countryTable.dataSource = self
        customView.countryTable.registerCellClasses([CountryCell.self])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    fileprivate func getCountryData() {
        do {
            guard let localData = try? parser.readLocalFile(forName: "Countries") else { return }
            let tempCountries: [Country]? = try parser.parse(jsonData: localData)
            countries = tempCountries ?? []
        } catch {
            print(error)
        }
    }
}

extension TableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CountryCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configureCell(country: countries[indexPath.row])
        return cell
    }
    
}

extension TableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let lowerCaseName = countries[safe: indexPath.row]?.name.lowercased() else { return }
        
        let url = "https://raw.githubusercontent.com/mikok42/diverCompanion/master/diverCompanion/diverCompanion/" + lowerCaseName + "SiteData.json"
        
        coordinator?.goToSiteView(url: url)
        print("Mikołaj: \(url)")
    }
}

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

