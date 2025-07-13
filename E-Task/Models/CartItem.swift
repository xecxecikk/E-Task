//
//  CartItem.swift
//  E-Task
//
//  Created by XECE on 13.07.2025.
//

import Foundation

struct CartItem: Equatable {
    let product: Product
    var quantity: Int
}

extension CartItem {
    var totalPrice: Double {
        return Double(product.price)! * Double(quantity)
    }
}
