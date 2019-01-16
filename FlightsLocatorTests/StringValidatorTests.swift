//
//  StringValidatorTests.swift
//  FlightsLocatorTests
//
//  Created by Marcos Garcia on 1/16/19.
//  Copyright © 2019 Marcos Garcia. All rights reserved.
//

import XCTest

class StringValidatorTests: XCTestCase {

    func test_GivenA_OnlyLettersString_containsOnlyLetters_Should_Return_True() {
        /// Given
        let sut = "LAX"
        
        /// When
        let valid = StringValidator.containsOnlyLetters(sut)
        
        /// Then
        XCTAssertNotNil(sut, "Resutl should not be nil")
        XCTAssertTrue(valid, "Valid string that contains only letters should return 'true'")
    }
    
    func test_GivenA_StringWith_OnlyNumbers_containsOnlyLetters_Should_Return_False() {
        /// Given
        let sut = "123"
        
        /// When
        let valid = StringValidator.containsOnlyLetters(sut)
        
        /// Then
        XCTAssertNotNil(sut, "Resutl should not be nil")
        XCTAssertFalse(valid, "Valid string that contains only numbers should return 'false'")
    }
    
    func test_GivenA_StringWith_NumbersAndLtters_containsOnlyLetters_Should_Return_False() {
        /// Given
        let sut = "1B3"
        
        /// When
        let valid = StringValidator.containsOnlyLetters(sut)
        
        /// Then
        XCTAssertNotNil(sut, "Resutl should not be nil")
        XCTAssertFalse(valid, "Valid string that contains numbers and letters should return 'false'")
    }
    
    func test_GivenA_StringWith_LettersAndBlankSpaces_containsOnlyLetters_Should_Return_False() {
        /// Given
        let sut = "B A"
        
        /// When
        let valid = StringValidator.containsOnlyLetters(sut)
        
        /// Then
        XCTAssertNotNil(sut, "Resutl should not be nil")
        XCTAssertFalse(valid, "Valid string that contains letters and blank space should return 'false'")
    }
    
    func test_GivenA_StringWith_LettersAndSymbols_containsOnlyLetters_Should_Return_False() {
        /// Given
        let sut = "B*A"
        
        /// When
        let valid = StringValidator.containsOnlyLetters(sut)
        
        /// Then
        XCTAssertNotNil(sut, "Resutl should not be nil")
        XCTAssertFalse(valid, "Valid string that contains letters and symbols should return 'false'")
    }
    
    func test_GivenA_StringWith_Symbols_containsOnlyLetters_Should_Return_False() {
        /// Given
        let sut = "%&*"
        
        /// When
        let valid = StringValidator.containsOnlyLetters(sut)
        
        /// Then
        XCTAssertNotNil(sut, "Resutl should not be nil")
        XCTAssertFalse(valid, "Valid string that contains symbols should return 'false'")
    }
    
    func test_GivenA_StringWith_Symbols_containsOnlyLetters_Should_Return_False_() {
        /// Given
        let sut = "1"
        
        /// When
        let valid = StringValidator.containsOnlyLetters(sut)
        
        /// Then
        XCTAssertNotNil(sut, "Resutl should not be nil")
        XCTAssertFalse(valid, "Valid string that contains symbols should return 'false'")
    }
}
