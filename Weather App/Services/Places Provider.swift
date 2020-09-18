//
//  Places Provider.swift
//  Weather App
//
//  Created by Aleksandr Svetilov on 16.09.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//

import Foundation
import CoreData

protocol PlacesProvider {
    func getPlacesCount() -> Int
    func getPlace(forRow: Int) -> Place
    func setFilteredPlaces(contains: String)
}

class CoreDataContainer: PlacesProvider {
    
    var container: NSPersistentContainer
    var context: NSManagedObjectContext
    var places: [CoreDataPlaces] = []
    var filteredPlaces: [CoreDataPlaces] = []
    
    let entityName = CDEntity.places
    
    init(container: NSPersistentContainer) {
        self.container = container
        self.context = container.viewContext
        setupPlacesLists()
    }
    
    private func setupPlacesLists() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        guard let places = try? context.fetch(fetchRequest) as? [CoreDataPlaces] else { return }
        self.places = places
        self.filteredPlaces = places
    }
    
    func getPlacesCount() -> Int {
        return filteredPlaces.count
    }
    
    func getPlace(forRow: Int) -> Place {
        return filteredPlaces[forRow].place
    }
    
    func setFilteredPlaces(contains: String) {
        if contains.isEmpty { self.filteredPlaces = places; return }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "name CONTAINS[cd] %@", contains)
        guard let filteredPlaces = try? context.fetch(fetchRequest) as? [CoreDataPlaces] else { return }
        self.filteredPlaces = filteredPlaces
    }
}
