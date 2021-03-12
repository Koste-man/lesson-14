//
//  Weather+CoreDataProperties.swift
//  lesson 14
//
//  Created by Konstantin Moskvichev on 12.03.2021.
//
//

import Foundation
import CoreData


extension Weather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Weather> {
        return NSFetchRequest<Weather>(entityName: "Weather")
    }

    @NSManaged public var temp: Double

}

extension Weather : Identifiable {

}
