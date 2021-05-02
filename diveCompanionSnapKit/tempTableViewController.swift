//
//  tempTableViewController.swift
//  diveCompanionSnapKit
//
//  Created by Mikołaj Linczewski on 02/05/2021.
//

import Foundation
import UIKit
import SnapKit

class TempTableViewController: UIViewController {
    var countries: [Country] = []
    let parser = JSONParser.sharedParser

    
    private var tempTableView = UITableView().then {
        $0.backgroundColor = #colorLiteral(red: 0.5125905286, green: 1, blue: 0.9507776416, alpha: 1)
        $0.rowHeight = 70
        $0.frame = CGRect(x: 0, y: 0, width: 400, height: 800)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            guard let localData = try? parser.readLocalFile(forName: "Countries") else { return }
            let tempCountries: [Country]? = try parser.parse(jsonData: localData)
            countries = tempCountries ?? []
        } catch  {
            print(error)
        }
        tempTableView.register(CountryCell.self, forCellReuseIdentifier: CountryCell.identifier)
        tempTableView.delegate = self
        tempTableView.dataSource = self
        self.view.addSubview(tempTableView)
    }
}


extension TempTableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryCell.identifier, for: indexPath) as? CountryCell else { return UITableViewCell() }
        cell.configureCell(country: countries[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(countries[indexPath.row])
    }
}
