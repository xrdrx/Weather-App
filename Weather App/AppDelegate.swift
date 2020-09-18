//
//  AppDelegate.swift
//  Weather App
//
//  Created by Aleksandr Svetilov on 12.09.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let defaults = UserDefaults.standard
        let isPreloaded = defaults.bool(forKey: "isPreloaded")
        if !isPreloaded {
            preloadPersistentData()
            defaults.set(true, forKey: "isPreloaded")
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Weather_App")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    private func preloadPersistentData() {
        removeData()
        let places = makePlacesList()
        let context = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: CDEntity.places, in: context)!
        var counter = 1
        for place in places {
            let placeInContainer = CoreDataPlaces(entity: entity, insertInto: context)
            placeInContainer.setValue(place.id, forKey: "id")
            placeInContainer.setValue(place.country.rawValue, forKey: "country")
            placeInContainer.setValue(place.name, forKey: "name")
            placeInContainer.setValue(place.state.rawValue, forKey: "state")
            placeInContainer.setValue(place.coord.lat, forKey: "lat")
            placeInContainer.setValue(place.coord.lon, forKey: "lon")
            if counter % 10000 == 0 { print("Added entry number \(counter)") }
            counter += 1
        }
        saveContext()
        getRecordsCount(entity: CDEntity.places, context: context)
    }
    
    private func removeData () {
        let managedObjectContext = self.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CDEntity.places)
        
        guard let places = try? managedObjectContext.fetch(fetchRequest) as? [NSManagedObject] else { return }
        for place in places {
            managedObjectContext.delete(place)
        }
    }
    
    private func getRecordsCount(entity: String, context: NSManagedObjectContext) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        do {
            let count = try context.count(for: fetchRequest)
            print("\(count) entries")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func makePlacesList() -> PlacesList {
        guard let asset = NSDataAsset(name: "city.list", bundle: Bundle.main) else {
            print("Failed to get asset")
            return PlacesList([])
        }
        guard let places = try? JSONDecoder().decode(PlacesList.self, from: asset.data) else {
            print("Failed to decode asset")
            return PlacesList([])
        }
        return places
    }

}

