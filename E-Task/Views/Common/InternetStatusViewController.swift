//
//  InternetStatusViewController.swift
//  E-Task
//
//  Created by XECE on 13.07.2025.
//

import UIKit

final class InternetStatusViewController: UIViewController {
    
    private let statusLabelView = StatusLabelView()
    private let retryButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
        layout()
    }
    
    private func setup() {
        statusLabelView.text = "No Internet Connection"
        
        retryButton.setTitle("Retry", for: .normal)
        retryButton.titleLabel?.font = Constants.Fonts.medium(size: 16)
        retryButton.tintColor = .systemBlue
        retryButton.addTarget(self, action: #selector(retryTapped), for: .touchUpInside)
        
        [statusLabelView, retryButton].forEach {
            view.addSubview($0)
        }
    }
    
    private func layout() {
        statusLabelView.pinTop(to: view.safeAreaLayoutGuide.topAnchor, constant: Constants.Metrics.verticalPadding)
        statusLabelView.pinLeading(to: view.leadingAnchor, constant: Constants.Metrics.horizontalPadding)
        statusLabelView.pinTrailing(to: view.trailingAnchor, constant: -Constants.Metrics.horizontalPadding)
        
        retryButton.pinTop(to: statusLabelView.bottomAnchor, constant: Constants.Metrics.verticalPadding)
        retryButton.centerX(to: view.centerXAnchor)
        retryButton.setHeight(44)
        retryButton.setWidth(120)
    }
    
    @objc private func retryTapped() {
        // Retry logic
    }
}
