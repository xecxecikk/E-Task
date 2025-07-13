//
//  CardManager.swift
//  E-Task
//
//  Created by XECE on 13.07.2025.
//

import Foundation
import CoreData

class CartManager {
    static let shared = CartManager()
    private(set) var items: [CartItem] = []
    
    internal init() {
        loadFromCoreData()
    }
    
    var totalPrice: Double {
        items.reduce(0) { $0 + (Double($1.product.price)! * Double($1.quantity)) }
    }
    
    func addToCart(product: Product) {
        if let index = items.firstIndex(where: { $0.product.id == product.id }) {
            items[index].quantity += 1
        } else {
            items.append(CartItem(product: product, quantity: 1))
        }
        saveToCoreData()
        notifyCartUpdated()
    }
    
    func updateQuantity(for product: Product, quantity: Int) {
        guard let index = items.firstIndex(where: { $0.product.id == product.id }) else { return }
        items[index].quantity = max(1, quantity)
        saveToCoreData()
        notifyCartUpdated()
    }
    
    func removeFromCart(product: Product) {
        items.removeAll { $0.product.id == product.id }
        saveToCoreData()
        notifyCartUpdated()
    }
    
    func clearCart() {
        items.removeAll()
        CoreDataManager.shared.deleteAll(CartItemEntity.self)
        notifyCartUpdated()
    }
    
    private func notifyCartUpdated() {
        NotificationCenter.default.post(name: .cartUpdated, object: nil)
    }
    
    func increaseQuantity(for product: Product) {
        guard let index = items.firstIndex(where: { $0.product.id == product.id }) else { return }
        items[index].quantity += 1
        saveToCoreData()
        notifyCartUpdated()
    }
    
    func decreaseQuantity(for product: Product) {
        guard let index = items.firstIndex(where: { $0.product.id == product.id }) else { return }
        
        if items[index].quantity > 1 {
            print("urunAdet 1")
            items[index].quantity -= 1
            saveToCoreData()
            notifyCartUpdated()
        } else {
            print("urunAdet 2")
            removeFromCart(product: product)
        }
    }
    
    
    private func saveToCoreData() {
        let context = CoreDataManager.shared.context
        CoreDataManager.shared.deleteAll(CartItemEntity.self)
        for item in items {
            let entity = CartItemEntity(context: context)
            entity.id = Int64(item.product.id)!
            entity.name = item.product.name
            entity.price = Double(item.product.price)!
            entity.quantity = Int64(item.quantity)
            entity.imageURL = item.product.imageURL
        }
        
        CoreDataManager.shared.saveContext()
    }
    
    private func loadFromCoreData() {
        let fetched: [CartItemEntity] = CoreDataManager.shared.fetch(CartItemEntity.self)
        items = fetched.map {
            let product = Product(id: String($0.id),
                                  name: $0.name ?? "",
                                  imageURL: $0.imageURL ?? "",
                                  price: String($0.price),
                                  details: $0.details ?? "bilimiyor",
                                  model: $0.model ?? "bilinmiyor",
                                  brand: $0.brand ?? "bilinmiyor",
                                  isFavorite: false
            )
            return CartItem(product: product, quantity: Int($0.quantity))
        }
    }
}
