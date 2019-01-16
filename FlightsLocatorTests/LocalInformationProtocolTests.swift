//
//  LocalInformationProtocolTests.swift
//  FlightsLocatorTests
//
//  Created by Marcos Garcia on 1/15/19.
//  Copyright © 2019 Marcos Garcia. All rights reserved.
//

import XCTest

class LocalInformationProtocolTests: XCTestCase {

    func test_Class_ThatConformsLocalInformationProtocol_ShouldContainValidData() {
        /// Given
        let mockInformation = FlightTests.getMockFligthDictionary()
        let arrayOfFlights = [Flight.init(mockInformation), Flight.init(mockInformation), Flight.init(mockInformation)]
        
        /// When
        let sut = MockLocalInfo(airportCode: "SEA", flights: arrayOfFlights, time: Date())
        
        /// Then
        XCTAssertNotNil(sut, "Local Information class should not be nil")
        XCTAssertEqual(sut.airportCode, "SEA", "Airport code should match")
        XCTAssertEqual(sut.flights.count, 3, "Flights stored should be 3")
        XCTAssertNotNil(sut.time, "The time should not be nil")
    }
}

public class MockLocalInfo: LocalInformationProtocol {
    var airportCode: String
    var flights: [Flight]
    var time: Date
    
    init(airportCode: String, flights: [Flight], time: Date) {
        self.airportCode = airportCode
        self.flights = flights
        self.time = time
    }
}
