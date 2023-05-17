//
// File:      WeatherPresenter.swift
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
import Combine

class WeatherPresenter: NSObject {
  
  // MARK: - Properties
  
  /// The component that handles API interaction
  let interactor: WeatherInteractor
  
  /// Weak reference to the viewController until we can implement pub-sub model
  weak var viewController: WeatherViewController?
  
  /// The subscription to the interactor for the geoCode
  var geoCodeSubscription: AnyCancellable?
  
  /// The subscription to the interactor for the final weather data
  var weatherSubscription: AnyCancellable?
  
  /// The title for the viewController to use in the navigation bar
  let navigationTitle = Localized.weatherNavigationTitle
  
  /// The title to use in the picker view when no city is selected
  let selectCityTitle = Localized.selectCityTitle
  
  /// The title to use in an alert should the API call fail
  let errorAlertTitle = Localized.errorTitle
  
  /// The title for the button in the alert
  let okButtonActionTitle = Localized.okButtonActionTitle
  
  /// The text to display when no temperature has been fetched
  let defaultTemperatureLabelText = "--"
  
  /// Whether or not we should display the spinner
  var loading: Bool = false
  
  /// The temperature retrieved from the API
  var temperature: Double?
  
  /// Message to those who do not read README files. We're all guilty of it sometimes.
  let missingAPIKeyMessage = "API Key is missing. Please follow the instructions in the README!"
  
  /// The computed text to display in the temperature label
  var temperatureText: String {
    if let temperature = self.temperature {
      let temperatureString = String(format: "%.2f", temperature)
      return "\(temperatureString)º F"
    } else {
      return self.defaultTemperatureLabelText
    }
  }
  
  // MARK: - WeatherPresenter Implementation
  
  /// Initialize the presenter instance
  ///
  /// - Parameter interactor: The component that handles API interaction
  init(interactor: WeatherInteractor){
    self.interactor = interactor
  }
  
}

extension WeatherPresenter: UIPickerViewDelegate {
  
  func pickerView(
    _ pickerView: UIPickerView,
    didSelectRow row: Int,
    inComponent component: Int
  ) {
    self.loading = true
    self.geoCodeSubscription = self.interactor.fetchGeoCode(forCity: Weather.cities[row])
      .sink { completion in
        switch completion {
          case .failure(let error):
            self.viewController?.presentErrorAlert(message: error.localizedDescription)
          case .finished:
            print("fetch geocode complete")
        }
      } receiveValue: { response in
        if let city = response.first {
          self.weatherSubscription = self.interactor.fetchWeather(forCity: city)
            .sink { completion in
              switch completion {
                case .failure(let error):
                  self.loading = false
                  self.temperature = nil
                  self.viewController?.updateView()
                  self.viewController?.presentErrorAlert(message: error.localizedDescription)
                case .finished:
                  print("fetch weather complete")
              }
            } receiveValue: { response in
              self.temperature = response.main.fahrenheitTemperature
              self.loading = false
              self.viewController?.updateView()
            }
        }
      }
  }
  
}

extension WeatherPresenter: UIPickerViewDataSource {
  
  func pickerView(
    _ pickerView: UIPickerView,
    attributedTitleForRow row: Int,
    forComponent component: Int
  ) -> NSAttributedString? {
    
    var title: String
    
    var attributes: [NSAttributedString.Key: Any] = [
      .font: UIFont.preferredFont(forTextStyle: .headline)
    ]
    
    if row == 0 {
      attributes[.foregroundColor] = UIColor.systemGray
      title = self.selectCityTitle
    } else {
      attributes[.foregroundColor] = UIColor.darkText
      title = Weather.cities[row].name
    }
    
    return NSAttributedString(string: title, attributes: attributes)
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return Weather.cities.count + 1
  }
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
}
