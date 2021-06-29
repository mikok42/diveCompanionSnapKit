//
//  ViewsProtocol.swift
//  diveCompanionSnapKit
//
//  Created by Mikołaj Linczewski on 29/06/2021.
//

import Foundation
import UIKit

public protocol ProperView: UIView {
    func addSubviews()
    func setupSubviews()
}
