//
//  ViewModel.swift
//  NewsWeatherProfile
//
//  Created by Serhii CHORNONOH on 8/14/19.
//  Copyright © 2019 Serhii CHORNONOH. All rights reserved.
//

import Foundation

class WeatherViewModel {
    
    var networkManager = WeatherNetworkManager()
    
    var metadata : Box<WeatherMetadata> = Box(WeatherMetadata())
    var flag : Box<Bool> = Box(false)
    var status : Box<Status> = Box(Status.none)
    
    func fetchMetadata(request: String) {
        networkManager.fetchMetadata(request: request, viewModel: self)
    }
}
