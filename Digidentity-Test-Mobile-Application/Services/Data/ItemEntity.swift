//
//  ItemEntitiy+CoreDataClass.swift
//  Digidentity-Test-Mobile-Application
//
//  Created by Yury Lushkinou on 04.06.2024.
//
//

import Foundation
import CoreData

@objc(ItemEntity)
public class ItemEntity: NSManagedObject {

}

extension ItemEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemEntity> {
        return NSFetchRequest<ItemEntity>(entityName: "Item")
    }

    @NSManaged public var id: String?
    @NSManaged public var image: String?
    @NSManaged public var confidence: Double
    @NSManaged public var text: String?
    @NSManaged public var order: Int16

}

extension ItemEntity : Identifiable {

}

extension Item {
    init(entity: ItemEntity) {
        self.init(text: entity.text ?? "",
                  confidence: entity.confidence,
                  image: entity.image ?? "",
                  id: entity.id ?? "")
    }
}
