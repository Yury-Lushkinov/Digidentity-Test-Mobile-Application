//
//  DataStorage.swift
//  Digidentity-Test-Mobile-Application
//
//  Created by Yury Lushkinou on 05.06.2024.
//

import Foundation
import CoreData

protocol DataStorageProtocol {
    func fetchFirstItems(number: Int) async throws -> [Item]
    func fetchNextItems(after itemID: String, number: Int) async throws -> [Item]
    func write(items: [Item]) async throws
    func append(items: [Item]) async throws
}

class DataStorage {
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Digidentity_Test_Mobile_Application")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    private lazy var backgroundContext: NSManagedObjectContext = {
        persistentContainer.newBackgroundContext()
    }()
}


extension DataStorage: DataStorageProtocol {
    func fetchFirstItems(number: Int) async throws -> [Item] {
        let context = backgroundContext
        let items = try await context.perform {
            let fetchRequest = ItemEntity.fetchRequest()
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "order", ascending: false)]
            fetchRequest.fetchLimit = number
            let fetched = try context.fetch(fetchRequest)

            return fetched.map { Item(entity: $0) }
        }

        return items
    }

    func fetchNextItems(after itemID: String, number: Int) async throws -> [Item] {
        let context = backgroundContext
        let items = try await context.perform {
            let fetchPreviosItemRequest = ItemEntity.fetchRequest()
            fetchPreviosItemRequest.fetchLimit = 1
            fetchPreviosItemRequest.predicate = NSPredicate(format: "id == %@", itemID)
            let previousItem = try context.fetch(fetchPreviosItemRequest).first

            let fetchRequest = ItemEntity.fetchRequest()
            if let previousOrder = previousItem?.order {
                fetchRequest.predicate = NSPredicate(format: "order < %d", previousOrder)
            }
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "order", ascending: false)]
            fetchRequest.fetchLimit = number

            let fetched = try context.fetch(fetchRequest)

            return fetched.map { Item(entity: $0) }
        }

        return items
    }

    func write(items: [Item]) async throws  {
        try await backgroundContext.perform { [weak self] in
            guard let self = self else { return }

            let fetchRequest = ItemEntity.fetchRequest()
            let outdated = try self.backgroundContext.fetch(fetchRequest)
            outdated.forEach { entity in
                self.backgroundContext.delete(entity)
            }
            self.backgroundContext.insert(items: items)
            try self.backgroundContext.save()
        }
    }

    func append(items: [Item]) async throws {
        guard !items.isEmpty else { return }

        try await backgroundContext.perform { [weak self] in
            guard let self = self else { return }

            self.backgroundContext.insert(items: items)
            try self.backgroundContext.save()
        }
    }
}

private extension NSManagedObjectContext {
    func insert(items: [Item]) {
        items.forEach { item in
            let entity = ItemEntity(context: self)
            entity.id = item.id
            entity.text = item.text
            entity.image = item.image
            entity.confidence = item.confidence
            entity.order = item.text.extractItemNumber()
        }
    }
}

private extension String {
    func extractItemNumber() -> Int16 {
        let prefix = self.prefix { $0.isNumber }
        return Int16(prefix) ?? 0
    }
}
