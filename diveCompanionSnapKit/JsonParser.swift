//
//  JsonParser.swift
//  diverCompanion
//
//  Created by Mikołaj Linczewski on 13/04/2021.
//

import Foundation

class JSONParser {
    static let sharedParser = JSONParser()
    private init(){}
    
    func readLocalFile(forName name: String) throws -> Data {
        guard let bundlePath = Bundle.main.path(forResource: name, ofType: "json") else { throw DataParserError.fileDoesNotExist }
        guard let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) else { throw DataParserError.unableToDecode }
        return jsonData
    }
    
    func readFromURL(fromURL: String, completion: @escaping ((Data?) -> Void)) {
        guard let url = URL(string: fromURL) else { completion(nil); return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let jsonData = data else { return }
            completion(jsonData)
        }.resume()
    }
    
    func parse<T: Codable>(jsonData: Data) throws -> T {
        let decodedData = try JSONDecoder().decode(T.self, from: jsonData)
        return decodedData
    }
}
