//
// File:      Weather+Result.swift
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
  
  /// A reducer's return type
  struct Result {
    
    /// The resulting state
    let state: Weather.State
    
    /// An array of side effects to execute
    let sideEffects: [Weather.SideEffect]

  }
  
}

extension Weather.Result: Equatable {
    
}
