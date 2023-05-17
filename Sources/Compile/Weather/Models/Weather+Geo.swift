//
// File:      Weather+Geo.swift
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
  
  struct GeoDirectResponse: Decodable {
    
    let name: String
    
    let lat: Double
    
    let lon: Double
        
  }
  
}
