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
  enum SideEffect: String {
    
    case void
    case setLoadingTrue
    case setLoadingFalse
    case updateView
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
      print("execute \(self)")
      if router?.viewController == nil {
        print("no viewController")
      } else if router?.viewController?.presenter == nil {
        print("no presenter")
      }
      
      switch self {
        case .void:
          break
        case .setLoadingTrue:
          router?.viewController?.presenter.loading = true
        case .setLoadingFalse:
          router?.viewController?.presenter.loading = false
        case .updateView:
          router?.viewController?.updateView()
        case .postNotification:
          router?.interactor.postNotification(event: event)
      }
      
      completion?()
    }
    
  }
  
}
