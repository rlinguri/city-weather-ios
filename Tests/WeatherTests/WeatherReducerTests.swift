//
// File:      WeatherReducerTests.swift
// Package:   CityWeather
//
// Author:    Roderic Linguri <linguri@digices.com>
// Copyright: © 2023 Digices LLC • All Rights Reserved
// License:   MIT
//
// Version:   0.1.2
// Requires:  iOS 15.6
//            Swift 5.0
//

import XCTest
import UIKit
@testable import CityWeather

final class WeatherReducerTests: XCTestCase {
  
  /// Runs before each test method
  override func setUpWithError() throws {
    Environment.isTesting = true
  }
  
  /// Runs after each test method
  override func tearDownWithError() throws {
    Environment.isTesting = false
  }
  
  /// Verifies that if an error is encountered, it gets added to state
  func test_encounterError() throws {
    
    // Arrange
    
    let expected = Weather.Result(
      state: Weather.State(
        isViewConfigured: true,
        errors: [Weather.Error.unknown]
      ),
      sideEffects: [.void]
    )
    
    // Act
    
    let actual = Weather.reduce(
      action: .didEncounterError,
      payload: Weather.Payload(
        error: Weather.Error.unknown
      ),
      state: Weather.State(
        isViewConfigured: true,
        errors: []
      )
    )
    
    // Assert
    
    let message = "Expected: \(expected), actual: \(actual)"
    
    XCTAssertEqual(
      actual,
      expected,
      message
    )
    
  }
  
}
