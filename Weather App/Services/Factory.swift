//
//  Factory.swift
//  Weather App
//
//  Created by Aleksandr Svetilov on 12.09.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//
import UIKit

protocol Factory {
    func makeHomeViewController() -> HomeViewController
    func makeHomeViewModel() -> HomeViewModel
    func makeHomeView() -> HomeView
    
    func makePlacesList() -> PlacesList
    func makeWeatherProvider() -> WeatherProvider
    func makeNetworkService() -> NetworkService
}

class DefaultFactory: Factory {
    func makeHomeViewController() -> HomeViewController {
        let model = makeHomeViewModel()
        let view = makeHomeView()
        return HomeViewController(viewModel: model, view: view)
    }
    
    func makeHomeViewModel() -> HomeViewModel {
        let places = makeMockPlacesList()
        let provider = makeWeatherProvider()
        return HomeViewModel(places: places, provider: provider)
    }
    
    func makeHomeView() -> HomeView {
        return HomeView()
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
    
    func makeMockPlacesList() -> PlacesList {
        let json = Bundle.main.path(forResource: "mockPlaces", ofType: "json")
        let url = URL(fileURLWithPath: json!)
        let data = try? Data(contentsOf: url)
        return try! JSONDecoder().decode(PlacesList.self, from: data!)
    }
    
    func makeWeatherProvider() -> WeatherProvider {
        let networkService = makeNetworkService()
        return MockWeather()
    }
    
    func makeNetworkService() -> NetworkService {
        return DefaultNetworkService()
    }
}
