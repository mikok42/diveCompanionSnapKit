//
//  DataFetcher.swift
//  diveCompanionSnapKit
//
//  Created by Mikołaj Linczewski on 12/05/2021.
//

import Foundation

protocol ViewControllerDelegate {
    func assignElements()
    func setDiveSites(diveSites: [DiveSite])
}

class DataFetcher: DataFetcherProtocol {
    var jsonParser: JSONParserProtocol
    var parsedData: [DiveSite] = []
    var viewDelegate: ViewControllerDelegate?
    
    init(jsonParser: JSONParserProtocol) {
        self.jsonParser = jsonParser
    }

    func fetchData(url: String) {
        jsonParser.readFromURL(fromURL: url) { [self] (data) in
            do {
                guard let data = data else { print("no data fetched") ; return }
                let tempdiveSites: [DiveSite] = try jsonParser.parse(jsonData: data)
                self.parsedData = tempdiveSites
                DispatchQueue.main.async {
                    viewDelegate?.setDiveSites(diveSites: self.parsedData)
                    viewDelegate?.assignElements()
                }
            } catch {
                print(error)
            }
        }
    }
        //        let data = fetchedData //else { print("no data fetched 1 ") ; return }
        //        guard let tempDiveSites: [DiveSite] = try jsonParser.parse(jsonData: data) else { print("no data fetched 2 ") ; return }
        //        parsedData = tempDiveSites
        //
        
        
        func fetchData(fileName: String) {
            
        }
    }

