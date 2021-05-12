//
//  DataFetcherProtocol.swift
//  diveCompanionSnapKit
//
//  Created by Mikołaj Linczewski on 12/05/2021.
//

import Foundation

protocol DataFetcherProtocol {
    var jsonParser: JSONParserProtocol { get }
    var parsedData: [DiveSite] { get set }
    var viewDelegate: ViewControllerDelegate? { get set }

    func fetchData(url: String)
    func fetchData(fileName: String)
}
