//
//  TableViewController.swift
//  diveCompanionSnapKit
//
//  Created by Mikołaj Linczewski on 29/04/2021.
//

import Foundation
import UIKit
import SnapKit
import Combine

class TableViewController: CustomViewController<CountryTableViewContainer> {
    private var serviceProvider: ServiceProviderProtocol
    private var countrySubscribers: AnyCancellable?
    
    let url: String = "https://raw.githubusercontent.com/mikok42/diverCompanion/master/diverCompanion/diverCompanion/Countries.json"
    var countries: [Country] = [] {
        didSet { customView.countryTable.reloadData() }
    }
    weak var coordinator: MainCoordinator?
    
    init(serviceProvider: ServiceProviderProtocol) {
        self.serviceProvider = serviceProvider
        super.init()
        fetchCountryData()
        
        customView.countryTable.delegate = self
        customView.countryTable.dataSource = self
        customView.countryTable.registerCellClasses([CountryCell.self])
        customView.tableViewButtonDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func fetchCountryData() {
        countrySubscribers = serviceProvider.dataFetcher.getData(url: url)?
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        print("alles in ordnung")
                    case .failure(let error):
                        self.showAlert(title: "error", message: error.localizedDescription)
                    }
                },
                receiveValue: { countries in
                    self.countries = countries
        })
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
        self.coordinator?.goToSiteView(url: url)
        customView.fadeOut() {
            
        }
    }
}

extension TableViewController: TableViewButtonsDelegate {
    func logOutPressed() {
        coordinator?.goToSignInView()
    }
}
