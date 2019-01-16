//
//  DataManagerTests.swift
//  FlightsLocatorTests
//
//  Created by Marcos Garcia on 1/15/19.
//  Copyright © 2019 Marcos Garcia. All rights reserved.
//

import XCTest

class DataManagerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        let manager = DataManager()
        manager.resetData()
    }

    func test_retrieveData_ShouldNOTReturnInformation_When_ValueIsEmpty() {
        /// Given
        let manager = DataManager()
        
        /// When
        manager.resetData()
        let localInformation = manager.retrieveData()
        
        /// Then
        XCTAssertNil(localInformation, "Local information should be nil")
    }
    
    func test_retrieveData_ShouldReturnInformation_storeData_isExecuted() {
        /// Given
        let manager = DataManager()
        let mockInformation = FlightTests.getMockFligthDictionary()
        let arrayOfFlights = [Flight.init(mockInformation), Flight.init(mockInformation), Flight.init(mockInformation)]
        let mockLocalInformation = LocalInformation(airportCode: "SEA", flights: arrayOfFlights, time: Date())
        
        /// When
        manager.resetData()
        manager.storeData(mockLocalInformation)
        let localInformation = manager.retrieveData()
        
        /// Then
        XCTAssertNotNil(localInformation, "Local information should be nil")
        XCTAssertEqual(localInformation?.airportCode, "SEA", "Airport code should match")
        XCTAssertEqual(localInformation?.flights.count, 3, "Number of Flights should match")
        XCTAssertNotNil(localInformation?.time, "Time should not be nil")
    }
    

}
