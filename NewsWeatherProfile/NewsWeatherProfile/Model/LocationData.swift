//
//  LocationData.swift
//  NewsWeatherProfile
//
//  Created by Serhii CHORNONOH on 8/15/19.
//  Copyright © 2019 Serhii CHORNONOH. All rights reserved.
//

import Foundation

struct LocationData {
    var countries : [String] = ["Ukraine", "Poland", "Germany"]
    var cityData : [String : [String]] = ["Ukraine": ["Kyiv", "Kharkiv", "Dnipro", "Lviv"],
                                          "Poland": ["Warsaw", "Krakow", "Lodz'", "Poznan"],
                                          "Germany": ["Berlin", "Munich", "Cologne", "Hamburg"]]
}

/*
struct LocationData {
    var countries = [String]()
    var cityData = [String]()
    
    init() {
        for code in NSLocale.isoCountryCodes as [String] {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let name = NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
            countries.append(name)
        }
    }
}
*/
