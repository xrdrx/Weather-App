//
//  WeatherProvider.swift
//  Weather App
//
//  Created by Aleksandr Svetilov on 13.09.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//
import UIKit

protocol WeatherProvider {
    func getWeatherForecast(place: Place, numberOfDays: Int, completion: @escaping (OpenWeatherResponse) -> Void)
}

class OpenWeather: WeatherProvider {
    
    private let baseUrl: URL = URL(string: "https://api.openweathermap.org/data/2.5/forecast/daily")!
    private let apiKey: String = "2a7a49fcb2a6956fef6bf2b30d147603"
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func getWeatherForecast(place: Place, numberOfDays: Int, completion: @escaping (OpenWeatherResponse) -> Void) {
        let queryItems = getQueryItemsFor(place: place, numberOfDays: numberOfDays, apiKey: apiKey)
        let url = getUrlWithQueryItems(url: baseUrl, queryItems: queryItems)
        print(url)
        networkService.getDataFromUrl(url) { (data) in
            if let weather = try? JSONDecoder().decode(OpenWeatherResponse.self, from: data) {
                completion(weather)
            }
        }
    }
    
    private func getQueryItemsFor(place: Place, numberOfDays: Int, apiKey: String) -> [URLQueryItem] {
        let items = [URLQueryItem(name: "id", value: String(place.id)),
                     URLQueryItem(name: "cnt", value: String(numberOfDays)),
                     URLQueryItem(name: "appid", value: apiKey),
                     URLQueryItem(name: "units", value: "metric")]
        return items
    }
    
    private func getUrlWithQueryItems(url: URL, queryItems: [URLQueryItem]) -> URL {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = queryItems
        return components!.url!
    }
    
}

class MockWeather: WeatherProvider {
    func getWeatherForecast(place: Place, numberOfDays: Int, completion: @escaping (OpenWeatherResponse) -> Void) {
        let json = Bundle.main.path(forResource: "mockJsonResponse", ofType: "json")
        let url = URL(fileURLWithPath: json!)
        let data = try? Data(contentsOf: url)
        if let decoded = try? JSONDecoder().decode(OpenWeatherResponse.self, from: data!) {
            completion(decoded)
        }
    }
}
