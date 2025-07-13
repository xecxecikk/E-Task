//
//  ProductDetailViewController.swift
//  E-Task
//
//  Created by XECE on 13.07.2025.
//

import UIKit
final class ProductDetailViewController: UIViewController {
    
    private let viewModel: ProductDetailViewModel
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let imageView = UIImageView()
    private let nameLabel = TitleLabel()
    private let priceLabel = PriceLabel()
    private let descriptionLabel = UILabel()
    private let addToCartButton = PrimaryButton(title: "Add to Cart")
    
    init(viewModel: ProductDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Product Detail"
        setup()
        layout()
        configure()
    }
    
    private func setup() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [imageView, nameLabel, priceLabel, descriptionLabel, addToCartButton].forEach {
            contentView.addSubview($0)
        }
        
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        
        descriptionLabel.font = .systemFont(ofSize: 14)
        descriptionLabel.numberOfLines = 0
        
        addToCartButton.addTarget(self, action: #selector(addToCartTapped), for: .touchUpInside)
    }
    
    private func layout() {
        scrollView.pin(to: view.safeAreaLayoutGuide)
        contentView.pin(to: scrollView)
        contentView.setWidth(view.frame.width)
        
        imageView.pinTop(to: contentView.topAnchor, constant: 16)
        imageView.pinLeading(to: contentView.leadingAnchor, constant: 16)
        imageView.pinTrailing(to: contentView.trailingAnchor, constant: 16)
        imageView.setAspectRatio(1)
        
        nameLabel.pinTop(to: imageView.bottomAnchor, constant: 16)
        nameLabel.pinLeading(to: contentView.leadingAnchor, constant: 16)
        nameLabel.pinTrailing(to: contentView.trailingAnchor, constant: 16)
        
        priceLabel.pinTop(to: nameLabel.bottomAnchor, constant: 8)
        priceLabel.pinLeading(to: contentView.leadingAnchor, constant: 16)
        
        descriptionLabel.pinTop(to: priceLabel.bottomAnchor, constant: 16)
        descriptionLabel.pinLeading(to: contentView.leadingAnchor, constant: 16)
        descriptionLabel.pinTrailing(to: contentView.trailingAnchor, constant: 16)
        
        addToCartButton.pinTop(to: descriptionLabel.bottomAnchor, constant: 32)
        addToCartButton.pinLeading(to: contentView.leadingAnchor, constant: 16)
        addToCartButton.pinTrailing(to: contentView.trailingAnchor, constant: 16)
        addToCartButton.setHeight(50)
        addToCartButton.pinBottom(to: contentView.bottomAnchor, constant: 16)
    }
    
    private func configure() {
        imageView.loadImage(from: viewModel.product.imageURL, placeholder: UIImage(named: "placeholder"))
        nameLabel.text = viewModel.product.name
        priceLabel.text = "\(viewModel.product.price) ₺"
        descriptionLabel.text = viewModel.product.details
    }
    
    @objc private func addToCartTapped() {
        viewModel.addToCart()
        NotificationCenter.default.post(name: .cartUpdated, object: nil)
        navigationController?.popViewController(animated: true)
    }
}
