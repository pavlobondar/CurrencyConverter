//
//  ShadowView.swift
//  CurrencyConverter
//
//  Created by Pavlo on 08.07.2024.
//

import UIKit

final class ShadowView: UIView {
    var shadowColor: UIColor = .appColor(.shadowColor) {
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
    
    var cornerRadius: CGFloat = 16.0 {
        didSet {
            setupCornerRadius()
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
        setCornerRadius(cornerRadius)
    }
    
    private func applyShadow() {
        guard let shadowLayer = self.layer as? CAGradientLayer else { return }
        shadowLayer.masksToBounds = false
        shadowLayer.shadowOpacity = 0.3
        shadowLayer.shadowRadius = shadowRadius
        shadowLayer.shadowOffset = shadowOffset
        shadowLayer.shadowColor = shadowColor.cgColor
        shadowLayer.shouldRasterize = true
        shadowLayer.rasterizationScale = UIScreen.main.scale
    }
}
