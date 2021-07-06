//
//  CombineDataFetcher.swift
//  diveCompanionSnapKit
//
//  Created by Mikołaj Linczewski on 06/07/2021.
//

import Foundation
import Combine

class CombineDataService {
    public static func getData<T: Decodable>(url: String) -> AnyPublisher<[T], Error>? {
        guard let url = URL(string: url) else { return nil}
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [T].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
