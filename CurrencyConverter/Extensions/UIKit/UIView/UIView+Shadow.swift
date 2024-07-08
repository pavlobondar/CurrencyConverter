//
//  UIView+Shadow.swift
//  CurrencyConverter
//
//  Created by Pavlo on 06.07.2024.
//

import UIKit

extension UIView {
    func addBottomShadow(yOffset: CGFloat, opacity: Float) {
        layer.masksToBounds = false
        layer.shadowOpacity = opacity
        layer.shadowRadius = yOffset
        layer.shadowOffset = CGSize(width: 0, height: yOffset)
        layer.shadowColor = UIColor.appColor(.shadowColor).cgColor
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}
