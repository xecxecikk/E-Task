//
//  UIButton+Extensions.swift
//  E-Task
//
//  Created by XECE on 13.07.2025.
//

import UIKit

extension UIView {
    func animateTapFeedback(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { _ in
            UIView.animate(withDuration: 0.1, animations: {
                self.transform = CGAffineTransform.identity
            }, completion: { _ in
                completion?()
            })
        }
    }
}
