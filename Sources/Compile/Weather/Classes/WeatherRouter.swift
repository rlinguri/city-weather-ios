//
// File:      WeatherRouter.swift
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

/// A reactive store
class WeatherRouter {

  /// The component that handles extra-module interaction
  let interactor: WeatherInteractor

  /// The module's view controller
  weak var viewController: WeatherViewController?

  /// The component that handles data persistence and retrieval
  weak var entity: WeatherEntity?

  /// The module's current state
  var state: Weather.State = Weather.State.initial
  
  /// Initialize the router
  init(interactor: WeatherInteractor) {
    self.interactor = interactor
  }
  
  /// Dispatch an action to the module
  ///
  /// - Parameters:
  ///   - action: The action case
  ///   - payload: The parameters required to udate state
  ///
  ///   - completion: The block to call when complete
  func dispatch(
    action: Weather.Action,
    payload: Weather.Payload,
    completion: (() -> Void)? = nil
  ) {
    DispatchQueue(
      label: Weather.Label.dispatch,
      qos: .userInitiated
    ).async { [weak self] in
      if let self {
        // Set up an event
        let event: Weather.Event = Weather.Event(
          action: action,
          state: self.state
        )
        
        Weather.Middleware.atDispatch(event: event)
        
        // Reduce state into a new state and a sideEffect
        let reduced = Weather.reduce(
          action: action,
          payload: payload,
          state: self.state
        )
        
        // Update state property
        self.state = reduced.state
        
        Weather.Middleware.preExecute(event: event.update(state: reduced.state))
        
        // Execute the sideEffects
        for sideEffect in reduced.sideEffects {
					sideEffect.execute(router: self, event: event) {
						Weather.Middleware.postExecute(
							event: event.update(state: self.state)
						)
					}
        }
      }
      
      // Notify caller of completion
      completion?()
    }
  }
  
}
