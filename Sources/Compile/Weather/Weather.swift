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

import UIKit

/// The module's namespace
struct Weather {
  
  // MARK: - Typealiases
  
  typealias Router = WeatherRouter
  
  // MARK: - Types
  
  enum Key {
    
    static let savedCity: String = "SAVED_CITY"
    
    static let savedGeocode: String = "SAVED_GEOCODE"
    
    static let cachedImages: String = "CACHED_IMAGES"
    
  }
  
  enum Label {
    
    static var dispatch: String {
      return "\(Weather.moduleName).dispatch"
    }
    
  }
  
  // MARK: - Properties
  
  /// The name of this module as a string
  static let moduleName = "Weather"
  
  // MARK: - Factory
  
  /// Factory method for creating a controller with all dependencies
  ///
  /// - Returns: The module's viewController
  static func createViewController() -> WeatherViewController {
    let entity = WeatherEntity()
    let presenter = WeatherPresenter(entity: entity)
    let interactor = WeatherInteractor()
    let router = WeatherRouter(interactor: interactor)
    let controller = WeatherViewController(
      presenter: presenter,
      router: router
    )
    controller.router.viewController = controller
    controller.router.interactor.router = router
    controller.router.entity = entity
    controller.presenter.entity.router = router
    return controller
  }
  
}
