//
// File:      Weather+State.swift
// Package:   CityWeather
//
// Author:    Roderic Linguri <938388@cognizant.com>
// Copyright: © 2023 Roderic Linguri • All Rights Reserved
// License:   MIT
//
// Version:   0.1.2
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
    
    /// The city that we arecurrently fetching weather for
    let city: String?
    
    /// An array of errors
    let errors: [Weather.Error]
    
    /// Returns the initial "loading" state
    static var initial: Weather.State {
      return Weather.State(
        isViewConfigured: false,
        city: nil,
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
      errors: [Weather.Error]
    ) {
      self.timestamp = Date().timeIntervalSince1970
      self.isViewConfigured = isViewConfigured
      self.city = city
      self.errors = errors
    }
  }
  
}

extension Weather.State: Equatable {
  
  static func == (lhs: Weather.State, rhs: Weather.State) -> Bool {
    return lhs.isViewConfigured == rhs.isViewConfigured &&
    lhs.city == rhs.city &&
    lhs.errors == rhs.errors
  }
  
}
