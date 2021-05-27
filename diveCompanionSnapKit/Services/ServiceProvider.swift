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
    var userSettings: UserSettings {get set}
    var firebaseService: FirebaseServiceProtocol { get set }
}

class ServiceProvider: ServiceProviderProtocol {
    var userSettings: UserSettings
    var jsonParser: JSONParserProtocol
    var dataFetcher: DataFetcherProtocol
    var firebaseService: FirebaseServiceProtocol
    
    init() {
        self.jsonParser = JSONParser()
        self.dataFetcher = DataFetcher(jsonParser: jsonParser)
        self.userSettings = UserSettings()
        self.firebaseService = FirebaseService()
    }
}
