//
//  StatusLabelView.swift
//  E-Task
//
//  Created by XECE on 13.07.2025.
//

import UIKit

final class StatusLabelView: UIView {
    
    private let label = UILabel()
    
    var text: String? {
        get { label.text }
        set { label.text = newValue }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
        layout()
    }
    
    private func setup() {
        label.textAlignment = .center
        label.textColor = .systemRed
        label.font = Constants.Fonts.bold(size: 18)
        label.numberOfLines = 0
        addSubview(label)
    }
    
    private func layout() {
        label.pin(to: self)
    }
}
