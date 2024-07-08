//
//  CurrencyCardView.swift
//  CurrencyConverter
//
//  Created by Pavlo on 06.07.2024.
//

import UIKit

final class CurrencyCardView: UIView {
    
    enum CurrencyCardStyle: String {
        case sending
        case receiver
        case error
        
        var title: String? {
            switch self {
            case .sending:
                return "Sending from"
            case .receiver:
                return "Receiver gets"
            case .error:
                return nil
            }
        }
        
        var backgroundColor: UIColor {
            switch self {
            case .sending, .error:
                return .systemBackground
            case .receiver:
                return .clear
            }
        }
        
        var amountColor: UIColor {
            switch self {
            case .sending:
                return .systemBlue
            case .receiver:
                return .label
            case .error:
                return .systemPink
            }
        }
        
        var isInputAvailable: Bool {
            switch self {
            case .sending, .error:
                return true
            case .receiver:
                return false
            }
        }
    }
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var amountTextField: CurrencyTextField!
    
    @IBOutlet private weak var countryImageView: UIImageView!
    @IBOutlet private weak var countryButton: UIButton!
    
    private var style: CurrencyCardStyle = .receiver
    
    var countryButtonAction: (() -> Void)?
    var amountHandler: ((Double) -> Void)? {
        didSet {
            guard amountHandler != nil else { return }
            amountTextField.amountHandler = amountHandler
        }
    }
    
    init(style: CurrencyCardStyle) {
        self.style = style
        super.init(frame: .zero)
        setupFromNib()
        commonInit()
    }
    
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
        switch style {
        case .sending:
            addBottomShadow(yOffset: 7.0, opacity: 0.1)
        case .receiver, .error:
            break
        }
    }
    
    @IBAction private func contryButtonAction(_ sender: UIButton) {
        countryButtonAction?()
    }
    
    private func commonInit() {
        setCornerRadius(16.0)
        setStyle()
    }
    
    private func setStyle() {
        backgroundColor = style.backgroundColor
        amountTextField.textColor = style.amountColor
        amountTextField.isUserInteractionEnabled = style.isInputAvailable
        switch style {
        case .sending:
            titleLabel.text = style.title
            addBorder(.clear, width: 0.0)
        case .receiver:
            titleLabel.text = style.title
        case .error:
            addBorder(.systemPink, width: 2.0)
        }
    }
    
    func updateCard(type: CurrencyType, amount: Double) {
        countryImageView.image = .init(named: type.imageName)
        countryButton.setTitle(type.currency, for: .normal)
        amountTextField.startingValue = amount
    }
    
    func updateStyle(_ style: CurrencyCardStyle) {
        self.style = style
        setStyle()
    }
    
    func clearAmount() {
        amountTextField.startingValue = 0.0
    }
}
