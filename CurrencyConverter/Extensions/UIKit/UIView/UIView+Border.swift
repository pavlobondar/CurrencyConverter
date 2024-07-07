//
//  UIView+Border.swift
//  CurrencyConverter
//
//  Created by Pavlo on 06.07.2024.
//

import UIKit

extension UIView {
    func addBorder(_ color: UIColor, width: CGFloat) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }
}
