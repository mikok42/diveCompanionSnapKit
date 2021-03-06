//
//  Storage.swift
//  Pods
//
//  Created by Mikołaj Linczewski on 29/04/2021.
//

import Foundation

@propertyWrapper
struct PropertyStorage<T> {
    
    private let defaultValue: T
    private let key: StorageKeys
    
    init(key: StorageKeys, defaultValue: T) {
        self.defaultValue = defaultValue
        self.key = key
    }
    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key.rawValue) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key.rawValue)
        }
    }
}

enum StorageKeys: String {
    case signedUp = "signedUp"
    case key = "key"
    case name = "name"
    case username = "username"
    case loggedDives = "loggedDives"
}
