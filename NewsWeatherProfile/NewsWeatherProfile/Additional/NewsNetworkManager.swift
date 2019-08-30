//
//  NewsNetworkManager.swift
//  NewsWeatherProfile
//
//  Created by Serhii CHORNONOH on 8/30/19.
//  Copyright © 2019 Serhii CHORNONOH. All rights reserved.
//

import Foundation
import Alamofire

class NewsNetworkManager {
    
    let urlString = "https://newsapi.org/v2/top-headlines?country=ua&apiKey=8349ae6145cd4734b3cb2a1402a82bae"
    
    func fetchData() {
        print("fetchData - NewsNetworkManager")
        
        guard let url = URL(string: "\(urlString)") else {
            print("guard newsURL fail")
            return
        }
        Alamofire.request(url).responseJSON { (response) in
            print("news Alamofire success")
            guard let data = response.data else {
                print("guard response.data news error")
                return
            }
            
            do {
                let parsedResult = try JSONDecoder().decode(NewsData.self, from: data)
                if parsedResult.status != "ok" {
                    print("parsedResult.status != 'ok'")
                }
                print(parsedResult)
                
            } catch {
                print("JSONDecoder failure")
            }
        }
    }
}
