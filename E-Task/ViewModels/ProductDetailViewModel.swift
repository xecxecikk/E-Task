//
//  ProductDetailViewModel.swift
//  E-Task
//
//  Created by XECE on 13.07.2025.
//

import Foundation

final class ProductDetailViewModel {
    
    private(set) var product: Product
    private let favoritesManager: FavoritesManager
    private let cartManager: CartManager
    
    var title: String {
        product.name
    }
    
    var priceText: String {
        "\(Int(product.price)).000 ₺"
    }
    
    var description: String {
        product.details ?? "No description available."
    }
    
    var imageName: String {
        product.imageURL
    }
    
    var isFavorite: Bool {
        product.isFavorite
    }
    
    var onFavoriteChanged: (() -> Void)?
    var onCartUpdated: (() -> Void)?
    
    init(product: Product,favoritesManager: FavoritesManager = .shared, cartManager: CartManager = .shared) {
        self.product = product
        self.favoritesManager = favoritesManager
        self.cartManager = cartManager
    }
    
    func toggleFavorite() {
        FavoritesManager.shared.toggle(product)
        product.isFavorite.toggle()
        onFavoriteChanged?()
    }
    
    func addToCart() {
        CartManager.shared.addToCart(product: product)
        onCartUpdated?()
    }
}
