//
//  ServicesImplementer.swift
//  FlightsLocator
//
//  Created by Marcos Garcia on 1/15/19.
//  Copyright © 2019 Marcos Garcia. All rights reserved.
//

import UIKit

/// Struct to manage the endpoints of the App
private struct Services {
    static let scheme = "https"
    static let host = "api.qa.alaskaair.net"
    static let pathLeft = "/aag/1/dayoftravel/airports/"
    static let pathRight = "/flights/flightInfo"
    static let minutesBefore = "minutesBefore"
    static let minutesAfter = "minutesAfter"
    static let request_key = "Ocp-Apim-Subscription-Key"
    static let request_value = "0a570f0bf03d46089b7829d7304831e4"
}

class ServicesImplementer {
    /// Stores temporary the downloaded albums
    public var flights: [[String: Any]]?
    internal var airportCode: String = ""
    
    /// Call Web Service to fetch data .. this is an async task
    public func fetchFlightsFor(_ airportCode_: String, completion: @escaping (Bool) -> ()) {
        airportCode = airportCode_
        downloadFileFromURL { (success) -> Void in
            completion(success)
        }
    }
}

/// Extension to download and parse flights information
internal extension ServicesImplementer {
    /**
     Simple method to download a JSON from external URL
     - parameter completion: The response of the opetarion
     */
    func downloadFileFromURL(completion: @escaping (Bool) -> ()) {
        DispatchQueue.global().async {
            
            var components = URLComponents()
            components.scheme = Services.scheme
            components.host = Services.host
            components.path = Services.pathLeft + self.airportCode + Services.pathRight
            components.queryItems = [
                URLQueryItem(name: Services.minutesBefore, value: self.getConfigTime()?.minutesBefore),
                URLQueryItem(name: Services.minutesAfter, value: self.getConfigTime()?.minutesAfter)
            ]
            
            guard let endpointURL = components.url else {
                return
            }
            
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            let request = NSMutableURLRequest(url: endpointURL)
            request.httpMethod = "GET"
            request.addValue(Services.request_value, forHTTPHeaderField: Services.request_key)
            
            // TODO: UNCOMMENT THIS SECTION --- THE API IS NOT RESPONDING ---
            /*
            let dataTask = session.dataTask(with: request as URLRequest) {
                ( data, response, error) in
                if let httpResponse = response as? HTTPURLResponse {
                    switch(httpResponse.statusCode) {
                    case 200:
                        guard
                            let data = data,
                            let json = (try? JSONSerialization.jsonObject(with: data)) as? [[String: Any]]
                            else {
                                print("Error", error ?? "")
                                return
                        }
                        self.setUpFlightsArrayWith(json)
                        completion(true)
                    default:
                        print("GET request not successful HTTP status code: \(httpResponse.statusCode)")
                        completion(false)
                    }
                } else {
                    print("Error: Not a valid HTTP response")
                    completion(false)
                }
            }
            dataTask.resume()
 */
            // TODO: REMOVE THIS TEMPORARY CODE ADDED DUE AN ISSUE WITH THE API
            //::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
            self.fetchDataFromLocalFile()
            completion(true)
            //::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
        }
    }
    
    /**
     Updates the 'flights' dictionary with the content of the response
     - parameter content: The external dictionary with valid content
     */
    func setUpFlightsArrayWith(_ content: [[String: Any]]?) {
        guard let theContent = content else {
            return
        }
        flights = theContent
    }
    
    func getConfigTime() -> TimeConfiguration? {
        var nsDictionary: NSDictionary?
        if let path = Bundle.main.path(forResource: "TimeConfiguration", ofType: "plist") {
            nsDictionary = NSDictionary(contentsOfFile: path)
        }
        
        guard let dictionary = nsDictionary as? [String: String] else {
            return nil
        }
        
        guard let minutesBefore = dictionary["minutesBefore"],
            let minutesAfter = dictionary["minutesAfter"] else {
                return nil
        }
        
        return TimeConfiguration(minutesBefore: minutesBefore, minutesAfter: minutesAfter)
    }
}

/// Extension to get the information from a local file  -- For testing --
internal extension ServicesImplementer {
    func fetchDataFromLocalFile() {
        if let path = Bundle.main.path(forResource: "MockFlights", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? [[String: Any]] {
                    self.setUpFlightsArrayWith(jsonResult)
                }
            } catch {
                print("Error fetching the local file")
            }
        }
    }
}
