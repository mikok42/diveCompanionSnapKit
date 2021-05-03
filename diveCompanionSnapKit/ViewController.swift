//
//  ViewController.swift
//  diveCompanionSnapKit
//
//  Created by Mikołaj Linczewski on 22/04/2021.
//

import UIKit
import SnapKit

class ViewController: CustomViewController<MainView> {
    
    var countryIndex: Int? 
    var diveSites: [DiveSite] = []
    var siteArrayIterator = 0
    var url: String = ""
    let parser = JSONParser.sharedParser

    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.buttonDelegate = self
        customView.buttonDataSource = self
        downloadSite(url: url)
        print(url)
    }
    
    
    private func assignElements() {
        let image =  diveSites[siteArrayIterator].pictureName
        let title = diveSites[siteArrayIterator].name
        let location = diveSites[siteArrayIterator].location
        let description = diveSites[siteArrayIterator].description
        
        customView.populate(siteTitle: title, siteDescription: description, siteLocation: location, siteImageName: image)
    }
    
    private func downloadSite(url: String) {
        parser.readFromURL(fromURL: url) { [self] (data) in
            do {
                guard let data = data else { return }
                let tempdiveSites: [DiveSite] = try parser.parse(jsonData: data)
                diveSites = tempdiveSites
                DispatchQueue.main.async {
                    self.assignElements()
                }
            } catch {
                print(error)
            }
        }
    }
}

extension ViewController: ButtonDelegate {
    
    func nextButtonPressed() {
        if siteArrayIterator  < diveSites.count - 1 {
            siteArrayIterator += 1
        } else {
            siteArrayIterator = 0
        }
        assignElements()
    }
    
    func prevButtonPressed() {
        if siteArrayIterator > 0 {
            siteArrayIterator -= 1
        } else {
            siteArrayIterator = diveSites.count - 1
        }
        assignElements()
    }
}

extension ViewController: ButtonDataSource {
    func homeButtonPressed() -> UIColor? {
        let viewController = TempTableViewController()
        present(viewController, animated: true, completion: nil)
        return [#colorLiteral(red: 0.3617562354, green: 0.5512250662, blue: 0.6475913525, alpha: 1), #colorLiteral(red: 0.3617562354, green: 0.5512250662, blue: 0.6475913525, alpha: 1), #colorLiteral(red: 0.3617562354, green: 0.5512250662, blue: 0.6475913525, alpha: 1), #colorLiteral(red: 0.3617562354, green: 0.5512250662, blue: 0.6475913525, alpha: 1), #colorLiteral(red: 0.3617562354, green: 0.5512250662, blue: 0.6475913525, alpha: 1)].randomElement()
    }
}

class CustomViewController<CustomView: UIView>: UIViewController {
    var customView: CustomView {
        return view as! CustomView
    }
    override func loadView() {
        view = CustomView()
    }
}

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

//$0,najpierw setup
//buttony
//cykl życia view controllera
//delegate
