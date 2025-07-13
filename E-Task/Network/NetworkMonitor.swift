//
//  NetworkMonitor.swift
//  E-Task
//
//  Created by XECE on 13.07.2025.
//

import Network
import Foundation

final class NetworkMonitor {
    static let shared = NetworkMonitor()
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitorQueue")
    
    private(set) var isConnected: Bool = true
    
    var didChangeStatus: ((Bool) -> Void)?
    
    private init() {
        startMonitoring()
    }
    
    private func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            let status = path.status == .satisfied
            if self.isConnected != status {
                self.isConnected = status
                DispatchQueue.main.async {
                    self.didChangeStatus?(status)
                    NotificationCenter.default.post(name: .networkStatusChanged, object: nil)
                }
            }
        }
        monitor.start(queue: queue)
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}

extension Notification.Name {
    static let networkStatusChanged = Notification.Name("networkStatusChanged")
}
