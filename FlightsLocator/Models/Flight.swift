//
//  Flight.swift
//  FlightsLocator
//
//  Created by Marcos Garcia on 1/15/19.
//  Copyright © 2019 Marcos Garcia. All rights reserved.
//

import UIKit

class Flight: FlightInformationProtocol {
    var number: String
    var originCode: String
    var arrivalTime: String
    
    init(_ information:[String: Any]) {
        self.number = information["FltId"] as? String ?? ""
        self.originCode = information["Orig"] as? String ?? ""
        self.arrivalTime = information["SchedArrTime"] as? String ?? ""
    }
}
