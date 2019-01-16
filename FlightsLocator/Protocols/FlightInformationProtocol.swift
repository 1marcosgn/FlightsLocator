//
//  FlightInformationProtocol.swift
//  FlightsLocator
//
//  Created by Marcos Garcia on 1/15/19.
//  Copyright © 2019 Marcos Garcia. All rights reserved.
//

import UIKit

/// This protocol handles the information related to each flight
public protocol FlightInformationProtocol {
    /// the flight number
    var number: String { get set }

    /// three-letter origin airport code
    var originCode: String { get set }
    
    /// arrival time of the flight, in local time for the user.
    var arrivalTime: Date? { get set}
}
