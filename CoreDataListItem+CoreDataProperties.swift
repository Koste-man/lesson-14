//
//  CoreDataListItem+CoreDataProperties.swift
//  
//
//  Created by Konstantin Moskvichev on 26.02.2021.
//
//

import Foundation
import CoreData


extension CoreDataListItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataListItem> {
        return NSFetchRequest<CoreDataListItem>(entityName: "CoreDataListItem")
    }

    @NSManaged public var name: String?

}
