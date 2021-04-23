//
//  ViewController.swift
//  diveCompanionSnapKit
//
//  Created by Mikołaj Linczewski on 22/04/2021.
//

import UIKit
import SnapKit
import SwiftUI

class ViewController: UIViewController {
    
    @IBOutlet var mainView: MainView!
    
    var diveSites: [DiveSite] = []
    static var siteArrayIterator = 0
    let url: String = "https://raw.githubusercontent.com/mikok42/diverCompanion/master/diverCompanion/diverCompanion/siteData.json"
    let parser = JSONParser.sharedParser
    
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
        let image =  diveSites[ViewController.siteArrayIterator].pictureName
        let title = diveSites[ViewController.siteArrayIterator].name
        let location = diveSites[ViewController.siteArrayIterator].location
        let description = diveSites[ViewController.siteArrayIterator].description
        
        mainView.populate(siteTitle: title, siteDescription: description, siteLocation: location, siteImageName: image)
    }
}
//$0,najpierw setup
//buttony
//cykl życia view controllera
//delegate
