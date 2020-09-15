//
//  Date Formatter.swift
//  Weather App
//
//  Created by Aleksandr Svetilov on 15.09.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//

import Foundation

protocol WeatherDetailedDateFormatter {
    func getStringDateFromTimestamp(_ timestamp: Int) -> String
}

class DetailedDateFormatter: DateFormatter, WeatherDetailedDateFormatter {
    
    override init() {
        super.init()
        self.dateStyle = .long
        self.timeStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getStringDateFromTimestamp(_ timestamp: Int) -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(timestamp))
        return self.string(from: date as Date)
    }
}
