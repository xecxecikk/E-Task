//
//  FavoritesManager.swift
//  E-Task
//
//  Created by XECE on 13.07.2025.
//

import Foundation
import CoreData

class FavoritesManager {
    private let coreData: CoreDataManager
    
    static let shared = FavoritesManager()
    private let context = CoreDataManager.shared.context
    
    private(set) var favorites: [Product] = []
    
    init(coreData: CoreDataManager = .shared) {
        self.coreData = coreData
        loadFavorites()
    }
    
    func add(_ product: Product) {
        guard !favorites.contains(where: { $0.id == product.id }) else { return }
        
        let entity = FavoriteEntity(context: context)
        entity.id = Int64(product.id)!
        entity.name = product.name
        entity.price = Double(product.price)!
        entity.imageURL = product.imageURL
        entity.details = product.details
        
        CoreDataManager.shared.saveContext()
        loadFavorites()
        NotificationCenter.default.post(name: .favoritesUpdated, object: nil)
    }
    
    
    func remove(_ product: Product) {
        let fetchRequest: NSFetchRequest<FavoriteEntity> = FavoriteEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", product.id)
        if let result = try? context.fetch(fetchRequest), let objectToDelete = result.first {
            context.delete(objectToDelete)
            CoreDataManager.shared.saveContext()
            loadFavorites()
            NotificationCenter.default.post(name: .favoritesUpdated, object: nil)
        }
    }
    
    
    func toggle(_ product: Product) {
        if isFavorite(product) {
            remove(product)
        } else {
            add(product)
        }
    }
    
    
    func isFavorite(_ product: Product) -> Bool {
        favorites.contains(where: { $0.id == product.id })
    }
    
    
    func loadFavorites() {
        let result: [FavoriteEntity] = CoreDataManager.shared.fetch(FavoriteEntity.self)
        favorites = result.map {
            Product(
                id: String($0.id),
                name: $0.name ?? "",
                imageURL: $0.imageURL ?? "",
                price: String($0.price),
                details: $0.details ?? "",
                model: $0.model ?? "bilinmiyor",
                brand: $0.brand ?? "bilinmiyor",
                isFavorite: true
            )
        }
    }
}
