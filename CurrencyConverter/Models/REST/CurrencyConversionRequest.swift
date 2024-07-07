//
//  CurrencyConversionRequest.swift
//  CurrencyConverter
//
//  Created by Pavlo on 06.07.2024.
//

import Foundation

struct CurrencyConversionRequest {
    let from: CurrencyType
    let to: CurrencyType
    let amount: Double
    
    init(from: CurrencyType,
         to: CurrencyType,
         amount: Double) {
        self.from = from
        self.to = to
        self.amount = amount
    }
    
    init(response: CurrencyConversionResponse) {
        self.from = response.from
        self.to = response.to
        self.amount = response.fromAmount
    }
}

extension CurrencyConversionRequest {
    static func makeDefault() -> CurrencyConversionRequest {
        return .init(from: .poland,
                     to: .ukraine,
                     amount: 300.0)
    }
}
