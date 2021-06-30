//
//  IndexExtensions.swift
//  diveCompanionSnapKit
//
//  Created by Mikołaj Linczewski on 29/06/2021.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
    
