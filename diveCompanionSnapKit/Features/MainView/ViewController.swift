//
//  ViewController.swift
//  diveCompanionSnapKit
//
//  Created by Mikołaj Linczewski on 22/04/2021.
//

import UIKit
import SnapKit

final class ViewController: CustomViewController<MainView> {
    
    var countryIndex: Int? 
    private var diveSites: [DiveSite] = []
    private var siteArrayIterator = 0
    private var serviceProvider: ServiceProviderProtocol
    private let parser: JSONParserProtocol
    weak var coordinator: MainCoordinator?
    
    var url: String = " "
    
    init(serviceProvider: ServiceProviderProtocol) {
        self.parser = serviceProvider.jsonParser
        self.serviceProvider = serviceProvider
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.buttonDelegate = self
        serviceProvider.dataFetcher.viewDelegate = self
        downloadSite(url: url)
    }
    
    private func downloadSite(url: String) {
        serviceProvider.dataFetcher.fetchData(url: url)
    }

}

extension ViewController: ButtonDelegate {
    
    func nextButtonPressed() {
        guard !diveSites.isEmpty else { print("list empty"); return }
        if siteArrayIterator  < diveSites.count - 1 {
            siteArrayIterator++
        } else {
            siteArrayIterator = 0
        }
        assignElements()
    }
    func prevButtonPressed() {
        guard !diveSites.isEmpty else { print("list empty"); return }
        if siteArrayIterator > 0 {
            siteArrayIterator-- 
        } else {
            siteArrayIterator = diveSites.count - 1
        }
        assignElements()
    }
    
    func homeButtonPressed() {
        coordinator?.navigationController.popViewController(animated: false)
    }
}

extension ViewController: ViewControllerDelegate{
    func assignElements() {
        let image =  diveSites[siteArrayIterator].pictureName
        let title = diveSites[siteArrayIterator].name
        let location = diveSites[siteArrayIterator].location
        let description = diveSites[siteArrayIterator].description
        
        customView.populate(siteTitle: title, siteDescription: description, siteLocation: location, siteImageName: image)
    }
    
    func setDiveSites(diveSites: [DiveSite]) {
        self.diveSites = diveSites
    }
}
//extension ViewController: ButtonDataSource {
//    func homeButtonPressed() -> UIColor? {
//        return [#colorLiteral(red: 0.3617562354, green: 0.5512250662, blue: 0.6475913525, alpha: 1), #colorLiteral(red: 0.3617562354, green: 0.5512250662, blue: 0.6475913525, alpha: 1), #colorLiteral(red: 0.3617562354, green: 0.5512250662, blue: 0.6475913525, alpha: 1), #colorLiteral(red: 0.3617562354, green: 0.5512250662, blue: 0.6475913525, alpha: 1), #colorLiteral(red: 0.3617562354, green: 0.5512250662, blue: 0.6475913525, alpha: 1)].randomElement()
//    }
//}


//
//protocol HasCustomView {
//    associatedtype CustomView: UIView
//}
//
//extension HasCustomView where Self: UIViewController {
//    var myView: CustomView {
//        guard let myView = view as? CustomView else {
//            fatalError("view should be \(String(describing: view.self)) but is \(type(of: view))")
//        }
//        return myView
//    }
//}

//cykl życia view controllera
