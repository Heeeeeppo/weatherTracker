//
//  UIStackView+Extensions.swift
//  WeatherTracker
//
//  Created by 方敏起 on 12/15/24.
//

import Foundation
import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { view in
            self.addArrangedSubview(view)
        }
    }
}
