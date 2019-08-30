//
//  NewsData.swift
//  NewsWeatherProfile
//
//  Created by Serhii CHORNONOH on 8/30/19.
//  Copyright © 2019 Serhii CHORNONOH. All rights reserved.
//

import Foundation

struct NewsData: Decodable {
    var status : String?
    var totalResults : Int?
    var articles = [NewsArticle]()
}

struct NewsArticle: Decodable {
    var source : NewsSource
    var author : String?
    var title : String?
    var description : String?
    var url : String?
    var urlToImage : String?
    var publishedAt: String?
    var content : String?
}

struct NewsSource : Decodable {
    var id : String?
    var name : String?
}
