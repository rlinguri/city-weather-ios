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
  
  var imageData: [Weather.ImageData] = []
    
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
    
    if let savedImageData = UserDefaults.standard.data(forKey: Weather.Key.cachedImages) {
      do {
        let images = try JSONDecoder().decode([Weather.ImageData].self, from: savedImageData)
        self.imageData = images
      } catch {
        print("no image data")
      }
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
    }
    
    if let geocode = self.savedGeocode {
      UserDefaults.standard.set(geocode, forKey: Weather.Key.savedGeocode)
    }
    
    do {
      let encoded = try JSONEncoder().encode(self.imageData)
      UserDefaults.standard.set(encoded, forKey: Weather.Key.cachedImages)
    } catch {
      print("Can't encode image data, we'll have to fetch them every time")
    }
    
    UserDefaults.standard.synchronize()
  }
  
  /// Extracts an image out of the array if we have it
  ///
  /// - Parameter code: The three-digit code from openweather
  ///
  /// - Returns: An optional `UIImage`
  func imageForCode(code: String) -> UIImage? {
    if let imageData = self.imageData.first(where: { $0.code == code }) {
      return imageData.uiImage
    }
    return nil
  }
  
}
