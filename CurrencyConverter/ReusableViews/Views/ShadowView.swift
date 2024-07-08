//
//  ShadowView.swift
//  CurrencyConverter
//
//  Created by Pavlo on 08.07.2024.
//

import UIKit

final class ShadowView: UIView {
    var shadowColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2039528146) {
        didSet {
            applyShadow()
        }
    }
    
    var shadowOffset: CGSize = .init(width: 0.0, height: 0.0) {
        didSet {
            applyShadow()
        }
    }
    
    var shadowRadius: CGFloat = 8.0 {
        didSet {
            applyShadow()
        }
    }
    
    override class var layerClass: Swift.AnyClass {
        return CAGradientLayer.self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupCornerRadius()
        applyShadow()
    }
    
    private func setupCornerRadius() {
        layer.cornerRadius = 16
        layer.masksToBounds = true
    }
    
    private func applyShadow() {
        guard let gradientLayer = self.layer as? CAGradientLayer else { return }
        gradientLayer.masksToBounds = false
        gradientLayer.shadowOpacity = 1.0
        gradientLayer.shadowRadius = shadowRadius
        gradientLayer.shadowOffset = shadowOffset
        gradientLayer.shadowColor = shadowColor.cgColor
        gradientLayer.shouldRasterize = true
        gradientLayer.rasterizationScale = UIScreen.main.scale
    }
}
