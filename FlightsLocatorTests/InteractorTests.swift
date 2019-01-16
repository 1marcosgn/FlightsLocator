//
//  InteractorTests.swift
//  FlightsLocatorTests
//
//  Created by Marcos Garcia on 1/15/19.
//  Copyright © 2019 Marcos Garcia. All rights reserved.
//

import XCTest

class InteractorTests: XCTestCase {
    
    /// – The Agent can enter the three letter airport code they want arrival information for.
    func test_Interactor_GivenValidInputData_InteractorShouldReturn_Valid_ArrivalInformation() {
        /// Given
        let sut = Interactor.init()
        let expectation = XCTestExpectation(description: "Call should be successfully completed")
        
        /// When
        /// Agent can enter the three letter airport code
        sut.requestFlightsFor("SEA") { (success) in
            if success {
                expectation.fulfill()
            }
        }
        
        /// Then
        wait(for: [expectation], timeout: 10.0)
        XCTAssertNotNil(sut.availableFlights, "Arrival information should be displayed for the Agent")
    }
    
    /// The app should remember the airport that was previously selected.
    func test_GivenASuccesfulServiceCall_TheAppShould_Store_Selected_Information() {
        /// Given
        let sut = Interactor.init()
        let expectation = XCTestExpectation(description: "Call should be successfully completed")
        
        let manager = DataManager()
        manager.resetData()
        
        /// When
        sut.requestFlightsFor("SEA") { (success) in
            if success {
                expectation.fulfill()
            }
        }
        
        /// Then
        wait(for: [expectation], timeout: 10.0)
        let localInformation = sut.retrieveLocalInformation()
        
        XCTAssertNotNil(localInformation, "App should remember the airport that was previously selected")
        XCTAssertEqual(localInformation?.airportCode, "SEA", "Airport code should match previous search")
        XCTAssertNotNil(localInformation?.flights, "Flight should not be nil")
    }
}
