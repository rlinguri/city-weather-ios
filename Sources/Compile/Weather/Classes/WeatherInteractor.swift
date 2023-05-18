//
// File:      WeatherInteractor.swift
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

/// The component that handles extra-module interaction
class WeatherInteractor {
  
  /// The module's reactive store
  weak var router: WeatherRouter?
  
  /// Posts a notification to NotificationCenter
  ///
  /// - Parameter event: The event to post a notification for
  func postNotification(event: Weather.Event) {
    let notification = Notification(
      name: event.action.notificationName,
      object: event.state,
      userInfo: [
        "state": event.state
      ]
    )
    
    NotificationCenter.default.post(notification)
  }
  
}
