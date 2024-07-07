//
//  Currency.swift
//  CurrencyConverter
//
//  Created by Pavlo on 06.07.2024.
//

import Foundation

enum CurrencyType: String, CaseIterable {
    case poland = "PLN"
    case germany = "EUR"
    case greatBritan = "GBP"
    case ukraine = "UAH"
    
    var maxAmountMessage: String {
        let sendingLimit = Int(sendingLimit)
        return "Maximum sending amount: \(sendingLimit) \(currency)"
    }
    
    var imageName: String {
        switch self {
        case .poland:
            return "poland"
        case .germany:
            return "germany"
        case .greatBritan:
            return "greatBritan"
        case .ukraine:
            return "ukraine"
        }
    }
    
    var name: String {
        switch self {
        case .poland:
            return "Polish zloty"
        case .germany:
            return "Euro"
        case .greatBritan:
            return "British Pound"
        case .ukraine:
            return "Hrivna"
        }
    }
    
    var country: String {
        switch self {
        case .poland:
            return "Poland"
        case .germany:
            return "Germany"
        case .greatBritan:
            return "Great Britan"
        case .ukraine:
            return "Ukraine"
        }
    }
    
    var currency: String {
        return rawValue
    }
    
    var sendingLimit: Double {
        switch self {
        case .poland:
            return 20000.0
        case .germany:
            return 5000.0
        case .greatBritan:
            return 1000.0
        case .ukraine:
            return 50000.0
        }
    }
}
