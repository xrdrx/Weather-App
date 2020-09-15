//
//  WeatherProvider.swift
//  Weather App
//
//  Created by Aleksandr Svetilov on 13.09.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//
import UIKit

protocol WeatherProvider {
    func getWeatherForecast(place: Place, completion: @escaping (OpenWeatherResponse) -> Void)
}

class OpenWeather: WeatherProvider {
    
    private let baseUrl: URL = URL(string: "https://api.openweathermap.org/data/2.5/onecall")!
    private let exclude: String = "current,minutely,hourly"
    private let apiKey: String = openWeatherApiKey
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func getWeatherForecast(place: Place, completion: @escaping (OpenWeatherResponse) -> Void) {
        let queryItems = getQueryItemsFor(place: place, apiKey: apiKey)
        let url = getUrlWithQueryItems(url: baseUrl, queryItems: queryItems)
        print(url)
        networkService.getDataFromUrl(url) { (data) in
            if let weather = try? JSONDecoder().decode(OpenWeatherResponse.self, from: data) {
                completion(weather)
            }
        }
    }
    
    private func getQueryItemsFor(place: Place, apiKey: String) -> [URLQueryItem] {
        let items = [URLQueryItem(name: "lat", value: String(place.coord.lat)),
                     URLQueryItem(name: "lon", value: String(place.coord.lon)),
                     URLQueryItem(name: "exclude", value: exclude),
                     URLQueryItem(name: "units", value: "metric"),
                     URLQueryItem(name: "appid", value: apiKey)]
        return items
    }
    
    private func getUrlWithQueryItems(url: URL, queryItems: [URLQueryItem]) -> URL {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = queryItems
        return components!.url!
    }
    
}

class MockWeather: WeatherProvider {
    func getWeatherForecast(place: Place, completion: @escaping (OpenWeatherResponse) -> Void) {
        let json = Bundle.main.path(forResource: "mockJsonResponse", ofType: "json")
        let url = URL(fileURLWithPath: json!)
        let data = try? Data(contentsOf: url)
        if let decoded = try? JSONDecoder().decode(OpenWeatherResponse.self, from: data!) {
            print("success")
            completion(decoded)
        } else {
            print("decoding failed")
        }
    }
}
