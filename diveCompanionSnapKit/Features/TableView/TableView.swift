//
//  TableView.swift
//  diveCompanionSnapKit
//
//  Created by Mikołaj Linczewski on 29/04/2021.
//

import Foundation
import UIKit
import SnapKit

protocol TableViewButtonsDelegate {
    func logOutPressed()
}

final class CountryTableViewContainer: UIView {
    var tableDataSource: UITableViewDataSource?
    var tableDelegate: UITableViewDelegate?
    var tableViewButtonDelegate: TableViewButtonsDelegate?
    
    var countryTable = UITableView().then {
        $0.alpha = 0
        $0.backgroundColor = Constants.backgroundColour
        $0.rowHeight = 70
    }
    
    private lazy var logOutButton = UIButton().then {
        $0.alpha = 0
        $0.backgroundColor = .blue
        $0.setTitle("Sign out", for: .normal)
        $0.titleLabel?.font = UIFont(name: Constants.fontName, size: 20)
        
        $0.addTarget(self, action: #selector(buttonLetGoInside(_:)), for: .touchUpInside)
        $0.addTarget(self, action: #selector(buttonLetGoOutside(_:)), for: .touchUpOutside)
        $0.addTarget(self, action: #selector(buttonTouched), for: .touchDown)
    }
    
    override func layoutSubviews() {
        self.backgroundColor = Constants.backgroundColour
        addSubviews()
        setupSubview()
        fadeIn(viewsToAnimate: [countryTable, logOutButton])
    }
    
    private func addSubviews() {
        addSubview(countryTable)
        addSubview(logOutButton)
    }
    
    private func redoConstraint() {
        logOutButton.snp.remakeConstraints {
            $0.top.equalTo(snp.bottom)
        }
        
        countryTable.snp.remakeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(38)
        }
        self.layoutIfNeeded()
    }
    
    public func fadeIn(_ completion: (() -> Void)? = nil) {
        super.fadeIn(viewsToAnimate: [countryTable, logOutButton])
    }

    public func fadeOut(_ completion: (() -> Void)? = nil) {
        super.fadeIn(viewsToAnimate: [countryTable, logOutButton])
    }
    
    private func setupSubview() {
        countryTable.snp.makeConstraints {
            $0.leading.equalTo(snp.leading)
            $0.trailing.equalTo(snp.trailing)
            $0.top.equalTo(snp.top)
            $0.bottom.equalTo(logOutButton.snp.top)
        }
        
        logOutButton.snp.makeConstraints {
            $0.leading.equalTo(snp.leading)
            $0.trailing.equalTo(snp.trailing)
            $0.bottom.equalTo(snp.bottom).inset(20)
            $0.height.equalTo(38)
        }
    }
    
    @objc private func buttonLetGoOutside(_ sender: UIButton) {
        sender.alpha = 1
    }
    
    @objc private func buttonTouched(_ sender: UIButton) {
        sender.alpha = 0.5
    }
    
    @objc private func buttonLetGoInside(_ sender: UIButton) {
        sender.alpha = 1
        fadeOut(viewsToAnimate: [countryTable, logOutButton])
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.tableViewButtonDelegate?.logOutPressed()
        }
    }
}
//do osobnego plliku
extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: Identifiable {
        guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else { fatalError("Couldn't dequeue cell with id:  \(T.identifier)") }
        return cell
    }
 
    func registerCellClasses(_ cellClasses: [Identifiable.Type]) {
        cellClasses.forEach { register($0, forCellReuseIdentifier: $0.identifier)}
    }
}
