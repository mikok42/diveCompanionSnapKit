//
//  ServiceProvider.swift
//  diveCompanionSnapKit
//
//  Created by Mikołaj Linczewski on 11/05/2021.
//

import Foundation

protocol ServiceProviderProtocol {
    var jsonParser: JSONParserProtocol { get }
    var dataFetcher: DataDownloaderProtocol { get set }
    var firebaseService: FirebaseServiceProtocol { get set }
}

class ServiceProvider: ServiceProviderProtocol {
    var jsonParser: JSONParserProtocol
    var dataFetcher: DataDownloaderProtocol
    var firebaseService: FirebaseServiceProtocol
    
    init() {
        self.jsonParser = JSONParser()
        self.dataFetcher = CombineDataService()
        self.firebaseService = FirebaseService()
    }
}
