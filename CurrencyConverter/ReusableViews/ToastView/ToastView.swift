//
//  ToastView.swift
//  CurrencyConverter
//
//  Created by Pavlo on 07.07.2024.
//

import UIKit

final class ToastView: UIView {
    @IBOutlet private weak var containerView: ShadowView!
    
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
    
    private func commonInit() {
        containerView.cornerRadius = 10
        containerView.shadowRadius = 5
    }
    
    func update(error: EndpointError) {
        titleLabel.text = error.title
        subtitleLabel.text = error.description
    }
}
