//
//  CurrencyTextField.swift
//  CurrencyConverter
//
//  Created by Pavlo on 07.07.2024.
//

import UIKit

class CurrencyTextField: UITextField {
    private var numberFormatter: NumberFormatter = {
        return NumberFormatterService.amountFormatter
    }()
    
    private var roundingPlaces: Int {
        return numberFormatter.maximumFractionDigits
    }
    
    private var amountAsDouble: Double?
    
    var amountHandler: ((Double) -> Void)?
    
    var startingValue: Double? {
        didSet {
            let nsNumber = NSNumber(value: startingValue ?? 0.0)
            self.text = numberFormatter.string(from: nsNumber)
        }
    }
    
    var maxLength: Int = 11
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        self.textAlignment = .right
        self.keyboardType = .numberPad
        self.contentScaleFactor = 0.5
        delegate = self
        self.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc private func textFieldDidChange() {
        updateTextField()
    }

    private func updateTextField() {
        let text = self.text ?? ""
        let cleanedAmount = text.filter({ $0.isNumber })
        
        if self.roundingPlaces > 0 {
            let amount = Double(cleanedAmount) ?? 0.0
            amountAsDouble = (amount / 100.0)
            let amountAsString = numberFormatter.string(from: NSNumber(value: amountAsDouble ?? 0.0)) ?? ""
            self.text = amountAsString
        } else {
            let amountAsNumber = Double(cleanedAmount) ?? 0.0
            amountAsDouble = amountAsNumber
            self.text = numberFormatter.string(from: NSNumber(value: amountAsNumber)) ?? ""
        }
        
        guard let amount = amountAsDouble else { return }
        amountHandler?(amount)
    }
    
    override func closestPosition(to point: CGPoint) -> UITextPosition? {
        let beginning = self.beginningOfDocument
        let end = self.position(from: beginning, offset: self.text?.count ?? 0)
        return end
    }
}

// MARK: - UITextFieldDelegate
extension CurrencyTextField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = (textField.text ?? "") as NSString
        let text = currentText.replacingCharacters(in: range, with: string)
        return text.count <= maxLength
    }
}
