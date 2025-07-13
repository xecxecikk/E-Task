//
//  Product.swift
//  E-Task
//
//  Created by XECE on 13.07.2025.
//

import Foundation

struct Product: Codable, Equatable {
    let id: String
    let name: String
    let imageURL: String
    let price: String
    let details: String
    let model: String
    let brand: String
    var isFavorite: Bool = false
    
    
    init(id: String, name: String, imageURL: String, price: String, details: String, model: String, brand: String, isFavorite: Bool = false) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
        self.price = price
        self.details = details
        self.model = model
        self.brand = brand
        self.isFavorite = isFavorite
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageURL = "image"
        case price
        case details = "description"
        case model
        case brand
    }
    
}
