//
//  WeatherProvider.swift
//  Weather App
//
//  Created by Aleksandr Svetilov on 13.09.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//
import UIKit

protocol WeatherProvider {
    func getWeatherForecast(place: Place, completion: @escaping (OpenWeatherResponse?, String?) -> Void)
    func getIconForWeather(weather: Weather, completion: @escaping (UIImage) -> Void)
}

class OpenWeather: WeatherProvider {
    
    private let baseUrl: URL = URL(string: "https://api.openweathermap.org/data/2.5/onecall")!
    private let exclude: String = "current,minutely,hourly"
    private let iconPrefix: String = "https://openweathermap.org/img/wn/"
    private let iconSuffix: String = "@2x.png"
    private let apiKey: String = openWeatherApiKey
    private let networkService: NetworkService
    private let decoder: JSONDecoder
    
    init(networkService: NetworkService, decoder: JSONDecoder) {
        self.networkService = networkService
        self.decoder = decoder
    }
    
    func getWeatherForecast(place: Place, completion: @escaping (OpenWeatherResponse?, String?) -> Void) {
        var weather: OpenWeatherResponse?
        var errorDescription: String?
        let queryItems = getQueryItemsFor(place: place, apiKey: apiKey)
        let url = getUrlWithQueryItems(url: baseUrl, queryItems: queryItems)
        networkService.getDataFromUrl(url) { (data, error) in
            if let data = data {
                do {
                    try weather = self.decoder.decode(OpenWeatherResponse.self, from: data)
                    completion(weather, nil)
                } catch {
                    errorDescription = "Error decoding weather data from JSON"
                }
            }
            if error != nil {
                errorDescription = "Weather request failed"
            }
            completion(weather, errorDescription)
        }
    }
    
    func getIconForWeather(weather: Weather, completion: @escaping (UIImage) -> Void) {
        let url = createIconUrl(weather: weather)
        networkService.getDataFromUrl(url) { (data, error) in
            if let image = UIImage(data: data!) {
                completion(image)
            }
            if error != nil {
                print("Image request failed")
            }
        }
    }
    
    private func createIconUrl(weather: Weather) -> URL {
        let icon = weather.icon
        return URL(string: iconPrefix + icon + iconSuffix)!
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
    
    let decoder = JSONDecoder()
    
    func getWeatherForecast (place: Place, completion: @escaping (OpenWeatherResponse?, String?) -> Void) {
        var weather: OpenWeatherResponse?
        var errorDescription: String?
        let json = Bundle.main.path(forResource: "mockJsonResponse", ofType: "json")
        let url = URL(fileURLWithPath: json!)
        let data = try? Data(contentsOf: url)
        if let data = data {
            do {
                try weather = self.decoder.decode(OpenWeatherResponse.self, from: data)
                completion(weather, nil)
            } catch {
                errorDescription = "Error decoding weather data from JSON"
            }
        }
        completion(weather, errorDescription)
    }
    
    func getIconForWeather(weather: Weather, completion: @escaping (UIImage) -> Void) {
        let image = UIImage()
        completion(image)
    }
}

