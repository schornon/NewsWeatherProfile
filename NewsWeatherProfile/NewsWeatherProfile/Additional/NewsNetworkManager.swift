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
    
    let base = "https://newsapi.org/v2/top-headlines"
    let apiKey = "&apiKey=8349ae6145cd4734b3cb2a1402a82bae"
    var sources = "?sources="
    
    
    let sourcesUrlString = "https://newsapi.org/v2/sources?apiKey=8349ae6145cd4734b3cb2a1402a82bae"
    
    var viewModel : TabBarViewModel?
    
    init(viewModel: TabBarViewModel) {
        self.viewModel = viewModel
    }
    
    func fetchData() {
        print("fetchData - NewsNetworkManager")
        
        formSourceString()
        guard let pageSize = viewModel?.pageSize.value else { return }
        guard let url = URL(string: "\(base)\(sources)\(apiKey)&pageSize=\(pageSize)") else { //?sources=abc-news
            print("guard newsURL fail")
            print("^^^\(base)\(sources)\(apiKey)^^^")
            return
        }
        print(url)
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
                self.viewModel?.newsData.value = parsedResult
                
            } catch let error {
                print("JSONDecoder failure : \(error)")
            }
        }
    }
    
    func fetchSourcesData() {
        
        guard let url = URL(string: sourcesUrlString) else {
            return
        }
        
        Alamofire.request(url).responseJSON { (response) in
            guard let data = response.data else {
                print("guard response.data sources error")
                return
            }
            do {
                let parsedResult = try JSONDecoder().decode(SourcesData.self, from: data)
                if parsedResult.status != "ok" {
                    print("sources parsedResult.status != 'ok'")
                }
                self.viewModel?.sourcesData.value = parsedResult
            } catch let error {
                print(error)
            }
        }
    }
    
    private func formSourceString() {
        self.sources = "?sources="
        if viewModel?.sourcesData.value.favoriteSources != nil && (viewModel?.sourcesData.value.favoriteSources?.count)! > 0 {
            let uFavoriteSources = (viewModel?.sourcesData.value.favoriteSources!)!
            var i = 0
            for source in uFavoriteSources {
                guard let id = source.id else { return }
                if i == 0 {
                    self.sources += "\(id)"
                } else {
                    self.sources += ",\(id)"
                }
                i += 1
            }
        } else {
            self.sources += "abc-news,ansa,bbc-news,bloomberg"
        }
    }
}
