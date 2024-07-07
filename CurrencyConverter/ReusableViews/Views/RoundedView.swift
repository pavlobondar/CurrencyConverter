//
//  RoundedView.swift
//  CurrencyConverter
//
//  Created by Pavlo on 06.07.2024.
//

import UIKit

class RoundedView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        let radius = frame.height / 2
        setCornerRadius(radius)
    }
}
