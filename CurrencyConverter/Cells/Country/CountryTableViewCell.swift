//
//  CountryTableViewCell.swift
//  CurrencyConverter
//
//  Created by Pavlo on 06.07.2024.
//

import UIKit

final class CountryTableViewCell: UITableViewCell {
    @IBOutlet private weak var flagImageView: UIImageView!
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    
    var viewModel: CellViewModel? {
        didSet {
            guard let viewModel = viewModel as? CountryCellViewModel else {
                return
            }
            setupCell(viewModel: viewModel)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    private func setupCell(viewModel: CountryCellViewModel) {
        flagImageView.image = .init(named: viewModel.image)
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
    }
}
