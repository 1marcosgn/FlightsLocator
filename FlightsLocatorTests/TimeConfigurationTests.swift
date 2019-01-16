//
//  TimeConfigurationTests.swift
//  FlightsLocatorTests
//
//  Created by Marcos Garcia on 1/15/19.
//  Copyright © 2019 Marcos Garcia. All rights reserved.
//

import XCTest

class TimeConfigurationTests: XCTestCase {

    func test_GivenAValid_String_getDateFrom_ShouldReturnAValidDate() {
        /// Given
        let mockDateString = "2019-01-15T10:27:00"
        
        /// When
        let resultDate = TimeConfiguration.getDateFrom(mockDateString)
        
        /// Then
        XCTAssertNotNil(resultDate, "Result Date should not be nil")
    }
    
    func test_GivenAValid_Date_getHMStringFrom_ShouldReturnAValidString() {
        /// Given
        let mockDateString = "2019-01-15T10:27:00"
        let mockResultDate = TimeConfiguration.getDateFrom(mockDateString)
        
        /// When
        let resultHMDateString = TimeConfiguration.getHMStringFrom(mockResultDate)

        /// Then
        XCTAssertNotNil(resultHMDateString, "Result Date should not be nil")
        XCTAssertEqual(resultHMDateString, "10:27", "Date should match")
    }
    
    func test_GivenAnArraryOfFlights_orderBasedOnDate_ShouldReturnADescending_SortedArray() {
        /// Given
        let mockFligth1 = Flight(number: "1", originCode: "SEA", arrivalTime: TimeConfiguration.getDateFrom("2019-01-15T12:27:00"))
        let mockFligth2 = Flight(number: "2", originCode: "LAX", arrivalTime: TimeConfiguration.getDateFrom("2019-01-15T09:27:00"))
        let mockFligth3 = Flight(number: "3", originCode: "JFK", arrivalTime: TimeConfiguration.getDateFrom("2019-01-15T10:22:00"))
        let mockFligth4 = Flight(number: "4", originCode: "MEX", arrivalTime: TimeConfiguration.getDateFrom("2019-01-15T10:15:00"))
        
        let sut = [mockFligth1, mockFligth2, mockFligth3, mockFligth4]
        
        /// When
        let sortedArray = TimeConfiguration.orderBasedOnDate(sut)
        
        /// Then
        XCTAssertNotNil(sortedArray, "Sorted array should not be nil")
        XCTAssertEqual(sortedArray.first?.number, "2", "First object expected to be '2'")
        XCTAssertEqual(sortedArray.last?.number, "1", "Last object expected to be '1'")
    }
    
    func test_Given2Dates_getTimeDifferenceInMinutesBetween_ShouldReturnValidNumberOfMinutes() {
        /// Given
        let mockDate1 = TimeConfiguration.getDateFrom("2019-01-15T12:27:00")
        let mockDate2 = TimeConfiguration.getDateFrom("2019-01-15T12:37:00")
        
        /// When
        let sut = TimeConfiguration.getTimeDifferenceInMinutesBetween(dateA: mockDate1!, dateB: mockDate2!)
        
        /// Then
        XCTAssertNotNil(sut, "Time difference should not be nil")
        XCTAssertEqual(sut, 10, "Difference in minutes between both dates should be 10")
    }
    
    func test_Given2Dates_With_Negative_Difference_getTimeDifferenceInMinutesBetween_ShouldReturnValidNumberOfMinutes() {
        /// Given
        let mockDate1 = TimeConfiguration.getDateFrom("2019-01-15T12:37:00")
        let mockDate2 = TimeConfiguration.getDateFrom("2019-01-15T11:37:00")
        
        /// When
        let sut = TimeConfiguration.getTimeDifferenceInMinutesBetween(dateA: mockDate1!, dateB: mockDate2!)
        
        /// Then
        XCTAssertNotNil(sut, "Time difference should not be nil")
        XCTAssertEqual(sut, 0, "Difference in minutes between both dates should be 0")
    }
    
    func test_Given2Dates_With_NO_Difference_getTimeDifferenceInMinutesBetween_ShouldReturnValidNumberOfMinutes() {
        /// Given
        let mockDate1 = TimeConfiguration.getDateFrom("2019-01-15T11:37:00")
        let mockDate2 = TimeConfiguration.getDateFrom("2019-01-15T11:37:00")
        
        /// When
        let sut = TimeConfiguration.getTimeDifferenceInMinutesBetween(dateA: mockDate1!, dateB: mockDate2!)
        
        /// Then
        XCTAssertNotNil(sut, "Time difference should not be nil")
        XCTAssertEqual(sut, 0, "Difference in minutes between both dates should be 0")
    }
    
    func test_Given2Dates_With_DAYS_Difference_getTimeDifferenceInMinutesBetween_ShouldReturnValidNumberOfMinutes() {
        /// Given
        let mockDate1 = TimeConfiguration.getDateFrom("2019-01-15T11:37:00")
        let mockDate2 = TimeConfiguration.getDateFrom("2019-01-16T11:37:00")
        
        /// When
        let sut = TimeConfiguration.getTimeDifferenceInMinutesBetween(dateA: mockDate1!, dateB: mockDate2!)
        
        /// Then
        XCTAssertNotNil(sut, "Time difference should not be nil")
        XCTAssertEqual(sut, 1440, "Difference in minutes between both dates should be 0")
    }
    
}
