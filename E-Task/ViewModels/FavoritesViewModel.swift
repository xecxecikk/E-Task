//
//  FavoritesViewModel.swift
//  E-Task
//
//  Created by XECE on 13.07.2025.
//

import Foundation

final class FavoritesViewModel {
    private(set) var favorites: [Product] = []
    var onUpdate: (() -> Void)?
    
    init() {
        observeFavoritesChanges()
        reloadFavorites()
    }
    
    func reloadFavorites() {
        favorites = FavoritesManager.shared.favorites
        onUpdate?()
    }
    
    func toggleFavorite(for product: Product) {
        FavoritesManager.shared.toggle(product)
        reloadFavorites()
    }
    
    private func observeFavoritesChanges() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(favoritesUpdated),
            name: .favoritesUpdated,
            object: nil
        )
    }
    
    @objc private func favoritesUpdated() {
        reloadFavorites()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
