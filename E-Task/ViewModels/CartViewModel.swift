//
//  CartViewModel.swift
//  E-Task
//
//  Created by XECE on 13.07.2025.
//

import Foundation

final class CartViewModel {
    private(set) var items: [CartItem] = []
    private(set) var totalPrice: Double = 0
    var onUpdate: (() -> Void)?
    
    init() {
        observeCartChanges()
        reloadCart()
    }
    
    func reloadCart() {
        items = CartManager.shared.items
        totalPrice = CartManager.shared.totalPrice
        onUpdate?()
    }
    
    func clearCart() {
        CartManager.shared.clearCart()
        reloadCart()
    }
    
    func increaseQuantity(for item: CartItem) {
        CartManager.shared.increaseQuantity(for: item.product)
        reloadCart()
    }
    
    func decreaseQuantity(for item: CartItem) {
        CartManager.shared.decreaseQuantity(for: item.product)
        reloadCart()
    }
    
    func removeItem(_ item: CartItem) {
        CartManager.shared.removeFromCart(product: item.product)
        reloadCart()
    }
    
    
    private func observeCartChanges() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(cartUpdated),
            name: .cartUpdated,
            object: nil
        )
    }
    
    @objc private func cartUpdated() {
        reloadCart()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
