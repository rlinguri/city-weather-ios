//
// File:      Weather+Error.swift
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

extension Weather {
  
  /// An enumeration of possible errors that can occur
  enum Error {
    
    case unknown
    case missingDependency
    case missingParameter
    
  }
  
}

extension Weather.Error: Error {
  
}
