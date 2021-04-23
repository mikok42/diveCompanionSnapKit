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
    var siteArrayIterator = 0
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
        mainView.buttonDelegate = self
    }
    
    private func assignElements() {
        let image =  diveSites[siteArrayIterator].pictureName
        let title = diveSites[siteArrayIterator].name
        let location = diveSites[siteArrayIterator].location
        let description = diveSites[siteArrayIterator].description
        
        mainView.populate(siteTitle: title, siteDescription: description, siteLocation: location, siteImageName: image)
    }
}

extension ViewController: ButtonDelegate {
    func buttonPressed(_ sender: UIButton) {
        switch sender.currentTitle {
        case "⬅️":
            print("dupa")
            if siteArrayIterator > 0 {
                siteArrayIterator -= 1
            } else {
                siteArrayIterator = diveSites.count - 1
            }
            assignElements()
        case "➡️":
            if siteArrayIterator  < diveSites.count - 1 {
                siteArrayIterator += 1
            } else {
                siteArrayIterator = 0
            }
            assignElements()
        default:
            print("this button doesn't exist")
        }
    }
    
    
}
//$0,najpierw setup
//buttony
//cykl życia view controllera
//delegate
