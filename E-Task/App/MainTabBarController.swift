//
//  MainTabBarController.swift
//  E-Task
//
//  Created by XECE on 13.07.2025.
//
import UIKit

final class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(cartUpdated),
            name: .cartUpdated,
            object: nil
        )
        
        updateCartBadge()
        configureAppearance()
    }
    
    private func setupTabBar() {
        viewControllers = [
            createNavController(
                rootViewController: ProductListViewController(viewModel: ProductListViewModel()),
                title: "Home",
                iconName: "house"
            ),
            createNavController(
                rootViewController: FavoritesViewController(viewModel: FavoritesViewModel()),
                title: "Favorites",
                iconName: "star"
            ),
            createNavController(
                rootViewController: CartViewController(viewModel: CartViewModel()),
                title: "Cart",
                iconName: "cart"
            ),
            createNavController(
                rootViewController: ProfileViewController(),
                title: "Profile",
                iconName: "person"
            )
        ]
    }
    
    private func configureAppearance() {
        tabBar.barTintColor = UIColor.systemBackground
        tabBar.isTranslucent = false
        tabBar.tintColor = UIColor.systemBlue
        tabBar.unselectedItemTintColor = UIColor.gray
    }
    
    private func createNavController(rootViewController: UIViewController, title: String, iconName: String) -> UINavigationController {
        let navController = UINavigationController(rootViewController: rootViewController)
        
        let tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: iconName), selectedImage: UIImage(systemName: iconName + ".fill"))
        tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 300)
        navController.tabBarItem = tabBarItem
        
        rootViewController.title = ""
        return navController
    }
    
    
    @objc private func cartUpdated() {
        updateCartBadge()
    }
    
    private func updateCartBadge() {
        guard let cartNav = viewControllers?[2] else { return }
        let itemCount = CartManager.shared.items.reduce(0) { $0 + $1.quantity }
        cartNav.tabBarItem.badgeValue = itemCount > 0 ? "\(itemCount)" : nil
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
