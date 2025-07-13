//
//  APIError.swift
//  E-Task
//
//  Created by XECE on 13.07.2025.
//

import Foundation

enum APIError: Error, LocalizedError {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingError(Error)
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Geçersiz URL."
        case .requestFailed(let error):
            return "İstek başarısız oldu: \(error.localizedDescription)"
        case .invalidResponse:
            return "Geçersiz sunucu yanıtı."
        case .decodingError(let error):
            return "Veri çözümlenemedi: \(error.localizedDescription)"
        case .unknown:
            return "Bilinmeyen bir hata oluştu."
        }
    }
}
