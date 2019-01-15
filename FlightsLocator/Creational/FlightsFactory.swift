//
//  FlightsFactory.swift
//  FlightsLocator
//
//  Created by Marcos Garcia on 1/15/19.
//  Copyright © 2019 Marcos Garcia. All rights reserved.
//

import UIKit

class FlightsFactory {
    
    private static var sharedFlightsFactory = FlightsFactory()
    
    /// Single instance of Flights Factory
    class func shared() -> FlightsFactory {
        return sharedFlightsFactory
    }
    
    /**
     Creates and returns Flights based on a Dictionary with the flights information
     - parameter flights: Array of Dictionaries with information required to build a Flight
     - returns: Array of Flights
     */
    public func makeFlights(flights: [[String: Any]]?) -> [Flight]? {
        var flightsArray = [Flight]()
        guard let flights_ = flights else {
            return nil
        }
        
        for flight in flights_ {
            let flightObject = Flight.init(flight)
            flightsArray.append(flightObject)
        }
        return flightsArray
    }

}
