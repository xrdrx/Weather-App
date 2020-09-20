//
//  HomeViewModel.swift
//  Weather App
//
//  Created by Aleksandr Svetilov on 12.09.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//
import UIKit
import CoreData

class HomeViewModel: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var placesProvider: PlacesProvider!
    var weatherProvider: WeatherProvider!
    var dateFormatter: WeatherDateFormatter!
    var weatherList: OpenWeatherResponse?
    var selectedPlace: Place?
    var selectedDay = Observable<Day>()
    var error = Observable<String>()
    
    var coreDataContainer: NSPersistentContainer!
    
    init(provider: WeatherProvider? = nil,
         container: NSPersistentContainer? = nil,
         formatter: WeatherDateFormatter? = nil,
         places: PlacesProvider? = nil) {
        
        self.placesProvider = places
        self.dateFormatter = formatter
        self.coreDataContainer = container
        self.weatherProvider = provider
        super.init()
    }
    
    func setFilteredPlaces(filterString: String) {
        placesProvider.setFilteredPlaces(beginsWith: filterString)
    }
    
    func getPlacesCount() -> Int {
        return placesProvider.getPlacesCount()
    }
    
    func getPlace(forRow: Int) -> Place {
        return placesProvider.getPlace(forRow: forRow)
    }
    
    func getPlaceDescription(_ place: Place) -> String {
        var description = "\(place.name)"
        if place.state != .empty { description += ", \(place.state.rawValue)" }
        if place.country != .empty { description += ", \(place.country.rawValue)" }
        return description
    }
    
    func getWeatherForecast(completion: @escaping () -> Void) {
        weatherProvider.getWeatherForecast(place: selectedPlace!) { (weather, error) in
            if let weather = weather {
                self.weatherList = weather
                completion()
            }
            if let error = error {
                self.error.value = error
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherList?.daily?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DayCell", for: indexPath)
        guard let weatherForDay = weatherList?.daily?[indexPath.row] else { return cell }
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.image = UIImage(named: "placeholder")
        weatherProvider.getIconForWeather(weather: weatherForDay.weather[0]) { (image) in
            DispatchQueue.main.async {
                cell.imageView?.image = image
            }
        }
        let formattedDate = dateFormatter.getStringDateFromTimestamp(weatherForDay.dt)
        cell.textLabel?.text = "\(formattedDate)  \(weatherForDay.temp.day)  \(weatherForDay.weather[0].main)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let day = weatherList?.daily?[indexPath.row] else { return }
        tableView.deselectRow(at: indexPath, animated: false)
        selectedDay.value = day
    }
}
