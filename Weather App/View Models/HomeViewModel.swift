//
//  HomeViewModel.swift
//  Weather App
//
//  Created by Aleksandr Svetilov on 12.09.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//
import UIKit

class HomeViewModel: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    let places: PlacesList
    var filteredPlaces: PlacesList
    var weatherProvider: WeatherProvider
    var weatherList: OpenWeatherResponse?
    var selectedPlace: Place = Place(id: 0, name: "", state: .empty, country: .empty, coord: Coord(lon: 0, lat: 0))
    
    init(places: PlacesList, provider: WeatherProvider) {
        self.places = places
        self.weatherProvider = provider
        self.filteredPlaces = places
    }
    
    func filterPlacesBy(_ string: String) {
        if string.isEmpty {
            filteredPlaces = places
            return
        }
        filteredPlaces = places.filter { $0.name.range(of: string, options: .caseInsensitive) != nil }
    }
    
    func getWeatherForecast(completion: @escaping () -> Void) {
        weatherProvider.getWeatherForecast(place: selectedPlace, numberOfDays: 7) { (weather) in
            self.weatherList = weather
            completion()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherList?.list.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DayCell", for: indexPath)
        guard let weatherForDay = weatherList?.list[indexPath.row] else { return cell }
        let date = NSDate(timeIntervalSince1970: TimeInterval(weatherForDay.dt))
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        let formattedDate = formatter.string(from: date as Date)
        cell.textLabel?.text = "\(formattedDate)  \(weatherForDay.temp.day)  \(weatherForDay.weather[0].main)"
        return cell
    }
}
