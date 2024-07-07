//
//  CountryCellViewModel.swift
//  CurrencyConverter
//
//  Created by Pavlo on 06.07.2024.
//

import Foundation

final class CountryCellViewModel: CellViewModel {
    private let currency: CurrencyType
    
    var image: String {
        return currency.imageName
    }
    
    var title: String {
        return currency.country
    }
    
    var subtitle: String {
        return "\(currency.name) • \(currency.currency)"
    }
    
    init(currency: CurrencyType) {
        self.currency = currency
    }
}
