//
// File:      WeatherEntity.swift
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

/// The component that handles data persistence and retrieval
class WeatherEntity {
  
  /// The module's reactive store
  weak var router: WeatherRouter?
  
  // If the user enters a city, save it here
  var savedCity: String?
  
  // @TODO: Cache the geocode object here
  var savedGeocode: String?
  
  /// Load data from persistence
  func load() {
    if let city = UserDefaults.standard.string(forKey: Weather.Key.savedCity) {
      self.savedCity = city
      self.router?.dispatch(
        action: .entityDidLoad,
        payload: Weather.Payload(city: city)
      )
    }
  }
  
  /// Persist data
  func save() {
    if let city = self.savedCity {
      UserDefaults.standard.set(city, forKey: Weather.Key.savedCity)
      UserDefaults.standard.synchronize()
    }
  }
  
}
