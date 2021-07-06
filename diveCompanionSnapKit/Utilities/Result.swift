//
//  Result.swift
//  diveCompanionSnapKit
//
//  Created by Mikołaj Linczewski on 06/07/2021.
//

import Foundation

public enum Result<Type> {
    case success(Type)
    case failure(Type)
}
