//
//  ViewController.swift
//  diveCompanionSnapKit
//
//  Created by Mikołaj Linczewski on 22/04/2021.
//

import UIKit
import SnapKit
import SwiftUI

class ViewController: UIViewController, HasCustomView {
    typealias CustomView = MainView
    
    
   // @IBOutlet var mainView: MainView!

    var diveSites: [DiveSite] = []
    var siteArrayIterator = 0
    let url: String = "https://raw.githubusercontent.com/mikok42/diverCompanion/master/diverCompanion/diverCompanion/siteData.json"
    let parser = JSONParser.sharedParser
    
    override func loadView() {
        super.loadView()
        let mainView = CustomView()
        view = CustomView()
        mainView.buttonDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
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
    
    private func assignElements() {
        let image =  diveSites[siteArrayIterator].pictureName
        let title = diveSites[siteArrayIterator].name
        let location = diveSites[siteArrayIterator].location
        let description = diveSites[siteArrayIterator].description
        
        view.populate(siteTitle: title, siteDescription: description, siteLocation: location, siteImageName: image)
    }
}

extension ViewController: ButtonDelegate {
    func homeButtonPressed(_ sender: UIButton) {
        print("home")
    }
    
    func nextButtonPressed(_ sender: UIButton) {
            if siteArrayIterator  < diveSites.count - 1 {
                siteArrayIterator += 1
            } else {
                siteArrayIterator = 0
            }
        assignElements()
    }
    
    func prevButtonPressed(_ sender: UIButton) {
            if siteArrayIterator > 0 {
                siteArrayIterator -= 1
            } else {
                siteArrayIterator = diveSites.count - 1
            }
        assignElements()
        }
    }
    
public protocol HasCustomView {
    associatedtype CustomView: UIView
}

extension HasCustomView where Self: UIViewController {
    public var myView: MainView {
        guard let myView = view as? MainView else {
            fatalError("view should be \(String(describing: view.self)) but is \(type(of: view))")
            
        }
        return myView
    }
}

//$0,najpierw setup
//buttony
//cykl życia view controllera
//delegate
