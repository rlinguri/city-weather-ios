//
// File:      Weather+State.swift
// Package:   CityWeather
//
// Author:    Roderic Linguri <938388@cognizant.com>
// Copyright: © 2023 Roderic Linguri • All Rights Reserved
// License:   MIT
//
// Version:   0.1.3
// Requires:  iOS 15.6
//            Swift 5.0
//

import UIKit

import UIKit

extension Weather {
  
  /// The captured state of the module
  struct State {
    
    /// The time the state was created
    let timestamp: TimeInterval
    
    /// Whether or not view setup tasks are complete
    let isViewConfigured: Bool
    
    /// The city that we are currently fetching weather for
    let city: String?
    
    /// The array of geocodes for a given city
    let geocodes: [GeocodeResponse]?
    
    /// The current weather conditions and data response
    let current: Weather.CurrentResponse?
    
    /// An array of errors
    let errors: [Weather.Error]
    
    /// Returns the initial "loading" state
    static var initial: Weather.State {
      return Weather.State(
        isViewConfigured: false,
        city: nil,
        geocodes: nil,
        current: nil,
        errors: []
      )
    }
    
    /// Initialize state
    ///
    /// - Parameters:
    ///   - isViewConfigured: Whether or not view setup tasks are complete
    ///   - errors: An array of errors
    init(
      isViewConfigured: Bool,
      city: String?,
      geocodes: [Weather.GeocodeResponse]?,
      current: Weather.CurrentResponse?,
      errors: [Weather.Error]
    ) {
      self.timestamp = Date().timeIntervalSince1970
      self.isViewConfigured = isViewConfigured
      self.city = city
      self.geocodes = geocodes
      self.current = current
      self.errors = errors
    }
  }
  
}

extension Weather.State: Equatable {
  
  /// Used in tests!
  /// // @TODO: Make georequest and current weather equatable to add into this
  static func == (lhs: Weather.State, rhs: Weather.State) -> Bool {
    return lhs.isViewConfigured == rhs.isViewConfigured &&
    lhs.city == rhs.city &&
    lhs.errors == rhs.errors
  }
  
}
