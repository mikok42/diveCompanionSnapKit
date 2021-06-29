//
//  IntExtension.swift
//  diveCompanionSnapKit
//
//  Created by Mikołaj Linczewski on 29/06/2021.
//

import Foundation

extension Int {
    func Bool() -> Bool? {
        if (0...1).contains(self) {
            return self == 1 ? true : false
        } else {
            return nil
        }
        
    }
}
