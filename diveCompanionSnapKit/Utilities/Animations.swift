//
//  Animations.swift
//  diveCompanionSnapKit
//
//  Created by Mikołaj Linczewski on 24/06/2021.
//

import Foundation
import UIKit

extension UIView {
    public func fadeIn(viewsToAnimate: [UIView], duration: Double = 0.5, _ completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration) {
            viewsToAnimate.forEach { $0.alpha = 1 }
        }
    }
    
    public func fadeOut(viewsToAnimate: [UIView], duration: Double = 0.5, _ completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration) {
            viewsToAnimate.forEach { $0.alpha = 0 }
        }
    }
}
