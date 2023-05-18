//
// File:      Weather+SideEffect.swift
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
  
  /// Encapsulation of methods to execute on the Store based on an event
  enum SideEffect {
    
    case void
    case postNotification
    
    /// Execute the side effect on the router
    ///
    /// - Parameter router: The module's reactive store
    /// - Parameter event: The event that triggered the sideEffect
    /// - Parameter completion: The block to call when execution is complete
    func execute(
      router: WeatherRouter?,
      event: Weather.Event,
      completion: (() -> Void)? = nil
    ) {
      switch self {
        case .void:
          break
        case .postNotification:
          router?.interactor.postNotification(event: event)
      }
      
      completion?()
    }
    
  }
  
}
