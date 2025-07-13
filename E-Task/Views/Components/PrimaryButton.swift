//
//  PrimaryButton.swift
//  E-Task
//
//  Created by XECE on 13.07.2025.
//

import UIKit

final class PrimaryButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        setupUI(title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(title: String) {
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        backgroundColor = .systemBlue
        titleLabel?.font = Constants.Fonts.bold(size: 16)
        layer.cornerRadius = 8
        clipsToBounds = true
        
        heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
}
