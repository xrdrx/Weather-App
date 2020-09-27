//
//  Date Formatter.swift
//  Weather App
//
//  Created by Aleksandr Svetilov on 15.09.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//

import Foundation

protocol WeatherDateFormatter {
    func getStringDateFromTimestamp(_ timestamp: Int) -> String
    func getStringDayFromTimestamp(_ timestamp: Int) -> String
}

class DetailedDateFormatter: DateFormatter, WeatherDateFormatter {
    
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
    
    func getStringDayFromTimestamp(_ timestamp: Int) -> String {
        return ""
    }
}

class HomeDateFormatter: DateFormatter, WeatherDateFormatter {
    
    override init() {
        super.init()
        self.dateStyle = .medium
        self.timeStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getStringDateFromTimestamp(_ timestamp: Int) -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(timestamp))
        return self.string(from: date as Date)
    }
    
    func getStringDayFromTimestamp(_ timestamp: Int) -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(timestamp))
        if timestampIsToday(timestamp) { return "Today" }
        if timestampIsTomorrow(timestamp) { return "Tomorrow" }
        self.setLocalizedDateFormatFromTemplate("EEEE")
        let day = self.string(from: date as Date)
        self.dateStyle = .medium
        return day
    }
    
    private func timestampIsToday(_ timestamp: Int) -> Bool {
        let date = dateFromTimestamp(timestamp)
        return Calendar.current.isDateInToday(date as Date)
    }
    
    private func timestampIsTomorrow(_ timestamp: Int) -> Bool {
        let date = dateFromTimestamp(timestamp)
        return Calendar.current.isDateInTomorrow(date as Date)
    }
    
    private func dateFromTimestamp(_ timestamp: Int) -> NSDate {
        return NSDate(timeIntervalSince1970: TimeInterval(timestamp))
    }
}
