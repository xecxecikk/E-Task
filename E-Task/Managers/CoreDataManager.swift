//
//  CoreDataManager.swift
//  E-Task
//
//  Created by XECE on 13.07.2025.
//

import CoreData
import UIKit

final class CoreDataManager {
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer
    
    
    init(inMemory: Bool = false) {
        let container = NSPersistentContainer(name: "CoreDataModel") // .xcdatamodeld dosya adı
        if inMemory {
            let description = NSPersistentStoreDescription()
            description.type = NSInMemoryStoreType
            container.persistentStoreDescriptions = [description]
        }
        
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError(" Core Data yüklenemedi: \(error)")
            }
        }
        
        self.persistentContainer = container
    }
    
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // Save Context
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                print("CoreData Save Error: \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    // Fetch Generic
    func fetch<T: NSManagedObject>(_ type: T.Type) -> [T] {
        let request = type.fetchRequest()
        let entityName = String(describing: type)
        print("entityName \(entityName)")
        do {
            let result = try context.fetch(request)
            return result as? [T] ?? []
        } catch {
            print("CoreData Fetch Error: \(error)")
            return []
        }
    }
    
    
    func deleteAll<T: NSManagedObject>(_ type: T.Type) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: type))
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        do {
            try context.execute(deleteRequest)
            saveContext()
        } catch {
            print("CoreData Delete Error: \(error)")
        }
    }
}
