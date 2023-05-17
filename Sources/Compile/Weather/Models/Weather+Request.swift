//
// File:      Weather+Request.swift
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
  
  struct Request: Codable {
    
    let name: String
    
    let state: String
    
    let country: String
  }
  
}
