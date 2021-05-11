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
    private let parser = JSONParser.sharedParser
    var url: String = " "

    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.buttonDelegate = self
        //customView.buttonDataSource = self
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
        self.navigationController?.popViewController(animated: true)
    }
}

//extension ViewController: ButtonDataSource {
//    func homeButtonPressed() -> UIColor? {
//        return [#colorLiteral(red: 0.3617562354, green: 0.5512250662, blue: 0.6475913525, alpha: 1), #colorLiteral(red: 0.3617562354, green: 0.5512250662, blue: 0.6475913525, alpha: 1), #colorLiteral(red: 0.3617562354, green: 0.5512250662, blue: 0.6475913525, alpha: 1), #colorLiteral(red: 0.3617562354, green: 0.5512250662, blue: 0.6475913525, alpha: 1), #colorLiteral(red: 0.3617562354, green: 0.5512250662, blue: 0.6475913525, alpha: 1)].randomElement()
//    }
//}

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

//cykl życia view controllera
