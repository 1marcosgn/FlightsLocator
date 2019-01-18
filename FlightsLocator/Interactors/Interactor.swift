//
//  Interactor.swift
//  FlightsLocator
//
//  Created by Marcos Garcia on 1/15/19.
//  Copyright © 2019 Marcos Garcia. All rights reserved.
//

import UIKit

class Interactor {
    /// Property to manage the available flights
    public var availableFlights: [Flight]?
    
    /// Retrive stored information if exists
    func retrieveLocalInformation() -> LocalInformation? {
        /// Get a manager instance
        let manager = DataManager()
        
        /// Retrieve the infomation with the manager
        guard let localInfo = manager.retrieveData() else {
            return nil
        }
        
        return localInfo
    }
    
    /// Method that uses the Service Implementer to gather flights from an external API
    public func requestFlightsFor(_ airportCode: String, completion: @escaping (Bool) -> ()) {
        let serviceImpl = ServicesImplementer.init()
        serviceImpl.fetchFlightsFor(airportCode) { (success) in
            if success {
                self.makeFlightsWith(serviceImpl.flights)
                self.saveInformationFor(airportCode)
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    /// Uses the Factory Class to create albums based on the response
    public func makeFlightsWith(_ content: [[String: Any]]?) {
        guard let flights = FlightsFactory.shared().makeFlights(flights: content) else {
            return
        }
        
        availableFlights = flights
    }
}

/// Interactor Extension to work with Persistent Data
internal extension Interactor {
    /// Calls the Data manger to store the information locally
    func saveInformationFor(_ airportCode: String) {
        if let flights = availableFlights {
            updateDataManagerWith(airportCode: airportCode, flights: flights, time: Date())
        }
    }
    
    /// Store information in the data manager
    func updateDataManagerWith(airportCode: String, flights: [Flight], time: Date) {
        /// Create a manager
        let manager = DataManager.init()
        
        /// Create a local information class
        let local = LocalInformation(airportCode: airportCode, flights: flights, time: time)
        
        /// Store local information using the manager
        manager.storeData(local)
    }
}
