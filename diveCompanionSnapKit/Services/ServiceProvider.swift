//
//  ServiceProvider.swift
//  diveCompanionSnapKit
//
//  Created by Mikołaj Linczewski on 11/05/2021.
//

import Foundation

protocol ServiceProviderProtocol {
    var jsonParser: JSONParserProtocol { get }
    var dataFetcher: DataFetcherProtocol {get set}
}

class ServiceProvider: ServiceProviderProtocol {
    var jsonParser: JSONParserProtocol
    var dataFetcher: DataFetcherProtocol
    
    init() {
        self.jsonParser = JSONParser()
        self.dataFetcher = DataFetcher(jsonParser: jsonParser)
    }
}
