//
// File:      Weather+Response.swift
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
  
  /// The root API response object
  struct Response: Decodable {
    
    /// A nested object that contains the data we are interested in
    let main: Weather.Main
    
  }
  
  
}
