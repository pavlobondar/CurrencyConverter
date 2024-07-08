//
//  UIColor+AppColor.swift
//  CurrencyConverter
//
//  Created by Pavlo on 08.07.2024.
//

import UIKit

extension UIColor {
    enum AppColor: String {
        case shadowColor
    }
    
    static func appColor(_ color: AppColor) -> UIColor {
        return UIColor(named: color.rawValue) ?? .black
    }
}
