//
// File:      WeatherPresenter.swift
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

/// The module's view model
class WeatherPresenter {
  
  /// The component that handles data persistence and retrieval
  let entity: WeatherEntity
  
  /// Initialize the presenter with an entity
  ///
  /// - Parameter entity: The component that handles data persistence and retrieval
  init(entity: WeatherEntity) {
    self.entity = entity
  }
  
}
