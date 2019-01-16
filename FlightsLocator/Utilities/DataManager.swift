//
//  DataManager.swift
//  FlightsLocator
//
//  Created by Marcos Garcia on 1/15/19.
//  Copyright © 2019 Marcos Garcia. All rights reserved.
//

import UIKit

/// Class to interact with NSUserDefaults and Store/Fetch information
final internal class DataManager {
    /// Stores information locally Using NSUserDefaults
    func storeData(_ localInformation: LocalInformation) {
        UserDefaults.standard.save(customObject: localInformation, inKey: "FlightsLocator-Locally-Stored-Information")
    }
    
    /// Retrieves information Using NSUserDefaults
    func retrieveData() -> LocalInformation? {
        return UserDefaults.standard.retrieve(object: LocalInformation.self, fromKey: "FlightsLocator-Locally-Stored-Information")
    }
    
    /// Method to remove locally store data
    func resetData() {
        UserDefaults.standard.removeObject(forKey: "FlightsLocator-Locally-Stored-Information")
    }
}

/// Extension to persist Custom Objects
public extension UserDefaults {
    
    func save<T:Encodable>(customObject object: T, inKey key: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(object) {
            self.set(encoded, forKey: key)
        }
    }
    
    func retrieve<T:Decodable>(object type:T.Type, fromKey key: String) -> T? {
        if let data = self.data(forKey: key) {
            let decoder = JSONDecoder()
            if let object = try? decoder.decode(type, from: data) {
                return object
            }else {
                print("Couldnt decode object")
                return nil
            }
        }else {
            print("Couldnt find key")
            return nil
        }
    }
    
}
