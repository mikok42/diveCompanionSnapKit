//
//  PlusPlus.swift
//  diveCompanionSnapKit
//
//  Created by Mikołaj Linczewski on 04/05/2021.
//

import Foundation

public postfix func ++<T: Numeric>(value: inout T) {
    value += 1
}

public postfix func --<T: Numeric>(value: inout T) {
    value -= 1
}
