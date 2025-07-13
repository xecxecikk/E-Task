//
//  E_TaskTests.swift
//  E-TaskTests
//
//  Created by XECE on 13.07.2025.
//

import XCTest
@testable import E_Task

final class ProductDetailViewModelTests: XCTestCase {
    
    var viewModel: ProductDetailViewModel!
    var mockFavoritesManager: MockFavoritesManager!
    var mockCartManager: MockCartManager!
    let mockProduct = Product(
        id: "1",
        name: "Test Product",
        imageURL: "test.png",
        price: "99.99",
        details: "Details",
        model: "Model",
        brand: "Brand",
        isFavorite: false
    )
    
    override func setUp() {
        super.setUp()
        let inMemoryCoreData = CoreDataTestHelper.makeInMemoryManager()
        
        
        mockFavoritesManager = MockFavoritesManager()
        mockCartManager = MockCartManager()
        viewModel = ProductDetailViewModel(
            product: mockProduct,
            favoritesManager: mockFavoritesManager,
            cartManager: mockCartManager
        )
    }
    
    func testInitialFavoriteStatus() {
        mockFavoritesManager.fakeFavorites = [mockProduct]
        XCTAssertTrue(viewModel.isFavorite)
    }
    
    func testToggleFavoriteAddsIfNotExists() {
        viewModel.toggleFavorite()
        XCTAssertTrue(mockFavoritesManager.didToggle)
        XCTAssertEqual(mockFavoritesManager.toggleCalledWith?.id, mockProduct.id)
    }
    
    func testAddToCartAddsCorrectProduct() {
        viewModel.addToCart()
        XCTAssertTrue(mockCartManager.didAddToCart)
        XCTAssertEqual(mockCartManager.addedProduct?.id, mockProduct.id)
    }
}
