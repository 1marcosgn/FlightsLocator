//
//  ServicesImplementerTests.swift
//  FlightsLocatorTests
//
//  Created by Marcos Garcia on 1/15/19.
//  Copyright © 2019 Marcos Garcia. All rights reserved.
//

import XCTest

class ServicesImplementerTests: XCTestCase {

    func test_fetchFlights_ShouldFetchAvailable_Fllights_From_RemoteSource() {
        /// Given
        let sut = ServicesImplementer.init()
        let expectation = XCTestExpectation(description: "Call should be successfully completed and flights updated")
        
        /// When
        sut.fetchFlightsFor("SEA") { (success) in
            if success {
                expectation.fulfill()
            }
        }
        
        /// Then
        wait(for: [expectation], timeout: 10.0)
        XCTAssertNotNil(sut.flights, "After sync is completed this should not be nil")
    }
    
    func test_Flights_ShouldNOTExist_If_NO_FetchOperation_HasBeenExecuted() {
        /// Given
        let sut:ServicesImplementer?
        
        /// When
        sut = ServicesImplementer.init()
        
        /// Then
        XCTAssertNil(sut?.flights, "Flights should be nil because no fetch operation has been executed")
    }
    
    func test_getConfigTime_ShouldReturn_Valid_TimeConfigurationObject() {
        /// Given
        let serviceImpl = ServicesImplementer.init()
        
        /// When
        let sut = serviceImpl.getConfigTime()
        
        /// Then
        XCTAssertNotNil(sut, "Time Configurator object should not be nil")
        XCTAssertNotNil(sut?.minutesBefore, "Minutes before should not be nil")
        XCTAssertNotNil(sut?.minutesAfter, "Minutes after should not be nil")
        
        XCTAssertEqual(sut?.minutesBefore, "10", "Minutes should match configuration")
        XCTAssertEqual(sut?.minutesAfter, "60", "Minutes should match configuration")
    }

}
