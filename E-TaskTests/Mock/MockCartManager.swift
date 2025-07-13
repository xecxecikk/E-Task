//
//  MockCartManager.swift
//  E-TaskTests
//
//  Created by XECE on 13.07.2025.
//
@testable import E_Task

final class MockCartManager: CartManager {
    var didAddToCart = false
    var addedProduct: Product?
    
    override func addToCart(product: Product) {
        didAddToCart = true
        addedProduct = product
    }
}
