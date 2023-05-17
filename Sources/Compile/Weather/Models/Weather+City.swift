//
// File:      Weather+City.swift
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

extension Weather {
  
  /// An enumeration of valid cities for the OpenWeather API to retrieve weather for
  /// NOTE: - Raw value of `Int` is used to index into the `allCases` array for picker values
  /// The integer values start at 1 to accomodate a header at index 0 for the default state
  enum City: Int, CaseIterable {
    
    // MARK: - Cases
    
    case ahmedabad = 1
    case alexandria
    case atlanta
    case baghdad
    case bangalore
    case bangkok
    case barcelona
    case beijing
    case beloHorizonte
    case buenosAires
    case cairo
    case chengdu
    case chennai
    case chicago
    case chongqing
    case dalian
    case dallas
    case delhi
    case dhaka
    case dongguan
    case foshan
    case fukuoka
    case guadalajara
    case guangzhou
    case hangzhou
    case harbin
    case hoChiMinhCity
    case hongKong
    case houston
    case hyderabad
    case istanbul
    case jakarta
    case jinan
    case johannesburg
    case karachi
    case khartoum
    case kinshasa
    case kolkata
    case kualaLumpur
    case lagos
    case lahore
    case lima
    case london
    case losAngeles
    case luanda
    case madrid
    case manila
    case mexicoCity
    case miami
    case moscow
    case mumbai
    case nagoya
    case nanjing
    case newYork
    case osaka
    case paris
    case philadelphia
    case pune
    case qingdao
    case rioDeJaneiro
    case riyadh
    case saintPetersburg
    case santiago
    case seoul
    case shanghai
    case shenyang
    case shenzhen
    case singapore
    case surat
    case suzhou
    case tehran
    case tianjin
    case tokyo
    case toronto
    case washington
    case wuhan
    case yangon
    
    // MARK: - Computed Properties
    
    /// The string value to display in UI
    var stringValue: String {
      switch self {
        case .ahmedabad:
          return "Ahmedabad"
        case .alexandria:
          return "Alexandria"
        case .atlanta:
          return "Atlanta"
        case .baghdad:
          return "Baghdad"
        case .bangalore:
          return "Bangalore"
        case .bangkok:
          return "Bangkok"
        case .barcelona:
          return "Barcelona"
        case .beijing:
          return "Beijing"
        case .beloHorizonte:
          return "Belo Horizonte"
        case .buenosAires:
          return "Buenos Aires"
        case .cairo:
          return "Cairo"
        case .chengdu:
          return "Chengdu"
        case .chennai:
          return "Chennai"
        case .chicago:
          return "Chicago"
        case .chongqing:
          return "Chongqing"
        case .dalian:
          return "Dalian"
        case .dallas:
          return "Dallas"
        case .delhi:
          return "Delhi"
        case .dhaka:
          return "Dhaka"
        case .dongguan:
          return "Dongguan"
        case .foshan:
          return "Foshan"
        case .fukuoka:
          return "Fukuoka"
        case .guadalajara:
          return "Guadalajara"
        case .guangzhou:
          return "Guangzhou"
        case .hangzhou:
          return "Hangzhou"
        case .harbin:
          return "Harbin"
        case .hoChiMinhCity:
          return "Ho Chi Minh City"
        case .hongKong:
          return "Hong Kong"
        case .houston:
          return "Houston"
        case .hyderabad:
          return "Hyderabad"
        case .istanbul:
          return "Istanbul"
        case .jakarta:
          return "Jakarta"
        case .jinan:
          return "Jinan"
        case .johannesburg:
          return "Johannesburg"
        case .karachi:
          return "Karachi"
        case .khartoum:
          return "Khartoum"
        case .kinshasa:
          return "Kinshasa"
        case .kolkata:
          return "Kolkata"
        case .kualaLumpur:
          return "Kuala Lumpur"
        case .lagos:
          return "Lagos"
        case .lahore:
          return "Lahore"
        case .lima:
          return "Lima"
        case .london:
          return "London"
        case .losAngeles:
          return "Los Angeles"
        case .luanda:
          return "Luanda"
        case .madrid:
          return "Madrid"
        case .manila:
          return "Manila"
        case .mexicoCity:
          return "Mexico City"
        case .miami:
          return "Miami"
        case .moscow:
          return "Moscow"
        case .mumbai:
          return "Mumbai"
        case .nagoya:
          return "Nagoya"
        case .nanjing:
          return "Nanjing"
        case .newYork:
          return "New York"
        case .osaka:
          return "Osaka"
        case .paris:
          return "Paris"
        case .philadelphia:
          return "Philadelphia"
        case .pune:
          return "Pune"
        case .qingdao:
          return "Qingdao"
        case .rioDeJaneiro:
          return "Rio de Janeiro"
        case .riyadh:
          return "Riyadh"
        case .saintPetersburg:
          return "Saint Petersburg"
        case .santiago:
          return "Santiago"
        case .seoul:
          return "Seoul"
        case .shanghai:
          return "Shanghai"
        case .shenyang:
          return "Shenyang"
        case .shenzhen:
          return "Shenzhen"
        case .singapore:
          return "Singapore"
        case .surat:
          return "Surat"
        case .suzhou:
          return "Suzhou"
        case .tehran:
          return "Tehran"
        case .tianjin:
          return "Tianjin"
        case .tokyo:
          return "Tokyo"
        case .toronto:
          return "Toronto"
        case .washington:
          return "Washington"
        case .wuhan:
          return "Wuhan"
        case .yangon:
          return "Yangon"
      }
    }
    
    /// The string to use in the API request
    var urlEncoded: String {
      if let string = self.stringValue.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) {
        return string
      } else {
        return stringValue.replacingOccurrences(of: " ", with: "%20")
      }
    }
    
  }
  
}
