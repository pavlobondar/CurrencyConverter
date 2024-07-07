//
//  UIView+CornerRadius.swift
//  CurrencyConverter
//
//  Created by Pavlo on 06.07.2024.
//

import UIKit

extension UIView {
    func setCornerRadius(_ radius: CGFloat, masksToBounds: Bool = true) {
        layer.cornerRadius = radius
        layer.masksToBounds = masksToBounds
    }
}
