//
//  CountriesViewController.swift
//  CurrencyConverter
//
//  Created by Pavlo on 06.07.2024.
//

import UIKit

final class CountriesViewController: UIViewController {
    @IBOutlet private weak var searchPanel: SearchPanelView!
    @IBOutlet private weak var tableView: UITableView!
    
    var viewModel: CountriesViewModelInput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupSearchPanel()
        setupTableSeparators()
        registerCells()
        dissmissOnTap()
    }
    
    private func setupViewModel() {
        viewModel?.delegate = self
    }
    
    private func setupSearchPanel() {
        searchPanel.actionHandler = { [weak self] event in
            switch event {
            case .textChanged(let text):
                self?.viewModel?.search(query: text)
            case .search:
                self?.view.endEditing(true)
            }
        }
    }
    
    private func setupTableSeparators() {
        tableView.separatorInset = .init(top: 0.0, left: 20.0, bottom: 0.0, right: 20.0)
    }
    
    private func registerCells() {
        tableView.registerFromNib(CountryTableViewCell.self)
    }
}

// MARK: - CountriesViewModelOutput
extension CountriesViewController: CountriesViewModelOutput {
    func updateTableView() {
        tableView.reloadData()
    }
    
    func dismissViewController() {
        dismiss(animated: true)
    }
}

// MARK: - UITableViewDataSource
extension CountriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.currencies.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = viewModel?.getCellViewModel(indexPath: indexPath)
        let cell = tableView.dequeue(CountryTableViewCell.self, forIndexPath: indexPath)
        cell.viewModel = viewModel
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CountriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.selectCurrency(indexPath: indexPath)
    }
}
