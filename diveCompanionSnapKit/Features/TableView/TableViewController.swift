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
        } catch {
            print(error)
        }
        customView.countryTable.delegate = self
        customView.countryTable.dataSource = self
        customView.countryTable.registerCellClasses([CountryCell.self])
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
        let viewController = ViewController()
        guard let lowerCaseName = countries[safe: indexPath.row]?.name.lowercased() else { return }
        viewController.url = "https://raw.githubusercontent.com/mikok42/diverCompanion/master/diverCompanion/diverCompanion/" + lowerCaseName + "SiteData.json"
        customView.countryTable.cellForRow(at: indexPath)?.backgroundView?.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        present(viewController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        customView.countryTable.cellForRow(at: indexPath)?.backgroundView?.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        customView.countryTable.cellForRow(at: indexPath)?.backgroundView?.backgroundColor = #colorLiteral(red: 0.5125905286, green: 1, blue: 0.9507776416, alpha: 1)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        customView.countryTable.cellForRow(at: indexPath)?.backgroundView?.backgroundColor = #colorLiteral(red: 0.5125905286, green: 1, blue: 0.9507776416, alpha: 1)
    }
}

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

