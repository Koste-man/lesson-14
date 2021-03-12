//
//  CoreDataListItem+CoreDataProperties.swift
//  lesson 14
//
//  Created by Konstantin Moskvichev on 12.03.2021.
//
//

import Foundation
import CoreData


extension CoreDataListItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataListItem> {
        return NSFetchRequest<CoreDataListItem>(entityName: "CoreDataListItem")
    }

    @NSManaged public var done: Bool
    @NSManaged public var name: String?

}

extension CoreDataListItem : Identifiable {

}
