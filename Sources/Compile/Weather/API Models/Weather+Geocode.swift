//
// File:      Weather+Geocode.swift
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
  
  // Represents the data required to make a geocoding request
  struct GeocodeRequest: Codable {
    
    let city: String
    
    let country: String
    
  }
  
  // Represents an array element in the api.openweathermap.org/geo/1.0/direct API response
  struct GeocodeResponse: Codable {
    
    let name: String
    
    let lat: Double
    
    let lon: Double
    
    let country: String
    
    let state: String
    
  }
  
}
