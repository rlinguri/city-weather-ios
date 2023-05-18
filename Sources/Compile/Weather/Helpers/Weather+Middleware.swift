//
// File:      Weather+Middleware.swift
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
  
  struct Middleware {
    
    /// Capture action and state at dispatch
    ///
    /// - Parameters:
    ///   - event: The event object
    ///   - completion: A block to run when complete
    static func atDispatch(
      event: Weather.Event,
      completion: (() -> Void)? = nil
    ) {
      // track
      
      completion?()
    }
    
    /// Capture action and state before executing a sideEffect
    ///
    /// - Parameters:
    ///   - event: The event object
    ///   - completion: A block to run when complete
    static func preExecute(
      event: Weather.Event,
      completion: (() -> Void)? = nil
    ) {
      // track
      
      completion?()
    }
    
    /// Capture action and state after executing a sideEffect
    ///
    /// - Parameters:
    ///   - event: The event object
    ///   - completion: A block to run when complete
    static func postExecute(
      event: Weather.Event,
      completion: (() -> Void)? = nil
    ) {
      // track
      
      completion?()
    }
    
  }
  
}
