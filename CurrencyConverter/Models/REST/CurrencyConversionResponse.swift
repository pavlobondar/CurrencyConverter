//
//  CurrencyConversionResponse.swift
//  CurrencyConverter
//
//  Created by Pavlo on 06.07.2024.
//

import Foundation

struct CurrencyConversionResponse: Decodable {
    var from: CurrencyType
    var to: CurrencyType
    var fromAmount: Double
    var toAmount: Double
    let rate: Double
    
    var formattedRate: String? {
        return NumberFormatterService.getFormattedAmount(rate)
    }
    
    var exchangeRate: String {
        let rate = formattedRate ?? "\(rate)"
        return "1 \(from.currency) = \(rate) \(to.currency)"
    }
    
    enum CodingKeys: String, CodingKey {
        case from
        case to
        case rate
        case fromAmount
        case toAmount
    }
    
    init(from: CurrencyType,
         to: CurrencyType,
         rate: Double,
         fromAmount: Double,
         toAmount: Double) {
        self.from = from
        self.to = to
        self.rate = rate
        self.fromAmount = fromAmount
        self.toAmount = toAmount
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let from = try container.decode(String.self, forKey: .from).uppercased()
        self.from = .init(rawValue: from.uppercased()) ?? .poland
        
        let to = try container.decode(String.self, forKey: .to).uppercased()
        self.to = .init(rawValue: to.uppercased()) ?? .ukraine
        
        self.rate = try container.decode(Double.self, forKey: .rate)
        self.fromAmount = try container.decode(Double.self, forKey: .fromAmount)
        self.toAmount = try container.decode(Double.self, forKey: .toAmount)
    }
}

extension CurrencyConversionResponse {
    static func makeDefault() -> CurrencyConversionResponse {
        let defaultReguest = CurrencyConversionRequest.makeDefault()
        return .init(from: defaultReguest.from,
                     to: defaultReguest.to,
                     rate: 0.0,
                     fromAmount: defaultReguest.amount,
                     toAmount: 0.0)
    }
}
