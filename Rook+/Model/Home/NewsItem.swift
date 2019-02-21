//
//  NewsItem.swift
//  Rook+
//
//  Created by Delmwin Baeka on 2/18/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

public enum NewsSource: String, Codable {
    case facebook = "fb"
    case twitter = "tw"
    case linkedin = "ln"
    
//    enum Key: CodingKey {
//        case rawValue
//    }
}

class NewsItem: NSObject, Codable {
    
    var title: String?
    
    var logo: String
    
    var source: NewsSource
    
    var companyName: String
    
    var timepost: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case logo
        case source
        case companyName = "cname"
        case timepost
    }
    
    init(title: String?, logo: String, source: String, cname: String, timepost: String, videoImage: String) {
        self.title = title
        self.logo = logo
        self.source = NewsSource(rawValue: source)!
        self.companyName = cname
        self.timepost = timepost
    }
}
