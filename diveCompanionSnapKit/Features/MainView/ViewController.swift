//
//  ViewController.swift
//  diveCompanionSnapKit
//
//  Created by Mikołaj Linczewski on 22/04/2021.
//

import UIKit
import SnapKit
import Combine

final class ViewController: CustomViewController<MainView> {
    
    var countryIndex: Int? 
    private var diveSites: [DiveSite] = [] { didSet { assignElements() } }
    private var siteArrayIterator = 0
    private var serviceProvider: ServiceProviderProtocol
    private var siteSubscribers: AnyCancellable?
    weak var coordinator: MainCoordinator?
    
    var url: String = " "
    
    init(serviceProvider: ServiceProviderProtocol) {
        self.serviceProvider = serviceProvider
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.buttonDelegate = self
        getSites(url: url)
        customView.fadeIn(duration: 0.5)
    }

    private func getSites(url: String) {
        siteSubscribers = serviceProvider.dataFetcher.getData(url: url)?.sink(
            receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("alles in ordnung")
                case .failure(let error):
                    self.showAlert(title: "error", message: error.localizedDescription)
                }
        }, receiveValue: { diveSites in
                self.diveSites = diveSites
        })
    }

}

extension ViewController: ButtonDelegate {
    func userDetailsButtonPressed() {
        coordinator?.goToUserDetailsView()
    }
    
    
    func nextButtonPressed() {
        guard !diveSites.isEmpty else { print("list empty"); return }
        if siteArrayIterator  < diveSites.count - 1  {
            siteArrayIterator++
        } else {
            siteArrayIterator = 0
        }
        assignElements()
        customView.fadeOut(duration: 0.4)
        customView.fadeIn(duration: 0.4)
    }
    
    func prevButtonPressed() {
        guard !diveSites.isEmpty else { print("list empty"); return }
        if siteArrayIterator > 0 {
            siteArrayIterator-- 
        } else {
            siteArrayIterator = diveSites.count - 1
        }
        assignElements()
        customView.fadeOut(duration: 0.4)
        customView.fadeIn(duration: 0.4)
    }
    
    func homeButtonPressed() {
        self.coordinator?.goToMainView()
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
