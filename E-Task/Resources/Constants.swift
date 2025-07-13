//
//  Constants.swift
//  E-Task
//
//  Created by XECE on 13.07.2025.
//

import UIKit

enum Constants {
    
    enum Fonts {
        static func regular(size: CGFloat) -> UIFont {
            UIFont.systemFont(ofSize: size, weight: .regular)
        }
        
        static func medium(size: CGFloat) -> UIFont {
            UIFont.systemFont(ofSize: size, weight: .medium)
        }
        
        static func bold(size: CGFloat) -> UIFont {
            UIFont.systemFont(ofSize: size, weight: .bold)
        }
        
        static func semiBold(size: CGFloat) -> UIFont {
            UIFont.systemFont(ofSize: size, weight: .semibold)
        }
    }
    
    enum Colors {
        static let primary = UIColor.systemBlue
        static let secondary = UIColor.systemGray
        static let background = UIColor.white
        static let textPrimary = UIColor.black
        static let textSecondary = UIColor.darkGray
        static let separator = UIColor.systemGray4
        static let accent = UIColor.systemGreen
    }
    
    enum Metrics {
        
        static let horizontalPadding: CGFloat = 16
        
        static let verticalPadding: CGFloat = 16
        
        static let interItemSpacingHorizontal: CGFloat = 12
        
        static let interItemSpacingVertical: CGFloat = 12
        
        static let contentInsetSmall: CGFloat = 8
        static let contentInsetMedium: CGFloat = 16
        static let contentInsetLarge: CGFloat = 24
        
        static let sectionSpacing: CGFloat = 24
        
        static let microSpacing: CGFloat = 4
        
        static let cornerRadius: CGFloat = 8
        
        // Özel durumlar için ekstra boşluk (örneğin farklı ekran boyutları için)
        static let largePadding: CGFloat = 32
        static let smallPadding: CGFloat = 4
    }
    
    enum Icons {
        static let cart = UIImage(systemName: "cart")
        static let star = UIImage(systemName: "star")
        static let starFill = UIImage(systemName: "star.fill")
        static let search = UIImage(systemName: "magnifyingglass")
        static let filter = UIImage(
            systemName: "line.3.horizontal.decrease.circle"
        )
    }
    
}
