//
// File:      Weather+Payload.swift
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

extension Weather {
  
  /// An object that can be dispatched
  struct Payload {
    
    let city: String?
    
    let geocodes: [Weather.GeocodeResponse]?
    
    let current: Weather.CurrentResponse?
    
    /// The error that occurred
    let error: Weather.Error?
    
    /// Initialize a payload object
    ///
    /// - Parameter error: An error to dispatch
    init(
      city: String? = nil,
      geocodes: [Weather.GeocodeResponse]? = nil,
      current: Weather.CurrentResponse? = nil,
      error: Weather.Error? = nil
    ) {
      self.city = city
      self.geocodes = geocodes
      self.current = current
      self.error = error
    }
    
  }
  
}
