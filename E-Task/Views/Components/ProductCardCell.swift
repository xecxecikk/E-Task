//
//  ProductCardCell.swift
//  E-Task
//
//  Created by XECE on 13.07.2025.
//

import UIKit

final class ProductCardCell: UICollectionViewCell {
    
    private let imageView = UIImageView()
    private let favoriteButton = UIButton(type: .system)
    private let nameLabel = UILabel()
    private let priceLabel = UILabel()
    private let addToCartButton = UIButton(type: .system)
    
    private var currentProduct: Product?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.systemGray5.cgColor
        contentView.clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        
        favoriteButton.tintColor = .systemYellow
        favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        favoriteButton.addTarget(self, action: #selector(didTapFavorite), for: .touchUpInside)
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        nameLabel.textColor = .black
        nameLabel.numberOfLines = 2
        
        priceLabel.font = UIFont.systemFont(ofSize: 14)
        priceLabel.textColor = UIColor(red: 0.00, green: 0.60, blue: 0.20, alpha: 1.00)
        
        addToCartButton.setTitle("Add to Cart", for: .normal)
        addToCartButton.setTitleColor(.white, for: .normal)
        addToCartButton.backgroundColor = UIColor.systemBlue
        addToCartButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        addToCartButton.layer.cornerRadius = 6
        addToCartButton.addTarget(self, action: #selector(didTapAddToCart), for: .touchUpInside)
        
        [imageView, favoriteButton, nameLabel, priceLabel, addToCartButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
    }
    
    private func layoutUI() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            favoriteButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 6),
            favoriteButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -6),
            favoriteButton.widthAnchor.constraint(equalToConstant: 20),
            favoriteButton.heightAnchor.constraint(equalToConstant: 20),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            addToCartButton.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
            addToCartButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            addToCartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            addToCartButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            addToCartButton.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
    
    func configure(with product: Product) {
        currentProduct = product
        nameLabel.text = product.name
        priceLabel.text = "\(product.price) ₺"
        
        if imageView.accessibilityIdentifier != product.imageURL {
            imageView.loadImage(from: product.imageURL, placeholder: UIImage(named: "placeholder"))
            imageView.accessibilityIdentifier = product.imageURL
        }
        
        let isFav = FavoritesManager.shared.isFavorite(product)
        let starImage = isFav ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        favoriteButton.setImage(starImage, for: .normal)
        
        currentProduct?.isFavorite = isFav
    }
    
    @objc private func didTapFavorite() {
        guard let product = currentProduct else { return }
        let isFav = FavoritesManager.shared.isFavorite(product)
        
        if isFav {
            FavoritesManager.shared.remove(product)
            currentProduct?.isFavorite = false
        } else {
            FavoritesManager.shared.add(product)
            currentProduct?.isFavorite = true
        }
        
        let starImage = currentProduct?.isFavorite == true ? "star.fill" : "star"
        favoriteButton.setImage(UIImage(systemName: starImage), for: .normal)
        
        NotificationCenter.default.post(name: .favoritesUpdated, object: currentProduct)
    }
    
    @objc private func didTapAddToCart() {
        guard let product = currentProduct else { return }
        CartManager.shared.addToCart(product: product)
        NotificationCenter.default.post(name: .cartUpdated, object: nil)
    }
}
