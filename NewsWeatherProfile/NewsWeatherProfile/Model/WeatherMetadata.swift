//
//  WeatherMetadata.swift
//  WeatherApp2-MVVM-singleView
//
//  Created by Serhii CHORNONOH on 7/29/19.
//  Copyright © 2019 Serhii CHORNONOH. All rights reserved.
//

import Foundation

struct WeatherMetadata {
    var locationName : String = ""
    var temperature : String = ""
    var atmosphericPressure : String = ""
    var humidity : String = ""
    var windSpeed : String = ""
    var windDirection : String = ""
    var weatherImageName : String = ""
}

enum Status {
    case none
    case loading
    case done
    case failure
}
