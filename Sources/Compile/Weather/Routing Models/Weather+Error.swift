//
// File:      Weather+Error.swift
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
  
  /// An enumeration of possible errors that can occur
  enum Error {
    
    case unknown
    case missingDependency
    case missingParameter
    case badURL
    case networkError
    case decodingError
    case missingAPIKey
    
    var message: String {
      switch self {
        case .unknown:
          return "An unknown error has occurred"
        case .missingDependency:
          return "The app encountered a dependency error. Please restart the app."
        case .missingParameter:
          return "The app encountered a parameter error. Please restart the app."
        case .badURL:
          return "There was a problem creating a URL to fetch from the API with"
        case .networkError:
          return "No data was returned by the server. Please try again."
        case .decodingError:
          return "There was a problem decoding the data from the API"
        case .missingAPIKey:
          return "API Key is missing. Please follow the instructions in the README."
      }
    }
  }
  
}

extension Weather.Error: Error {
  
}
