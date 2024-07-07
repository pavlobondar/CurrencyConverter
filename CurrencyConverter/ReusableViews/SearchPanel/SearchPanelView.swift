//
//  SearchPanelView.swift
//  CurrencyConverter
//
//  Created by Pavlo on 06.07.2024.
//

import UIKit

enum SearchPanelAction {
    case textChanged(_ text: String)
    case search
}

final class SearchPanelView: UIView {
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var textField: UITextField!
    
    var actionHandler: ((SearchPanelAction) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromNib()
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupFromNib()
        commonInit()
    }
    
    @IBAction private func searchFieldChangeTextAction(_ sender: UITextField) {
        guard let text = sender.text else { return }
        actionHandler?(.textChanged(text))
    }
    
    @IBAction private func searchFieldReturnButtonAction(_ sender: UITextField) {
        actionHandler?(.search)
    }
    
    private func commonInit() {
        containerView.addBorder(.systemGray4, width: 1)
        containerView.setCornerRadius(8.0)
    }
}
