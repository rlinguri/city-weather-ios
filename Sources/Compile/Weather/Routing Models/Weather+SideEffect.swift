//
// File:      Weather+SideEffect.swift
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

extension Weather {
  
  /// Encapsulation of methods to execute on the Store based on an event
  enum SideEffect: String {
    
    case void
    case setLoadingTrue
    case setLoadingFalse
    case updateView
    case saveCity
    case saveGeocode
    case saveImage
    case fetchGeocoding
    case fetchWeather
    case fetchImage
    case loadEntity
    case checkForAPIKey
    case presentAlert
    case postNotification
    
    /// Execute the side effect on the router
    ///
    /// - Parameter router: The module's reactive store
    /// - Parameter event: The event that triggered the sideEffect
    /// - Parameter completion: The block to call when execution is complete
    func execute(
      router: WeatherRouter?,
      event: Weather.Event,
      completion: (() -> Void)? = nil
    ) {
      switch self {
        case .void:
          break
        case .setLoadingTrue:
          router?.viewController?.presenter.loading = true
        case .setLoadingFalse:
          router?.viewController?.presenter.loading = false
        case .updateView:
          if let icon = event.state.current?.weather.first?.icon {
            router?.viewController?.presenter.currentImage = router?.entity?.imageForCode(code: icon)
          }
          router?.viewController?.presenter.weatherDataText = "\(String(describing: event.state))"
          router?.viewController?.updateView()
        case .saveCity:
          router?.entity?.savedCity = event.state.city
          router?.entity?.save()
        case .saveGeocode:
          // @TODO: Probably need to implement another UI piece that enables the user to select one of the geocodes. For now, this is not in the requirements
          guard let geoCodeToSave = event.state.geocodes?.first else {
            router?.dispatch(
              action: .didEncounterError,
              payload: Weather.Payload(error: .missingDependency)
            )
            return
          }
          router?.entity?.savedGeocode = geoCodeToSave
          router?.entity?.save()
        case .saveImage:
          if let icon = event.state.current?.weather.first?.icon {
            router?.viewController?.presenter.currentImage = router?.entity?.imageForCode(code: icon)
          }
          router?.entity?.imageData = event.state.images
          
          router?.entity?.save()
        case .postNotification:
          router?.interactor.postNotification(event: event)
        case .fetchGeocoding:
          guard let city = event.state.city else {
            router?.dispatch(
              action: .didEncounterError,
              payload: Weather.Payload(error: .missingDependency)
            )
            return
          }
          router?.interactor.fetchGeocode(forCityName: city)
        case .fetchWeather:
          guard let geocode = event.state.geocodes?.first else {
            router?.dispatch(
              action: .didEncounterError,
              payload: Weather.Payload(error: .missingDependency)
            )
            return
          }
          router?.interactor.fetchWeather(forGeocode: geocode)
        case .fetchImage:
          guard let icon = event.state.current?.weather.first?.icon else {
            // Don't alert the user if we can't download an image
            return
          }
          router?.interactor.fetchIcon(forIconCode: icon)
        case .loadEntity:
          router?.entity?.load()
        case .checkForAPIKey:
          if Environment.OPENWEATHERMAP_API_KEY == "$OPENWEATHERMAP_API_KEY" {
            router?.dispatch(action: .didEncounterError, payload: Weather.Payload(error: .missingAPIKey))
          }
        case .presentAlert:
          var message = "An unknown error has occurred"
          if let error = event.state.errors.last {
            message = error.localizedDescription
          }
          router?.viewController?.presentErrorAlert(message: message)
      }
      
      completion?()
    }
    
  }
  
}
