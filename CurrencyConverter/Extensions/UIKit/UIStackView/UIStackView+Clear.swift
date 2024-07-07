//
//  UIStackView+Clear.swift
//  CurrencyConverter
//
//  Created by Pavlo on 06.07.2024.
//

import UIKit

extension UIStackView {
    func clear() {
        arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
    }
}
