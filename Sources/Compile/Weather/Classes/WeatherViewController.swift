//
// File:      WeatherViewController.swift
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

class WeatherViewController: UIViewController {
  
  // MARK: - Properties
  
  /// The view model
  let presenter: WeatherPresenter
    
  // MARK: - Outlets / Subviews
  
  /// The label that dispays the temperature
  let temperatureLabel: UILabel = {
    let view = UILabel()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.font = UIFont.preferredFont(forTextStyle: .largeTitle)
    view.textAlignment = .center
    view.textColor = UIColor.darkText
    return view
  }()
  
  /// The picker that enables the user to select a city
  let cityPicker: UIPickerView = {
    let view = UIPickerView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  /// The spinner that will show during loading
  let spinner: UIActivityIndicatorView = {
    let view = UIActivityIndicatorView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.hidesWhenStopped = true
    view.style = .large
    view.color = .systemBlue
    return view
  }()
  
  // MARK: - WeatherViewController Implementation
  
  init(presenter: WeatherPresenter) {
    self.presenter = presenter
    super.init(nibName: nil, bundle: nil)
  }
  
  private func setupNavigation() {
    self.title = self.presenter.navigationTitle
  }
  
  private func setupSubviews() {
    self.view.addSubview(self.temperatureLabel)
    
    self.cityPicker.delegate = self.presenter
    self.cityPicker.dataSource = self.presenter
    self.view.addSubview(self.cityPicker)
    
    self.view.addSubview(self.spinner)
    
    self.spinner.stopAnimating()
    self.cityPicker.selectRow(0, inComponent: 0, animated: false)
  }
  
  private func setupConstraints() {
    let centerY = self.view.centerYAnchor
    
    let constraints: [NSLayoutConstraint] = [
      self.spinner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      self.spinner.centerYAnchor.constraint(equalTo: centerY, constant: 33),
      self.cityPicker.centerYAnchor.constraint(equalTo: centerY, constant: -100),
      self.cityPicker.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
      self.cityPicker.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
      self.temperatureLabel.centerYAnchor.constraint(equalTo: centerY, constant: 100),
      self.temperatureLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
      self.temperatureLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
    ]
    
    NSLayoutConstraint.activate(constraints)
  }
  
  func updateView() {
    if self.presenter.loading == true {
      self.spinner.startAnimating()
    } else {
      self.spinner.stopAnimating()
    }
    self.temperatureLabel.text = self.presenter.temperatureText
  }
  
  /// Presents an alert with the title 'Error'
  ///
  /// - Parameter message: The string to display as the alert's message
  func presentErrorAlert(message: String) {
    let alertController = UIAlertController(
      title: self.presenter.errorAlertTitle,
      message: message,
      preferredStyle: .alert
    )
    let action = UIAlertAction(
      title: self.presenter.okButtonActionTitle,
      style: .default
    ) { [weak self] action in
      self?.dismiss(animated: true) {
        self?.cityPicker.selectRow(0, inComponent: 0, animated: true)
        self?.temperatureLabel.text = self?.presenter.defaultTemperatureLabelText
      }
    }
    alertController.addAction(action)
    self.present(alertController, animated: true, completion: nil)
  }

  // MARK: - UIViewController Implementation
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = .systemBackground
    
    self.setupNavigation()
    self.setupSubviews()
    self.setupConstraints()
    self.updateView()
  }
  
}

