//
//  UIView+Shadow.swift
//  CurrencyConverter
//
//  Created by Pavlo on 06.07.2024.
//

import UIKit

extension UIView {
    func addShadow(color: UIColor = .black, radius: CGFloat, opacity: Float) {
        layer.masksToBounds = false
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowOffset = .zero
        layer.shadowColor = color.cgColor
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    func addBottomShadow(yOffset: CGFloat, opacity: Float) {
        layer.masksToBounds = false
        layer.shadowOpacity = opacity
        layer.shadowRadius = yOffset
        layer.shadowOffset = CGSize(width: 0, height: yOffset)
        layer.shadowColor = UIColor.black.cgColor
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}
