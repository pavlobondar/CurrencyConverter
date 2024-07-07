//
//  CountriesViewModel.swift
//  CurrencyConverter
//
//  Created by Pavlo on 07.07.2024.
//

import Foundation

protocol CountriesViewModelInput: ViewModelProtocol {
    var currencies: [CurrencyType] { get }
    var delegate: CountriesViewModelOutput? { get set }
    
    func getCellViewModel(indexPath: IndexPath) -> CellViewModel?
    func search(query: String)
    func selectCurrency(indexPath: IndexPath)
}

protocol CountriesViewModelOutput: ViewModelProtocol {
    func updateTableView()
    func dismissViewController()
}

final class CountriesViewModel: CountriesViewModelInput {
    private var countries: [CurrencyType]
    
    var currencies: [CurrencyType]
    var actionHandler: ((CurrencyType) -> Void)?
    
    weak var delegate: CountriesViewModelOutput?
    
    init() {
        countries = CurrencyType.allCases
        currencies = CurrencyType.allCases
    }
    
    func getCellViewModel(indexPath: IndexPath) -> CellViewModel? {
        guard currencies.indices.contains(indexPath.row) else {
            return nil
        }
        
        let currency = currencies[indexPath.row]
        let viewModel = CountryCellViewModel(currency: currency)
        return viewModel
    }
    
    func search(query: String) {
        if query.isEmpty {
            currencies = countries
        } else {
            currencies = countries.filter {
                let country = $0.country.range(of: query, options: .caseInsensitive)
                let name = $0.name.range(of: query, options: .caseInsensitive)
                return country != nil || name != nil
            }
        }
        delegate?.updateTableView()
    }
    
    func selectCurrency(indexPath: IndexPath) {
        guard currencies.indices.contains(indexPath.row) else { return }
        let currency = currencies[indexPath.row]
        actionHandler?(currency)
        delegate?.dismissViewController()
    }
}
