//
// File:      Environment.swift
// Package:   CityWeather
//
// Author:    Roderic Linguri <938388@cognizant.com>
// Copyright: © 2023 Roderic Linguri • All Rights Reserved
// License:   MIT
//
// Version:   0.1.1
// Requires:  iOS 15.6
//            Swift 5.0
//

import Foundation

/// A namespace to store environment variables
struct Environment {
  
  /// NOTE: `export OPENWEATHERMAP_API_KEY=<actual-key>` must be in your ~/.bash_profile
  static let OPENWEATHERMAP_API_KEY = "$OPENWEATHERMAP_API_KEY"
  
}
