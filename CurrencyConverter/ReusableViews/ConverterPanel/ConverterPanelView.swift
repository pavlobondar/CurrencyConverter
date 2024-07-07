//
//  ConverterPanelView.swift
//  CurrencyConverter
//
//  Created by Pavlo on 06.07.2024.
//

import UIKit

enum ConverterPanelAction {
    case selectFrom
    case selectTo
    case switchCurrencies
    case amountChange(Double)
}

final class ConverterPanelView: UIView {
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var rateLabel: RoundedLabel!
    
    private var sendingCard = CurrencyCardView(style: .sending)
    private var receiverCard = CurrencyCardView(style: .receiver)
    
    var actionHandler: ((ConverterPanelAction) -> Void)?
    
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
        addShadow(radius: 8.0, opacity: 0.2)
    }
    
    @IBAction private func swapButtonAction(_ sender: RoundedButton) {
        actionHandler?(.switchCurrencies)
    }
    
    private func commonInit() {
        setupCards()
        setCornerRadius(16.0)
    }
    
    private func setupCards() {
        stackView.clear()
        sendingCard.amountHandler = { [weak self] amount in
            self?.actionHandler?(.amountChange(amount))
        }
        sendingCard.countryButtonAction = { [weak self] in
            self?.actionHandler?(.selectFrom)
        }
        receiverCard.countryButtonAction = { [weak self] in
            self?.actionHandler?(.selectTo)
        }
        [sendingCard, receiverCard].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    func showError() {
        sendingCard.updateStyle(.error)
    }
    
    func hideError() {
        sendingCard.updateStyle(.sending)
    }
    
    func updateView(model: CurrencyConversionResponse) {
        rateLabel.text = model.exchangeRate
        sendingCard.updateCard(type: model.from, amount: model.fromAmount)
        receiverCard.updateCard(type: model.to, amount: model.toAmount)
    }
    
    func clearAmounts() {
        [sendingCard, receiverCard].forEach {
            $0.clearAmount()
        }
    }
}
