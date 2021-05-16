//
//  UserSettings.swift
//  diveCompanionSnapKit
//
//  Created by Mikołaj Linczewski on 16/05/2021.
//

import Foundation

struct UserSettings {
    @PropertyStorage(key: .username, defaultValue: "diver")
    var username: String
    
    @PropertyStorage(key: .loggedDives, defaultValue: 0)
    var loggedDives: Int
    
}
