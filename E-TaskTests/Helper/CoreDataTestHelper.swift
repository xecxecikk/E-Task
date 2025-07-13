//
//  CoreDataTestHelper.swift
//  E-TaskTests
//
//  Created by XECE on 13.07.2025.
//

import CoreData
@testable import E_Task

final class CoreDataTestHelper {
    static func makeInMemoryManager() -> CoreDataManager {
        return CoreDataManager(inMemory: true)
    }
}
