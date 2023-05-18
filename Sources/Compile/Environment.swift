//
// File:      Environment.swift
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

/// A namespace to store environment variables
struct Environment {
  
  /// Temporarily sets a key in user-defaults so that we can test persistence methods
  static var isTesting: Bool {
    set {
      UserDefaults.standard.set(newValue, forKey: "IS_TESTING")
    }
    get {
      return UserDefaults.standard.bool(forKey: "IS_TESTING")
    }
  }
  
  /// NOTE: `export OPENWEATHERMAP_API_KEY=<actual-key>` must be in your ~/.bash_profile
  static let OPENWEATHERMAP_API_KEY = "$OPENWEATHERMAP_API_KEY"
  
}
