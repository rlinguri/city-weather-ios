//
// File:      Weather+Event.swift
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
  
  /// An action and the resulting state at a given time
  struct Event {
    
    /// The time of the event
    let timestamp: TimeInterval
    
    /// The action that produced the event
    let action: Weather.Action
    
    /// The state at the time of the event
    let state: Weather.State
    
    /// Initialize the event object
    ///
    /// - Parameters:
    ///   - action: The action that produced the event
    ///   - state: The state at the time of the event
    init(
      action: Weather.Action,
      state: Weather.State
    ) {
      self.timestamp = Date().timeIntervalSince1970
      self.action = action
      self.state = state
    }
    
    /// Update an event with a new state
    ///
    /// - Parameter state: The updated state
    ///
    /// - Returns: The updated event
    func update(state: Weather.State) -> Weather.Event {
      return Weather.Event(action: self.action, state: state)
    }
    
  }
  
}
