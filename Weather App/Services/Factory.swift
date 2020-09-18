//
//  Factory.swift
//  Weather App
//
//  Created by Aleksandr Svetilov on 12.09.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//
import UIKit
import CoreData

protocol Factory {
    func makeHomeViewController() -> HomeViewController
    func makeHomeViewModel() -> HomeViewModel
    func makeHomeView() -> HomeView
    
    func makeDetailViewController() -> DetailViewController
    func makeDetailViewModel() -> DetailViewModel
    func makeDetailView() -> DetailView
    
    func makePlacesList() -> PlacesList
    func makeWeatherProvider() -> WeatherProvider
    func makeNetworkService() -> NetworkService
    func makeDetailedDateFormatter() -> WeatherDateFormatter
    func makeHomeDateFormatter() -> WeatherDateFormatter
    func makeCoreDataContainer() -> PlacesProvider
}

class DefaultFactory: Factory {
    
    func makeHomeViewController() -> HomeViewController {
        let model = makeHomeViewModel()
        let view = makeHomeView()
        return HomeViewController(viewModel: model, view: view)
    }
    
    func makeHomeViewModel() -> HomeViewModel {
        let provider = makeWeatherProvider()
        let container = getPersistantContainer()
        let formatter = makeHomeDateFormatter()
        let places = makeCoreDataContainer()
        return HomeViewModel(provider: provider, container: container!, formatter: formatter, places: places)
    }
    
    func makeHomeView() -> HomeView {
        return HomeView()
    }
    
    func makeDetailViewController() -> DetailViewController {
        let view = makeDetailView()
        let model = makeDetailViewModel()
        return DetailViewController(view: view, viewModel: model)
    }
    
    func makeDetailViewModel() -> DetailViewModel {
        let formatter = makeDetailedDateFormatter()
        return DetailViewModel(formatter: formatter)
    }
    
    func makeDetailView() -> DetailView {
        return DetailView()
    }
    
    func makePlacesList() -> PlacesList {
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
    
    func getPersistantContainer() -> NSPersistentContainer? {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let container = appDelegate.persistentContainer
        return container
    }
    
    func makeMockPlacesList() -> PlacesList {
        let json = Bundle.main.path(forResource: "mockPlaces", ofType: "json")
        let url = URL(fileURLWithPath: json!)
        let data = try? Data(contentsOf: url)
        return try! JSONDecoder().decode(PlacesList.self, from: data!)
    }
    
    func makeWeatherProvider() -> WeatherProvider {
        let networkService = makeNetworkService()
        return OpenWeather(networkService: networkService)
    }
    
    func makeNetworkService() -> NetworkService {
        return DefaultNetworkService()
    }
    
    func makeDetailedDateFormatter() -> WeatherDateFormatter {
        return DetailedDateFormatter()
    }
    
    func makeHomeDateFormatter() -> WeatherDateFormatter {
        return HomeDateFormatter()
    }
    
    func makeCoreDataContainer() -> PlacesProvider {
        let container = getPersistantContainer()
        return CoreDataContainer(container: container!)
    }
}
