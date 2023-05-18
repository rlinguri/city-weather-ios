//
// File:      Weather+Action.swift
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
  
  /// The constrained set of actions that can uccur in the module
  enum Action: String {
    
    case didConfigureView
    case entityDidLoad
    case didEnterCity
    case didReceiveGeocodes
    case didReceiveWeather
    case didReceiveImage
    case didEncounterError
    
    /// The action converted to a `Notification.Name` instance
    var notificationName: Notification.Name {
      return Notification.Name(
        "\(Weather.moduleName)\(self.rawValue.capitalized)"
      )
    }
    
  }
  
}
