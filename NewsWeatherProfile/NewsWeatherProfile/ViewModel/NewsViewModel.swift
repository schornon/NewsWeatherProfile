//
//  NewsViewModel.swift
//  NewsWeatherProfile
//
//  Created by Serhii CHORNONOH on 8/30/19.
//  Copyright © 2019 Serhii CHORNONOH. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class NewsViewModel {
    
    var image : UIImage? = nil
    //var image : Box<UIImage> = Box(UIImage())
    
    func fetchNewsImage(urlString: String, clouser: @escaping ()->()) {
        guard let url = URL(string: urlString) else {
            print("guard url fetching image error")
            return
        }
        
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                if let img = UIImage(data: data) {
                    self.image = img
                    DispatchQueue.main.async {
                        clouser()
                    }
                }
            } catch let error {
                print(error)
            }
        }
    }
    
    
    
}



