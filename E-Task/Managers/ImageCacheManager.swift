//
//  ImageCacheManager.swift
//  E-Task
//
//  Created by XECE on 13.07.2025.
//

import UIKit

final class ImageCacheManager {
    static let shared = ImageCacheManager()
    
    private let cacheDirectoryURL: URL
    
    private init() {
        // Cache klasör yolunu al
        let paths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        cacheDirectoryURL = paths[0].appendingPathComponent("ImageCache")
        
        // Cache klasörünü oluştur (yoksa)
        if !FileManager.default.fileExists(atPath: cacheDirectoryURL.path) {
            try? FileManager.default.createDirectory(at: cacheDirectoryURL, withIntermediateDirectories: true)
        }
    }
    
    func image(forKey key: String) -> UIImage? {
        let fileURL = cacheDirectoryURL.appendingPathComponent(key)
        guard let data = try? Data(contentsOf: fileURL) else { return nil }
        return UIImage(data: data)
    }
    
    func save(image: UIImage, forKey key: String) {
        let fileURL = cacheDirectoryURL.appendingPathComponent(key)
        guard let data = image.pngData() else { return }
        try? data.write(to: fileURL)
    }
    
    func clearCache() {
        try? FileManager.default.removeItem(at: cacheDirectoryURL)
        try? FileManager.default.createDirectory(at: cacheDirectoryURL, withIntermediateDirectories: true)
    }
}
