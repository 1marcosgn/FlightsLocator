//
//  LocalInformationProtocol.swift
//  FlightsLocator
//
//  Created by Marcos Garcia on 1/15/19.
//  Copyright © 2019 Marcos Garcia. All rights reserved.
//

import UIKit

/// This protocol handles the persistent information for the project
protocol LocalInformationProtocol {
    /// The code of the airport that was searched
    var airportCode: String { get set}
    
    /// The array of flights associated to the last executed search
    var flights: [Flight] { get set }
    
    /// The exact date when the search was executed
    var time: Date { get set }
}
