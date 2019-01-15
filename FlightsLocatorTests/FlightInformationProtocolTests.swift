//
//  FlightInformationProtocolTests.swift
//  FlightsLocatorTests
//
//  Created by Marcos Garcia on 1/15/19.
//  Copyright © 2019 Marcos Garcia. All rights reserved.
//

import XCTest

class FlightInformationProtocolTests: XCTestCase {

    func test_GivenAClass_ThatConformsInformationProtocol_ClassShouldHaveValidData() {
        /// Given
        let mockFlight = "1259"
        let mockOrigin = "SFO"
        let mockArrival = "2019-01-15T10:25:00"
        
        /// When
        let sut = MockFlight(number: mockFlight, originCode: mockOrigin, arrivalTime: mockArrival)
        
        /// Then
        XCTAssertNotNil(sut, "Object created should not be nil")
        XCTAssertNotNil(sut.number, "Flight number should not be nil")
        XCTAssertNotNil(sut.originCode, "Origin code should not be nil")
        XCTAssertNotNil(sut.arrivalTime, "Arrival time should not be nil")
        
        XCTAssertEqual(sut.number, mockFlight, "Flight number should match")
        XCTAssertEqual(sut.originCode, mockOrigin, "Origin Code should match")
        XCTAssertEqual(sut.arrivalTime, mockArrival, "Arrival Time number should match")
    }
}

class MockFlight: FlightInformationProtocol {
    var number: String
    var originCode: String
    var arrivalTime: String
    
    init(number: String, originCode: String, arrivalTime: String) {
        self.number = number
        self.originCode = originCode
        self.arrivalTime = arrivalTime
    }
}
