//
// File:      WeatherInteractor.swift
// Package:   CityWeather
//
// Author:    Roderic Linguri <938388@cognizant.com>
// Copyright: © 2023 Roderic Linguri • All Rights Reserved
// License:   MIT
//
// Version:   0.1.4
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
    guard let query = name.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) else { return }
    
    guard let url = URL(string: "https://api.openweathermap.org/geo/1.0/direct?q=\(query)&limit=5&appid=\(Environment.OPENWEATHERMAP_API_KEY)") else {
      self.router?.dispatch(
        action: .didEncounterError,
        payload: Weather.Payload(error: .badURL)
      )
      return
    }
    
    URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
      guard let data else {
        self.router?.dispatch(
          action: .didEncounterError,
          payload: Weather.Payload(error: .networkError)
        )
        return
      }
      do {
        let geocodes = try JSONDecoder().decode([Weather.GeocodeResponse].self, from: data)
        self.router?.dispatch(
          action: .didReceiveGeocodes,
          payload: Weather.Payload(city: name, geocodes: geocodes)
        )
      } catch {
        self.router?.dispatch(
          action: .didEncounterError,
          payload: Weather.Payload(error: .decodingError)
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
        payload: Weather.Payload(error: .badURL)
      )
      return
    }
    
    URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
      guard let data else {
        self.router?.dispatch(
          action: .didEncounterError,
          payload: Weather.Payload(error: .networkError)
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
          payload: Weather.Payload(error: .decodingError)
        )
      }
    }
    .resume()
  }
  
  /// Retrieve the icon image for current weathe conditions
  ///
  /// Note: Ordinarily instead of hardcoding "@2x", I would make this dependent on the
  /// traitCollection's displayScale property.
  ///
  /// - Parameter code: The string code provided by openweather
  func fetchIcon(
    forIconCode code: String
  ) {
    guard let url = URL(string: "https://openweathermap.org/img/wn/\(code)@2x.png") else {
      return
    }
    
    do {
      let data = try Data(contentsOf: url)
      let imageData = Weather.ImageData(code: code, data: data)
      self.router?.dispatch(
        action: .didReceiveImage,
        payload: Weather.Payload(image: imageData)
      )
    } catch {
      print("@TODO: No Image returned from API, use a default image rather than dispatching error")
    }
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
