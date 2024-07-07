//
//  ConverterViewModel.swift
//  CurrencyConverter
//
//  Created by Pavlo on 07.07.2024.
//

import Foundation

protocol ConverterViewModelInput: ViewModelProtocol {
    var delegate: ConverterViewModelOutput? { get set }
    
    init(networkService: NetworkServiceProtocol)
    
    func convertCurrency(request: CurrencyConversionRequest)
    func updateBaseCurrency()
    func updateTargetCurrency()
    func switchCurrencies()
    func updateAmount(_ amount: Double)
}

protocol ConverterViewModelOutput: ViewModelProtocol {
    func showError(error: EndpointError)
    func updateView(model: CurrencyConversionResponse)
    func updateTarget(model: CurrencyConversionResponse)
    func clearAmounts()
    func showCountriesView(viewModel: CountriesViewModel)
    func updateBaseAmountCardState(isValid: Bool, message: String)
}

final class ConverterViewModel: ConverterViewModelInput {
    enum ConverterAction {
        case initial
        case updateCurrency
        case switchCurrency
        case updateAmount
    }
    
    private let networkService: NetworkServiceProtocol
    
    private var convertCurrencyResponse: CurrencyConversionResponse
    private var converterAction: ConverterAction
    
    weak var delegate: ConverterViewModelOutput?
    
    init(networkService: NetworkServiceProtocol = NetworkService.makeDefault()) {
        self.networkService = networkService
        self.convertCurrencyResponse = .makeDefault()
        self.converterAction = .initial
    }
    
    private func validateAndProcessConversion(action: ConverterAction) {
        let amount = convertCurrencyResponse.fromAmount
        let baseCurrency = convertCurrencyResponse.from
        let message = baseCurrency.maxAmountMessage
        converterAction = action
        do {
            let _ = try TargetCurrencyValidator.shared.validate(amount: amount, for: baseCurrency)
            let request = CurrencyConversionRequest(response: convertCurrencyResponse)
            delegate?.updateBaseAmountCardState(isValid: true, message: message)
            convertCurrency(request: request)
        } catch CurrencyValidationResult.zeroAmount {
            convertCurrencyResponse.fromAmount = 0.0
            convertCurrencyResponse.toAmount = 0.0
            delegate?.clearAmounts()
            updateConverter()
        } catch CurrencyValidationResult.exceedsMax {
            delegate?.updateBaseAmountCardState(isValid: false, message: message)
            updateConverter()
        } catch {
            delegate?.showError(error: .invalidData)
            updateConverter()
        }
    }
        
    private func updateConverter() {
        let response = convertCurrencyResponse
        switch converterAction {
        case .initial, .updateCurrency, .switchCurrency:
            delegate?.updateView(model: response)
        case .updateAmount:
            delegate?.updateTarget(model: response)
        }
    }
    
    func convertCurrency(request: CurrencyConversionRequest) {
        networkService.convert(request: request) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.convertCurrencyResponse = response
                    self?.updateConverter()
                case .failure(let error):
                    self?.delegate?.showError(error: error)
                }
            }
        }
    }
    
    func updateBaseCurrency() {
        let viewModel = CountriesViewModel()
        viewModel.actionHandler = { [weak self] currency in
            self?.convertCurrencyResponse.from = currency
            self?.validateAndProcessConversion(action: .updateCurrency)
        }
        delegate?.showCountriesView(viewModel: viewModel)
    }
    
    func updateTargetCurrency() {
        let viewModel = CountriesViewModel()
        viewModel.actionHandler = { [weak self] currency in
            self?.convertCurrencyResponse.to = currency
            self?.validateAndProcessConversion(action: .updateCurrency)
        }
        delegate?.showCountriesView(viewModel: viewModel)
    }
    
    func switchCurrencies() {
        let baseCurrency = convertCurrencyResponse.from
        let targetCurrency = convertCurrencyResponse.to
        convertCurrencyResponse.from = targetCurrency
        convertCurrencyResponse.to = baseCurrency
        validateAndProcessConversion(action: .switchCurrency)
    }
    
    func updateAmount(_ amount: Double) {
        convertCurrencyResponse.fromAmount = amount
        validateAndProcessConversion(action: .updateAmount)
    }
}
