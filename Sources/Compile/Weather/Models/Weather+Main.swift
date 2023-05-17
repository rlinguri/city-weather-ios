//
// File:      Weather+Main.swift
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

import Foundation

extension Weather {
  
  /// The object that contains the data we are interested in
  struct Main: Decodable {
    
    /// The temperature in Kelvin
    let temp: Double
    
    /// The Kelvin temp property converted to Fahrenheit
    var fahrenheitTemperature: Double {
      return 1.8 * (self.temp - 273) + 32
    }

  }
  
}
