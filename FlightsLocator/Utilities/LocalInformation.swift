//
//  LocalInformation.swift
//  FlightsLocator
//
//  Created by Marcos Garcia on 1/15/19.
//  Copyright © 2019 Marcos Garcia. All rights reserved.
//

import UIKit

class LocalInformation: Codable, LocalInformationProtocol {
    var airportCode: String = ""
    var flights: [Flight] = [Flight]()
    var time: Date = Date()
    
    init(airportCode: String, flights: [Flight], time: Date) {
        self.airportCode = airportCode
        self.flights = flights
        self.time = time
    }
}
