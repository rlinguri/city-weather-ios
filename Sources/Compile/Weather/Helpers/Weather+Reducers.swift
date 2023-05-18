//
// File:      Weather+Reducers.swift
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
  
  /// Reduces action, payload and state to a new state with a sideEffect
  ///
  /// - Parameters:
  ///   - action: The action case
  ///   - payload: The payload that was dispatched
  ///   - state: The state at time of dispatch
  ///
  /// - Returns: A result object containing the new state and a sideEffect case
  static func reduce(
    action:  Weather.Action,
    payload: Weather.Payload,
    state: Weather.State
  ) -> Weather.Result {
    var updatedState: Weather.State
    var sideEffects: [Weather.SideEffect] = []
    
    switch action {
      case .didEncounterError:
        updatedState = state.update(withPayload: payload)
        sideEffects.append(.void)
      case .didConfigureView:
        updatedState = state.update(isViewConfigured: true)
        sideEffects.append(.void)
    }
    
    return Weather.Result(state: updatedState, sideEffects: sideEffects)
  }
  
}

/// We only allow reducers to produce a revised state
fileprivate extension Weather.State {
  
  /// Enables updating of state directly from the payload
  ///
  /// - Parameter payload: The payload that was dispatched
  ///
  /// - Returns: The updated state
  func update(
    withPayload payload: Weather.Payload
  ) -> Weather.State {
    var updatedErrors = self.errors
    if let error = payload.error {
      updatedErrors.append(error)
    }
    
    return Weather.State(
      isViewConfigured: self.isViewConfigured,
      errors: updatedErrors
    )
  }
  
  /// Enables updating of state properties
  ///
  /// - Parameters:
  ///   - isViewConfigured: Whether or not the view is configured
  ///   - error: A scene-error case
  ///
  /// - Returns: The updated state
  func update(
    isViewConfigured: Bool? = nil,
    error: Weather.Error? = nil
  ) -> Weather.State {
    var updatedErrors = self.errors
    if let error = error {
      updatedErrors.append(error)
    }
    
    return Weather.State(
      isViewConfigured: isViewConfigured ?? self.isViewConfigured,
      errors: updatedErrors
    )
  }
  
}
