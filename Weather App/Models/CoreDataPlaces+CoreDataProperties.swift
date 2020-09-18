//
//  CoreDataPlaces+CoreDataProperties.swift
//  Weather App
//
//  Created by Aleksandr Svetilov on 16.09.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//
//

import Foundation
import CoreData


extension CoreDataPlaces {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<CoreDataPlaces> {
        return NSFetchRequest<CoreDataPlaces>(entityName: "CoreDataPlaces")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String
    @NSManaged public var country: String
    @NSManaged public var state: String
    @NSManaged public var lat: Double
    @NSManaged public var lon: Double

}
