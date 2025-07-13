//
//  TitleLabel.swift
//  E-Task
//
//  Created by XECE on 13.07.2025.
//

import UIKit

final class TitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        textColor = .label
        numberOfLines = 2
        lineBreakMode = .byTruncatingTail
    }
}
