//
//  FlightTests.swift
//  FlightsLocatorTests
//
//  Created by Marcos Garcia on 1/15/19.
//  Copyright © 2019 Marcos Garcia. All rights reserved.
//

import XCTest

class FlightTests: XCTestCase {
    
    func test_GivenAFlightClass_ThatConformsFlightInformationProtocol_FlightClassShouldHaveValidData() {
        /// Given
        let mockInformation = FlightTests.getMockFligthDictionary()
        
        /// When
        let sut = Flight.init(mockInformation)
        
        /// Then
        XCTAssertNotNil(sut, "Object created should not be nil")
        XCTAssertNotNil(sut.number, "Flight number should not be nil")
        XCTAssertNotNil(sut.originCode, "Origin code should not be nil")
        XCTAssertNotNil(sut.arrivalTime, "Arrival time should not be nil")
        
        XCTAssertEqual(sut.number, "1259", "Flight number should match")
        XCTAssertEqual(sut.originCode, "SFO", "Origin Code should match")
        XCTAssertEqual(sut.arrivalTime, "2019-01-15T10:25:00", "Arrival Time number should match")
    }
}

extension FlightTests {
    ///Returns a mock flight dictionary for testing
    class func getMockFligthDictionary() -> [String: Any] {
        var mockDictionary = [String: Any]()
        
        mockDictionary["FltId"] = "1259"
        mockDictionary["Orig"] = "SFO"
        mockDictionary["SchedArrTime"] = "2019-01-15T10:25:00"
        
        return mockDictionary
    }
}
