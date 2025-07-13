//
//  UIView+Constraints.swift
//  E-Task
//
//  Created by XECE on 13.07.2025.
//

import UIKit

extension UIView {
    
    /// Bir görünümü başka bir görünüme sabitler (padding opsiyonel)
    func pin(to view: UIView, padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor, constant: padding.top),
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding.left),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding.right),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding.bottom)
        ])
    }
    
    func pin(to guide: UILayoutGuide, padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: guide.topAnchor, constant: padding.top),
            leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: padding.left),
            trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -padding.right),
            bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -padding.bottom)
        ])
    }
    
    func pinTop(to anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
    }
    
    func pinBottom(to anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        bottomAnchor.constraint(equalTo: anchor, constant: -constant).isActive = true
    }
    
    func pinLeading(to anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
    }
    
    func pinTrailing(to anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        trailingAnchor.constraint(equalTo: anchor, constant: -constant).isActive = true
    }
    
    func centerInSuperview(size: CGSize? = nil) {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
        
        if let size = size {
            setWidth(size.width)
            setHeight(size.height)
        }
    }
    
    func centerX(to anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
    }
    
    func centerY(to anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
    }
    
    func setWidth(_ constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    func setHeight(_ constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    func setSize(width: CGFloat, height: CGFloat) {
        setWidth(width)
        setHeight(height)
    }
    
    func setAspectRatio(_ ratio: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalTo: widthAnchor, multiplier: ratio).isActive = true
    }
    
    
}
