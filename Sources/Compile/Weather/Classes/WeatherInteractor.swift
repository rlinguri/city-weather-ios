//
// File:      WeatherInteractor.swift
// Package:   CityWeather
//
// Author:    Roderic Linguri <938388@cognizant.com>
// Copyright: © 2023 Roderic Linguri • All Rights Reserved
// License:   MIT
//
// Version:   0.1.3
// Requires:  iOS 15.6
//            Swift 5.0
//

import UIKit

/// The component that handles extra-module interaction
class WeatherInteractor {
  
  /// The module's reactive store
  weak var router: WeatherRouter?
  
  /// Retrieve the geocode for a given city, so that we can fetch weather for it
  ///
  /// - Parameter name: The name of the city
  func fetchGeocode(
    forCityName name: String
  ) {
    guard let url = URL(string: "https://api.openweathermap.org/geo/1.0/direct?q=\(name)&limit=5&appid=\(Environment.OPENWEATHERMAP_API_KEY)") else {
      self.router?.dispatch(
        action: .didEncounterError,
        payload: Weather.Payload(error: .unknown) // @TODO: Add .badURL case
      )
      return
    }
    
    URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
      guard let data else {
        self.router?.dispatch(
          action: .didEncounterError,
          payload: Weather.Payload(error: .unknown) // @TODO: Convert to Weather.Error
        )
        return
      }
      do {
        let geocodes = try JSONDecoder().decode([Weather.GeocodeResponse].self, from: data)
        self.router?.dispatch(
          action: .didReceiveGeocodes,
          payload: Weather.Payload(geocodes: geocodes)
        )
      } catch {
        self.router?.dispatch(
          action: .didEncounterError,
          payload: Weather.Payload(error: .unknown) // @TODO: Convert to Weather.Error.decoding
        )
      }
    }
    .resume()
  }
  
  /// Retrieve the geocode for a given city, so that we can fetch weather for it
  ///
  /// - Parameter name: The name of the city
  func fetchWeather(
    forGeocode geocode: Weather.GeocodeResponse
  ) {
    guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(geocode.lat)&lon=\(geocode.lon)&appid=\(Environment.OPENWEATHERMAP_API_KEY)") else {
      self.router?.dispatch(
        action: .didEncounterError,
        payload: Weather.Payload(error: .unknown) // @TODO: Add .badURL case
      )
      return
    }
    
    URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
      guard let data else {
        self.router?.dispatch(
          action: .didEncounterError,
          payload: Weather.Payload(error: .unknown) // @TODO: Convert to Weather.Error
        )
        return
      }
      do {
        let current = try JSONDecoder().decode(Weather.CurrentResponse.self, from: data)
        self.router?.dispatch(
          action: .didReceiveWeather,
          payload: Weather.Payload(current: current)
        )
      } catch {
        self.router?.dispatch(
          action: .didEncounterError,
          payload: Weather.Payload(error: .unknown) // @TODO: Convert to Weather.Error.decoding
        )
      }
    }
    .resume()
  }
  
  
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
