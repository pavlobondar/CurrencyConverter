//
//  SVAlertPresenter.swift
//  CurrencyConverter
//
//  Created by Pavlo on 07.07.2024.
//

import UIKit
import SwiftEntryKit

final class SVAlertPresenter {
    
    static let shared = SVAlertPresenter()
    
    private let toastView: ToastView = ToastView()
    
    private let toastAttributes: EKAttributes = {
        var attributes: EKAttributes = EKAttributes()
        attributes.position = .top
        attributes.scroll = .disabled
        attributes.displayDuration = 2
        attributes.hapticFeedbackType = .success
        attributes.entranceAnimation = .translation
        attributes.exitAnimation = .init(translate: .init(duration: 0.7,
                                                          anchorPosition: .top,
                                                          spring: .init(damping: 1, initialVelocity: 0)))
        attributes.entryInteraction = .dismiss
        attributes.positionConstraints.size = .init(
            width: .offset(value: 10.0),
            height: .constant(value: 90.0)
        )
        return attributes
    }()
    
    private init() {}
    
    func showError(_ error: EndpointError) {
        toastView.update(error: error)
        SwiftEntryKit.display(entry: toastView, using: toastAttributes)
    }
    
    func dismissAllToasts() {
        SwiftEntryKit.dismiss()
    }
}
