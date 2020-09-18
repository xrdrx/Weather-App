//
//  CoreDataPlaces+CoreDataClass.swift
//  Weather App
//
//  Created by Aleksandr Svetilov on 16.09.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//
//

import Foundation
import CoreData

@objc(CoreDataPlaces)
public class CoreDataPlaces: NSManagedObject {
    
    var place: Place {
      get {
       return Place(id: Int(self.id), name: self.name, state: State(rawValue: self.state)!, country: Country(rawValue: self.country)!, coord: Coord(lon: self.lon, lat: self.lat))
       }
       set {
           self.id = Int32(newValue.id)
           self.name = newValue.name
           self.state = newValue.state.rawValue
           self.country = newValue.country.rawValue
           self.lat = newValue.coord.lat
           self.lon = newValue.coord.lon
       }
    }
}
