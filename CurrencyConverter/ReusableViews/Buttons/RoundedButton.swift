//
//  RoundedButton.swift
//  CurrencyConverter
//
//  Created by Pavlo on 06.07.2024.
//

import UIKit

final class RoundedButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let radius = frame.height / 2
        setCornerRadius(radius)
    }
}
