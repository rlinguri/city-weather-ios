//
// File:      WeatherViewController.swift
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

/// The component that handles user interaction
class WeatherViewController: UIViewController {
  
  /// The module's view model
  let presenter: WeatherPresenter
  
  /// The module's reactive store
  let router: WeatherRouter
  
  /// Initialize the viewController instance
  ///
  /// - Parameters:
  ///   - presenter: The view model
  ///   - router: The reactive store
  init(presenter: WeatherPresenter, router: WeatherRouter) {
    self.presenter = presenter
    self.router = router
    super.init(nibName: nil, bundle: nil)
  }
  
  private func setupNavigation() {
    
  }
  
  private func setupSubViews() {
    
  }
  
  private func setupConstraints() {
    
  }
  
  // MARK: - UIViewController
  
  /// Initialize the viewController from a storyboard or xib
  ///
  /// - Parameter coder: An instance of `NSCoder`
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.setupNavigation()
    self.setupSubViews()
    self.setupConstraints()
    
    self.router.dispatch(
      action: .didConfigureView,
      payload: Weather.Payload()
    )
  }
}
