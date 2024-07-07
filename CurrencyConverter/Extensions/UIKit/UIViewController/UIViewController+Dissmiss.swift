//
//  UIViewController+Dissmiss.swift
//  CurrencyConverter
//
//  Created by Pavlo on 07.07.2024.
//

import UIKit

extension UIViewController {
    func dissmissOnTap() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}
