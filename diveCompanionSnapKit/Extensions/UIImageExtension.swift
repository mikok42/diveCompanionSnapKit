//
//  UIImageExtension.swift
//  diveCompanionSnapKit
//
//  Created by Mikołaj Linczewski on 26/11/2021.
//

import Foundation
import SnapKit
import UIKit
import Kingfisher

extension UIImageView {
    public func addLogoOverLay(url: URL) {
        let overlay = UIImageView(frame: self.frame)
        self.addSubview(overlay)
        overlay.snp.makeConstraints {
            $0.center.equalTo(self.snp.center)
            $0.width.equalTo(self.snp.width)
            $0.height.equalTo(self.snp.height)
        }
        overlay.kf.setImage(with: url, placeholder: nil, options: nil, completionHandler: nil)
    }
}
