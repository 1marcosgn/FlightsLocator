//
//  Flight.swift
//  FlightsLocator
//
//  Created by Marcos Garcia on 1/15/19.
//  Copyright © 2019 Marcos Garcia. All rights reserved.
//

import UIKit

class Flight: Codable, FlightInformationProtocol {
    var number: String
    var originCode: String
    var arrivalTime: Date?
    
    init(_ information:[String: Any]) {
        self.number = information["FltId"] as? String ?? ""
        self.originCode = information["Orig"] as? String ?? ""
        self.arrivalTime = formatArrivalTime(information)
    }
    
    /// Initializer for testing
    init(number: String, originCode: String, arrivalTime: Date?) {
        self.number = number
        self.originCode = originCode
        self.arrivalTime = arrivalTime
    }
}

/// Extension to Use TimeConfiguration and transfrom the Arrival string into a valid date
private extension Flight {
    func formatArrivalTime(_ arrivalTime: [String: Any]) -> Date? {
        guard let arrival = arrivalTime["SchedArrTime"] as? String else {
            return nil
        }
        guard let validDate = TimeConfiguration.getDateFrom(arrival) else {
            return nil
        }
        return validDate
    }
}
