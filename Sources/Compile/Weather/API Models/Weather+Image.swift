//
// File:      Weather+Image.swift
// Package:   CityWeather
//
// Author:    Roderic Linguri <linguri@digices.com>
// Copyright: © 2023 Digices LLC • All Rights Reserved
// License:   MIT
//
// Version:   0.1.1
// Requires:  iOS 15.6
//            Swift 5.0
//

import UIKit

extension Weather {
  
  struct ImageData: Codable {
    
    let code: String
    
    let data: Data
    
    var uiImage: UIImage? {
      return UIImage(data: self.data, scale: 2.0)
    }
    
  }
  
}
