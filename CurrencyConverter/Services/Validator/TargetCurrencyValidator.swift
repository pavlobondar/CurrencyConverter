//
//  TargetCurrencyValidator.swift
//  CurrencyConverter
//
//  Created by Pavlo on 07.07.2024.
//

import Foundation

enum CurrencyValidationResult: Error {
    case zeroAmount
    case exceedsMax
}

final class TargetCurrencyValidator {
    
    static let shared = TargetCurrencyValidator()
    
    private init() {}
    
    func validate(amount: Double, for currency: CurrencyType) throws -> Double {
        guard amount > 0.0 else {
            throw CurrencyValidationResult.zeroAmount
        }
        
        guard amount <= currency.sendingLimit else {
            throw CurrencyValidationResult.exceedsMax
        }
        
        return amount
    }
}
