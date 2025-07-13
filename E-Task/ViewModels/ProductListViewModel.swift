//
//  ProductListViewModel.swift
//  E-Task
//
//  Created by XECE on 13.07.2025.
//

import Foundation

enum PriceSortOption {
    case none
    case priceAscending
    case priceDescending
}

final class ProductListViewModel {
    
    
    private(set) var allProducts: [Product] = []
    private(set) var filteredProducts: [Product] = []
    
    var onUpdate: (() -> Void)?
    var onLoading: ((Bool) -> Void)? 
    
    private var currentPage = 1
    private var isFetching = false
    private var hasMoreData = true
    
    var searchQuery: String = "" {
        didSet {
            applyFiltersAndSorting()
        }
    }
    
    var filterOption: PriceSortOption = .none {
        didSet { applyFiltersAndSorting() }
    }
    
    init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(favoritesUpdated),
            name: .favoritesUpdated,
            object: nil
        )
    }
    
    func fetchInitialProducts() {
        currentPage = 1
        hasMoreData = true
        allProducts.removeAll()
        filteredProducts.removeAll()
        fetchMoreProducts()
    }
    
    func fetchMoreProducts() {
        guard !isFetching, hasMoreData else { return }
        isFetching = true
        onLoading?(true)
        
        let endpoint = "\(APIConstants.baseURL)\(APIConstants.Path.products)?page=\(currentPage)&limit=4"
        
        APIService.shared.fetchData(from: endpoint, type: [Product].self) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.isFetching = false
                self.onLoading?(false)
                
                switch result {
                case .success(let products):
                    if products.isEmpty {
                        self.hasMoreData = false
                    } else {
                        self.allProducts += products
                        self.applyFiltersAndSorting()
                        self.currentPage += 1
                    }
                    
                case .failure(let error):
                    print("Fetch error:", error.localizedDescription)
                }
            }
        }
    }
    
    
    
    func product(at index: Int) -> Product {
        filteredProducts[index]
    }
    
    var numberOfItems: Int {
        filteredProducts.count
    }
    
    func toggleFavorite(at index: Int) {
        let product = filteredProducts[index]
        FavoritesManager.shared.toggle(product)
    }
    
    func applyFiltersAndSorting() {
        var filtered = allProducts
        
        if !searchQuery.isEmpty {
            filtered = filtered.filter {
                $0.name.lowercased().contains(searchQuery.lowercased())
            }
        }
        
        switch filterOption {
        case .priceAscending:
            filtered.sort { $0.price < $1.price }
        case .priceDescending:
            filtered.sort { $0.price > $1.price }
        case .none:
            break
        }
        
        filteredProducts = filtered
        onUpdate?()
    }
    
    
    
    @objc private func favoritesUpdated() {
        onUpdate?()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
