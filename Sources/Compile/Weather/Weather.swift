//
// File:      Weather.swift
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

import Foundation

struct Weather {
  
  /// Facilitates access to weather interactor in namespaced style
  typealias Interactor = WeatherInteractor
  
  /// Facilitates access to weather presenter in namespaced style
  typealias Presenter = WeatherPresenter
  
  /// Facilitates access to weather view controller in namespaced style
  typealias ViewController = WeatherViewController
  
  /// Factory method for creating the weather view controller instance
  ///
  /// - Returns: The weatherview controller with dependencies injected
  static func createViewController() -> WeatherViewController {
    let interactor = WeatherInteractor()
    let presenter = WeatherPresenter(interactor: interactor)
    let viewController = WeatherViewController(presenter: presenter)
    presenter.viewController = viewController
    return viewController
  }
}
