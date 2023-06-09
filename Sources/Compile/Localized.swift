//
// File:      Localized.swift
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

struct Localized {
  
  static var weatherNavigationTitle: String {
    return NSLocalizedString(
      "weather_navigation_title",
      value: "Weather",
      comment: "The title that should display in the navigation bar"
    )
  }
  
  static var enterCityTitle: String {
    return NSLocalizedString(
      "enter_city_title",
      value: "Enter a City Name",
      comment: "The title for the search field label"
    )
  }
  
  static var errorTitle: String {
    return NSLocalizedString(
      "error_title",
      value: "Error",
      comment: "The title for an error alert"
    )
  }
  
  static var okButtonActionTitle: String {
    NSLocalizedString(
      "ok_button_action_title",
      value: "OK",
      comment: "The title for the OK button"
    )
  }
  
}
