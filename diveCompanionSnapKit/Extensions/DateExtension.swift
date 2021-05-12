//
//  DateExtension.swift
//  diveCompanionSnapKit
//
//  Created by Mikołaj Linczewski on 12/05/2021.
//

import Foundation

extension Date {
    func asISO8601String() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.string(from: self)
      }
}
