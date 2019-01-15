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
