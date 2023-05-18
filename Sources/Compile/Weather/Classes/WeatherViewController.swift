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
  
  // MARK: - Properties
  
  /// The module's view model
  let presenter: WeatherPresenter
  
  /// The module's reactive store
  let router: WeatherRouter
  
  // MARK: - Outlets / Subviews
  
  /// The label containing instrauctions for the text field
  let searchLabel: UILabel = {
    let view = UILabel()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.textColor = .lightGray
    view.textAlignment = .center
    view.font = UIFont.preferredFont(forTextStyle: .caption1)
    return view
  }()
  
  /// A field where a user can search for weather for a city
  let searchField: UITextField = {
    let view = UITextField()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.textColor = .darkGray
    view.textAlignment = .center
    view.font = UIFont.preferredFont(forTextStyle: .headline)
    view.autocapitalizationType = .words
    view.spellCheckingType = .no
    view.autocorrectionType = .no
    view.returnKeyType = .done
    view.layer.borderWidth = 0.5
    view.layer.borderColor = UIColor.darkGray.cgColor
    view.layer.cornerRadius = 9.0
    return view
  }()
  
  // Temporarily will display raw data that the UI will use
  let weatherView: UITextView = {
    let view = UITextView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .lightGray
    view.textColor = .red
    view.textAlignment = .left
    view.font = UIFont.monospacedSystemFont(ofSize: 9.0, weight: .regular)
    view.isUserInteractionEnabled = false
    return view
  }()
  
  /// A loading indicator
  let spinner: UIActivityIndicatorView = {
    let view = UIActivityIndicatorView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.hidesWhenStopped = true
    view.style = .large
    view.color = .orange
    return view
  }()
  
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
    self.title = self.presenter.navigationTitle
  }
  
  private func setupSubViews() {
    self.searchLabel.text = self.presenter.searchFieldLabel
    self.view.addSubview(self.searchLabel)
    
    self.searchField.delegate = self
    self.view.addSubview(self.searchField)
    
    self.view.addSubview(self.weatherView)
    
    self.view.addSubview(self.spinner)
  }
  
  private func setupConstraints() {
    let constraints: [NSLayoutConstraint] = [
      self.searchLabel.leadingAnchor.constraint(
        equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,
        constant: self.presenter.spacing
      ),
      self.searchLabel.topAnchor.constraint(
        equalTo: self.view.safeAreaLayoutGuide.topAnchor,
        constant: self.presenter.spacing
      ),
      self.searchLabel.trailingAnchor.constraint(
        equalTo: self.view.safeAreaLayoutGuide.trailingAnchor,
        constant: self.presenter.spacing * -1
      ),
      self.searchLabel.heightAnchor.constraint(
        equalToConstant: self.presenter.spacing
      ),
      self.searchField.leadingAnchor.constraint(
        equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,
        constant: self.presenter.spacing
      ),
      self.searchField.topAnchor.constraint(
        equalTo: self.searchLabel.bottomAnchor,
        constant: self.presenter.spacing
      ),
      self.searchField.trailingAnchor.constraint(
        equalTo: self.view.safeAreaLayoutGuide.trailingAnchor,
        constant: self.presenter.spacing * -1
      ),
      self.searchField.heightAnchor.constraint(
        equalToConstant: self.presenter.textFieldHeight
      ),
      self.weatherView.leadingAnchor.constraint(
        equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,
        constant: self.presenter.spacing
      ),
      self.weatherView.topAnchor.constraint(
        equalTo: self.searchField.bottomAnchor,
        constant: self.presenter.spacing
      ),
      self.weatherView.trailingAnchor.constraint(
        equalTo: self.view.safeAreaLayoutGuide.trailingAnchor,
        constant: self.presenter.spacing * -1
      ),
      self.weatherView.bottomAnchor.constraint(
        equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,
        constant: self.presenter.spacing * -1
      ),
      self.spinner.centerXAnchor.constraint(
        equalTo: self.view.safeAreaLayoutGuide.centerXAnchor
      ),
      self.spinner.centerYAnchor.constraint(
        equalTo: self.view.safeAreaLayoutGuide.centerYAnchor
      )
    ]
    
    NSLayoutConstraint.activate(constraints)
  }
  
  /// Called from a side effect when new data is available in the presenter
  func updateView() {
    DispatchQueue.main.async {
      if self.presenter.loading == true {
        self.spinner.startAnimating()
      } else {
        self.spinner.stopAnimating()
      }
      
      if let savedCity = self.presenter.entity.savedCity {
        self.searchField.text = savedCity
      }
      
      self.weatherView.text = self.presenter.weatherDataText
    }
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
    
    self.view.backgroundColor = .systemBackground
    
    self.setupNavigation()
    self.setupSubViews()
    self.setupConstraints()
    
    self.router.dispatch(
      action: .didConfigureView,
      payload: Weather.Payload()
    )
    
    self.updateView()
    
    if self.presenter.weatherDataText == nil {
      self.searchField.becomeFirstResponder()
    }
  }
}

extension WeatherViewController: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    self.view.endEditing(true)
    self.router.dispatch(
      action: .didEnterCity,
      payload: Weather.Payload(city: textField.text)
    )
    return false
  }
  
}
