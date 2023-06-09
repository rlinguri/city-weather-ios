//
// File:      Weather+Current.swift
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

import Foundation

extension Weather {
  
  struct CurrentConditions: Codable {
    
    let main: String
    
    let description: String
    
    let icon: String
    
  }
  
  struct CurrentData: Codable {
    
    let temp: Double
    
    let pressure: Double
    
    let humidity: Double
    
  }
  
  struct CurrentResponse: Codable {
    
    let weather: [CurrentConditions]
    
    let main: CurrentData
    
  }
  
}
