//
//  ToastView.swift
//  CurrencyConverter
//
//  Created by Pavlo on 07.07.2024.
//

import UIKit

final class ToastView: UIView {
    @IBOutlet private weak var containerView: UIView!
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromNib()
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupFromNib()
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.addShadow(radius: 5.0, opacity: 0.2)
    }
    
    private func commonInit() {
        containerView.setCornerRadius(10.0)
    }
    
    func update(error: EndpointError) {
        titleLabel.text = error.title
        subtitleLabel.text = error.description
    }
}
