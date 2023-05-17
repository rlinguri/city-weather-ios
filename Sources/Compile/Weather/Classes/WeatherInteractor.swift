//
// File:      WeatherInteractor.swift
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
import Combine

class WeatherInteractor {
  
  /// Fetches weather for a city from the OpenWeather API
  ///
  /// - Parameter city: The enumerated city case
  ///
  /// - Returns: A publisher for a weather response object
  func fetchWeather(forCity city: Weather.City) -> AnyPublisher<Weather.Response, Error> {
    guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city.urlEncoded)&appid=\(Environment.OPENWEATHERMAP_API_KEY)") else {
      print("Error: Could not form URL for city \(city.stringValue) at index \(city.rawValue).")
      return Fail(error: URLError(.badURL))
        .eraseToAnyPublisher()
    }
    
    return URLSession.shared.dataTaskPublisher(for: url)
      .tryMap() { output -> Data in
        guard let httpResponse = output.response as? HTTPURLResponse else {
          throw URLError(.networkConnectionLost)
        }
        
        guard httpResponse.statusCode == 200 else {
          throw URLError(.badServerResponse)
        }
        
        guard let jsonStr = String(data: output.data, encoding: .utf8) else {
          throw URLError(.cannotDecodeRawData)
        }
        
        // Temp Debug
        print(jsonStr)
        
        return output.data
      }
      .decode(type: Weather.Response.self, decoder: JSONDecoder())
      .receive(on: RunLoop.main)
      .eraseToAnyPublisher()
  }
  
}
