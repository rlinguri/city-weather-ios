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
  
  // If we receive a geocode, save it here
  var savedGeocode: Weather.GeocodeResponse?
  
  /// Load data from persistence
  func load() {
    if let city = UserDefaults.standard.string(forKey: Weather.Key.savedCity) {
      self.savedCity = city
      self.router?.dispatch(
        action: .entityDidLoad,
        payload: Weather.Payload(city: city)
      )
    }
    
    if let geocodeData = UserDefaults.standard.data(forKey: Weather.Key.savedGeocode) {
      do {
        let geocode = try JSONDecoder().decode(Weather.GeocodeResponse.self, from: geocodeData)
        self.savedGeocode = geocode
      } catch {
        print("no data saved for geocode")
      }
    }
    
    var geocodes = [Weather.GeocodeResponse]()
    
    if let savedGeocode = self.savedGeocode {
      geocodes.append(savedGeocode)
    }
    
    self.router?.dispatch(
      action: .entityDidLoad,
      payload: Weather.Payload(
        city: self.savedCity,
        geocodes: geocodes
      )
    )
  }
  
  /// Persist data
  func save() {
    if let city = self.savedCity {
      UserDefaults.standard.set(city, forKey: Weather.Key.savedCity)
      UserDefaults.standard.synchronize()
    }
  }
  
}
