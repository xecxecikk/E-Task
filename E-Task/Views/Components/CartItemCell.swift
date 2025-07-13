//
//  CartItemCell.swift
//  E-Task
//
//  Created by XECE on 13.07.2025.
//

import UIKit

final class CartItemCell: UITableViewCell {
    
    private let productImageView = UIImageView()
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let quantityLabel = UILabel()
    private let decreaseButton = UIButton(type: .system)
    private let increaseButton = UIButton(type: .system)
    
    private var item: CartItem?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with item: CartItem) {
        self.item = item
        titleLabel.text = item.product.name
        priceLabel.text = "\(item.product.price) ₺"
        quantityLabel.text = "\(item.quantity)"
        productImageView.loadImage(from: item.product.imageURL, placeholder: UIImage(named: "placeholder"))
    }
    
    
    @objc private func increaseTapped() {
        guard var item = item else { return }
        item.quantity += 1
        CartManager.shared.increaseQuantity(for: item.product)
        NotificationCenter.default.post(name: .cartUpdated, object: nil)
        configure(with: item) // UI güncelleme
    }
    
    @objc private func decreaseTapped() {
        guard var item = item else { return }
        if item.quantity > 1 {
            item.quantity -= 1
            CartManager.shared.decreaseQuantity(for: item.product)
        } else {
            // Eğer quantity 1 ise silme işlemini dışarıdan yapmak
            CartManager.shared.decreaseQuantity(for: item.product)
            NotificationCenter.default.post(name: .cartUpdated, object: nil)
        }
    }
    
    
    private func setupUI() {
        [productImageView, titleLabel, priceLabel, quantityLabel, decreaseButton, increaseButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        productImageView.contentMode = .scaleAspectFill
        productImageView.clipsToBounds = true
        productImageView.layer.cornerRadius = 8
        
        titleLabel.font = Constants.Fonts.bold(size: 16)
        titleLabel.numberOfLines = 2
        
        priceLabel.font = Constants.Fonts.regular(size: 14)
        priceLabel.textColor = .darkGray
        
        quantityLabel.font = Constants.Fonts.bold(size: 16)
        quantityLabel.textAlignment = .center
        
        decreaseButton.setTitle("-", for: .normal)
        decreaseButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        decreaseButton.addTarget(self, action: #selector(decreaseTapped), for: .touchUpInside)
        
        increaseButton.setTitle("+", for: .normal)
        increaseButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        increaseButton.addTarget(self, action: #selector(increaseTapped), for: .touchUpInside)
    }
    
    private func layoutUI() {
        productImageView.pinTop(to: contentView.topAnchor, constant: 8)
        productImageView.pinLeading(to: contentView.leadingAnchor, constant: 16)
        productImageView.setSize(width: 80, height: 80)
        productImageView.pinBottom(to: contentView.bottomAnchor, constant: 8)
        
        titleLabel.pinTop(to: productImageView.topAnchor)
        titleLabel.pinLeading(to: productImageView.trailingAnchor, constant: 12)
        titleLabel.pinTrailing(to: contentView.trailingAnchor, constant: 16)
        
        priceLabel.pinTop(to: titleLabel.bottomAnchor, constant: 4)
        priceLabel.pinLeading(to: titleLabel.leadingAnchor)
        
        decreaseButton.pinLeading(to: titleLabel.leadingAnchor)
        decreaseButton.pinTop(to: priceLabel.bottomAnchor, constant: 8)
        decreaseButton.setSize(width: 28, height: 28)
        
        quantityLabel.centerY(to: decreaseButton.centerYAnchor)
        quantityLabel.pinLeading(to: decreaseButton.trailingAnchor, constant: 8)
        quantityLabel.setWidth(30)
        
        increaseButton.centerY(to: decreaseButton.centerYAnchor)
        increaseButton.pinLeading(to: quantityLabel.trailingAnchor, constant: 8)
        increaseButton.setSize(width: 28, height: 28)
    }
}
