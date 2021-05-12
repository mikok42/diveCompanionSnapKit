//
//  JSONParserProtocol.swift
//  diveCompanionSnapKit
//
//  Created by Mikołaj Linczewski on 11/05/2021.
//

import Foundation

protocol JSONParserProtocol {
    func readLocalFile(forName name: String) throws -> Data
    func readFromURL(fromURL: String, completion: @escaping ((Data?) -> Void))
    func parse<T: Codable>(jsonData: Data) throws -> T
}
