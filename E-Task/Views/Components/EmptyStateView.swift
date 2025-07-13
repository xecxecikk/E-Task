//
//  EmptyStateView.swift
//  E-Task
//
//  Created by XECE on 13.07.2025.
//

import UIKit

final class EmptyStateView: UIView {
    
    private let imageView = UIImageView()
    private let messageLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(message: String, imageName: String = "tray") {
        messageLabel.text = message
        imageView.image = UIImage(systemName: imageName)
    }
    
    private func setupUI() {
        backgroundColor = .white
        
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray3
        
        messageLabel.font = Constants.Fonts.medium(size: 16)
        messageLabel.textColor = .darkGray
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        
        addSubview(imageView)
        addSubview(messageLabel)
    }
    
    private func layoutUI() {
        imageView.centerX(to: centerXAnchor)
        imageView.centerY(to: centerYAnchor, constant: -40)
        imageView.setSize(width: 60, height: 60)
        
        messageLabel.pinTop(to: imageView.bottomAnchor, constant: 16)
        messageLabel.pinLeading(to: leadingAnchor, constant: 32)
        messageLabel.pinTrailing(to: trailingAnchor, constant: 32)
    }
}
