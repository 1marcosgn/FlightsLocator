//
//  StringValidator.swift
//  FlightsLocator
//
//  Created by Marcos Garcia on 1/16/19.
//  Copyright © 2019 Marcos Garcia. All rights reserved.
//

import UIKit

public class StringValidator {
    
    class func containsOnlyLetters(_ string: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: ".*[^A-Za-z].*", options: [])
            if regex.firstMatch(in: string, options: [], range: NSMakeRange(0, string.count)) != nil {
                return false
            } else {
                return true
            }
        }
        catch {
            return false
        }
    }

}
