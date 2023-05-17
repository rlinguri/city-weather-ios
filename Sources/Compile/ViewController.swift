//
// File:      ViewController.swift
// Package:   CityWeather
//
// Author:    Roderic Linguri <938388@cognizant.com>
// Copyright: © 2023 Roderic Linguri • All Rights Reserved
// License:   MIT
//
// Version:   0.1.1
// Requires:  iOS 15.6
//            Swift 5.0
//

import UIKit

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()

    // Test that the api key is loaded from environment
    print(Environment.OPENWEATHERMAP_API_KEY)
  }
  
}
