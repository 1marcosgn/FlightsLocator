//
//  TimeConfiguration.swift
//  FlightsLocator
//
//  Created by Marcos Garcia on 1/15/19.
//  Copyright © 2019 Marcos Garcia. All rights reserved.
//

import UIKit

// Class to manage the configuration constraints
class TimeConfiguration {
    let minutesBefore: String?
    let minutesAfter: String?
    
    init(minutesBefore: String, minutesAfter: String) {
        self.minutesBefore = minutesBefore
        self.minutesAfter = minutesAfter
    }
}

/// Extension to manage the Date Formatter
extension TimeConfiguration {
    /// Transforms a string like '2019-01-15T10:27:00' into -> Date
    class func getDateFrom(_ string: String) -> Date? {
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        guard let date = dateFormatter.date(from: string) else {
            return nil
        }
        
        return date
    }
    
    /// Transforms a Date into a string like -> '10:27' (Local Time)
    class func getHMStringFrom(_ date: Date?) -> String? {
        guard let date_ = date else {
            return nil
        }
        
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale
        
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.locale = tempLocale
        
        var localTimeZoneAbbreviation: String { return TimeZone.current.abbreviation() ?? "" }
        dateFormatter.timeZone = TimeZone(abbreviation: localTimeZoneAbbreviation)
        
        let dateString = dateFormatter.string(from: date_)
        return dateString
    }
    
    /// Returns an array of Flights sorted based on the arrival date with soonest at the top
    class func orderBasedOnDate(_ elements:[Flight]) -> [Flight] {
        //Create an array of the `Dates` for each Flight Object
        let flightDates: [Date] = elements.map { $0.arrivalTime! }
        
        //Combine the array of `Dates` and the array of `Flight` into an array of tuples
        let flightTuples = zip(elements, flightDates)
        
        //Sort the array of tuples and then map back to an array of type [Flight]
        let sortedFlightObjects = flightTuples.sorted { $0.1 < $1.1}.map {$0.0}
        
        return sortedFlightObjects
    }
    
    /// Method to get minutes difference between 2 dates, 'dateB' recommended to be higer to properly compare
    class func getTimeDifferenceInMinutesBetween(dateA: Date, dateB: Date) -> Int {
        let dayHourMinuteSecond: Set<Calendar.Component> = [.minute]
        let difference = NSCalendar.current.dateComponents(dayHourMinuteSecond, from: dateA, to: dateB);
        
        let timeDiff = difference.minute ?? 0
        
        if timeDiff > 0 {
            return timeDiff
        } else {
            return 0
        }
    }
}
