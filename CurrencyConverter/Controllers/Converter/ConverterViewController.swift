//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Pavlo on 06.07.2024.
//

import UIKit

final class ConverterViewController: UIViewController {
    @IBOutlet private weak var converterPanel: ConverterPanelView!
    @IBOutlet private weak var errorStackView: UIStackView!
    @IBOutlet private weak var errorLabel: UILabel!
    
    private let viewModel: ConverterViewModelInput = ConverterViewModel()
    private var convertTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupConverterPanel()
        setupErrorStackView()
        dissmissOnTap()
    }
    
    private func setupViewModel() {
        viewModel.delegate = self
        viewModel.convertCurrency(request: .makeDefault())
    }
    
    private func setupConverterPanel() {
        let model = CurrencyConversionResponse.makeDefault()
        converterPanel.updateView(model: model)
        converterPanel.actionHandler = { [weak self] event in
            switch event {
            case .selectFrom:
                self?.viewModel.updateBaseCurrency()
            case .selectTo:
                self?.viewModel.updateTargetCurrency()
            case .switchCurrencies:
                self?.viewModel.switchCurrencies()
            case .amountChange(let amount):
                self?.convertTimer?.invalidate()
                self?.convertTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
                    self?.viewModel.updateAmount(amount)
                }
            }
        }
    }
    
    private func setupErrorStackView() {
        errorStackView.isLayoutMarginsRelativeArrangement = true
        errorStackView.layoutMargins = .init(top: 6.0, left: 8.0, bottom: 6.0, right: 8.0)
        errorStackView.setCornerRadius(8.0)
    }
}

// MARK: - ConverterViewModelOutput
extension ConverterViewController: ConverterViewModelOutput {
    func showError(error: EndpointError) {
        SVAlertPresenter.shared.showError(error)
    }
    
    func updateView(model: CurrencyConversionResponse) {
        converterPanel.updateView(model: model)
    }
    
    func clearAmounts() {
        converterPanel.clearAmounts()
    }
    
    func showCountriesView(viewModel: CountriesViewModel) {
        let countriesViewController = CountriesViewController.instantiate()
        countriesViewController.viewModel = viewModel
        present(countriesViewController, animated: true)
    }
    
    func updateBaseAmountCardState(isValid: Bool, message: String) {
        errorStackView.isHidden = isValid
        errorLabel.text = message
        if isValid {
            converterPanel.hideError()
        } else {
            converterPanel.showError()
        }
    }
}
