//
//  UIImageView+Extensions.swift
//  E-Task
//
//  Created by XECE on 13.07.2025.
//

import UIKit

extension UIImageView {
    func loadImage(from urlString: String, placeholder: UIImage? = nil) {
        self.image = placeholder

        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let data = data,
                error == nil,
                let image = UIImage(data: data)
            else { return }

            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
    
    /* //verileri alirken cache lema yaparak tekrar tekrar load engelleriz
     
     func loadImageUsingCache(with urlString: String, placeholder: UIImage? = nil) {
             self.image = placeholder

             let cacheKey = urlString.md5() // String’den benzersiz key üretmek için hash (md5 ya da başka)

             if let cachedImage = ImageCacheManager.shared.image(forKey: cacheKey) {
                 self.image = cachedImage
                 return
             }

             guard let url = URL(string: urlString) else { return }

             URLSession.shared.dataTask(with: url) { data, _, _ in
                 guard let data = data, let image = UIImage(data: data) else { return }

                 ImageCacheManager.shared.save(image: image, forKey: cacheKey)

                 DispatchQueue.main.async {
                     self.image = image
                 }
             }.resume()
         }
     
     
     */
}
