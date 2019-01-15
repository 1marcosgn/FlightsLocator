//
//  FlightsFactoryTests.swift
//  FlightsLocatorTests
//
//  Created by Marcos Garcia on 1/15/19.
//  Copyright © 2019 Marcos Garcia. All rights reserved.
//

import XCTest

class FlightsFactoryTests: XCTestCase {

    func test_GivenAFactoryInstance_WhenValidInformationProvidedToCreateFlights_FactoryShouldMakeValidFlights() {
        /// Given
        let sut = FlightsFactory.shared()
        let flightsArray = [FlightTests.getMockFligthDictionary(), FlightTests.getMockFligthDictionary()]
        
        /// When
        let flights = sut.makeFlights(flights: flightsArray)
        let flight = flights?.first
        
        /// Then
        XCTAssertNotNil(sut, "Factory object should not be nil at this point")
        XCTAssertNotNil(flight, "Created flight should not be nil")
        
        XCTAssertNotNil(flight?.number, "The flight number should not be nil")
        XCTAssertNotNil(flight?.originCode, "Origin code should not be nil")
        XCTAssertNotNil(flight?.arrivalTime, "Arrival should not be nil")
        
        XCTAssertEqual(flight?.number, "1259", "Flight number should match")
        XCTAssertEqual(flight?.originCode, "SFO", "Origin Code should match")
        XCTAssertEqual(flight?.arrivalTime, "2019-01-15T10:25:00", "Arrival Time number should match")
    }
}
