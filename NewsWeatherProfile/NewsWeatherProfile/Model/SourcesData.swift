//
//  SourcesData.swift
//  NewsWeatherProfile
//
//  Created by Serhii CHORNONOH on 8/30/19.
//  Copyright © 2019 Serhii CHORNONOH. All rights reserved.
//

import Foundation

struct SourcesData : Decodable {
    var status : String?
    var sources = [Source]()
}

struct Source : Decodable {
    var id : String?
    var name : String?
    var description : String?
    var url : String?
    var language : String?
    var country : String?
}
