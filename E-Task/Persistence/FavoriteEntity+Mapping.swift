//
//  FavoriteEntity+Mapping.swift
//  E-Task
//
//  Created by XECE on 13.07.2025.
//

import Foundation
import CoreData

extension FavoriteEntity {
    // Core Data entity'den domain model Product'a dönüşüm
    /*func toProduct() -> Product {
     return Product(
     id: String(id),
     name: name ?? "",
     imageURL: imageURL ?? "",
     price: String(price),
     details: details ?? "",
     model: model ?? "",
     brand: brand ?? "",
     isFavorite: true
     )
     }
     
     // Domain model Product'dan Core Data entity oluşturma veya güncelleme
     func update(from product: Product, context: NSManagedObjectContext) {
     self.id = Int64(product.id)!
     self.name = product.name
     self.imageURL = product.imageURL
     self.price = Double(product.price)!
     self.details = product.details
     self.model = product.model
     self.brand = product.brand
     }*/
}

