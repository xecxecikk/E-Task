//
//  TopBarView.swift
//  E-Task
//
//  Created by XECE on 13.07.2025.
//

import UIKit

final class TopBarView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "E-Market"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBlue
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12) 
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
