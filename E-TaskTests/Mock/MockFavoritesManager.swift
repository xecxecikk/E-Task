//
//  MockFavoritesManager.swift
//  E-TaskTests
//
//  Created by XECE on 13.07.2025.
//

@testable import E_Task

final class MockFavoritesManager: FavoritesManager {
    var didToggle = false
    var toggleCalledWith: Product?
    var fakeFavorites: [Product] = []
    
    override func toggle(_ product: Product) {
        didToggle = true
        toggleCalledWith = product
    }
    
    override func isFavorite(_ product: Product) -> Bool {
        return fakeFavorites.contains(where: { $0.id == product.id })
    }
}
