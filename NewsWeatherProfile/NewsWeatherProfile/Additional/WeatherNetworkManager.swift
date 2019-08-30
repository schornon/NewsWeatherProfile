//
//  NetworkManager.swift
//  WeatherApp2-MVVM-singleView
//
//  Created by Serhii CHORNONOH on 7/29/19.
//  Copyright © 2019 Serhii CHORNONOH. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import RecastAI

class WeatherNetworkManager {
    
    var viewModel : WeatherViewModel?
    
    let apiKey = "c2dcf8ffb5cdc3f8977bfd2ae7ea4738"
    let bot = RecastAIClient(token: "0a66a3cbe0f5dd9a855774a0040a8123")
    
    func fetchMetadata(request: String, viewModel: WeatherViewModel) {
        self.viewModel = viewModel
        makeRequest(request: request)
    }
    
    func makeRequest(request: String) {
        self.bot.textRequest(request, successHandler: successHandle, failureHandle: failureHandle)
    }
    
    func successHandle(_ response: Response) {
        if let location = response.get(entity: "location") {
            //print(location)
            getWeather(lat: location["lat"]! as! Double,
                       lon: location["lng"]! as! Double,
                       locationName: "\((location["raw"])!), \(String(describing: location["country"]!).uppercased())")
        } else {
            viewModel?.status.value = .failure
        }
    }
    
    func failureHandle(_ error: Error) {
        print("failureHandle")
        viewModel?.status.value = .failure
    }
    
    func getWeather(lat: Double, lon: Double, locationName: String) {
        let url = "http://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=metric"
        Alamofire.request(url).responseJSON { response in

            if let response = response.result.value {
                let jsonResponse = JSON(response)
                let jsonWeather = jsonResponse["weather"].array![0]
                let jsonTemp = jsonResponse["main"]
                let jsonWind = jsonResponse["wind"]
                
                let temperature = "\(Int(round(jsonTemp["temp"].doubleValue))) °C"
                let pressure = "\(Int(round(jsonTemp["pressure"].doubleValue))) hPa"
                let humidity = "\(Int(round(jsonTemp["humidity"].doubleValue))) %"
                let windSpeed = "\(Int(round(jsonWind["speed"].doubleValue))) m/sec"
                let windDirection = "\(Int(round(jsonWind["speed"].doubleValue))) °"
                let iconName = jsonWeather["icon"].stringValue
                
                self.viewModel?.metadata.value = WeatherMetadata(locationName: locationName, temperature: temperature, atmosphericPressure: pressure, humidity: humidity, windSpeed: windSpeed, windDirection: windDirection, weatherImageName: iconName)
                
                self.viewModel?.flag.value = true
                self.viewModel?.status.value = .done
            }
        }
    }
    
}

