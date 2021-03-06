//
//  DetailViewModel.swift
//  Weather App
//
//  Created by Aleksandr Svetilov on 15.09.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//

class DetailViewModel {
    
    var selectedDay = Observable<Day>(nil)
    var dateFormatter: WeatherDateFormatter
    
    init(formatter: WeatherDateFormatter) {
        self.dateFormatter = formatter
    }
}

