//
//  PriceLabel.swift
//  E-Task
//
//  Created by XECE on 13.07.2025.
//

import UIKit

final class PriceLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        font = Constants.Fonts.bold(size: 16)
        textColor = .systemGreen
        textAlignment = .left
        numberOfLines = 1
    }
    
    func configure(with priceString: String) {
        if let priceValue = Double(priceString) {
            text = "\(Int(priceValue)) ₺"
        } else {
            text = "\(priceString) ₺" // fallback
        }
    }
}
