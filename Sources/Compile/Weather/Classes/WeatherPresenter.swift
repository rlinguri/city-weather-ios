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
  
  var loading: Bool = true
  
  /// The default space to the edge of the view and between subviews
  let spacing: CGFloat = 18.0
  
  /// The default height for a text field
  /// @TODO: Make this a computed property based on traitCollection
  let textFieldHeight: CGFloat = 36.0
  
  /// The title for the navigation view
  let navigationTitle = Localized.weatherNavigationTitle

  /// The label for the search field
  let searchFieldLabel = Localized.enterCityTitle
  
  /// Wehen we receive weather data, set it here before updating the view
  var weatherDataText: String?
  
  /// Initialize the presenter with an entity
  ///
  /// - Parameter entity: The component that handles data persistence and retrieval
  init(entity: WeatherEntity) {
    self.entity = entity
  }
  
}
