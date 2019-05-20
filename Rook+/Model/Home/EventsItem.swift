//
//  EventsItem.swift
//  Rook+
//
//  Created by Delmwin Baeka on 2/18/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

class EventsItem: NSObject, Codable {
    
    var title: String?
    
    var logo: String
    
    var featureImage: String
    
    var price: Int
    
    var location: String
    
    var date: String
    
    var detail: String
    
    var companyName: String
    
    var timepost: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case logo
        case featureImage = "image"
        case price
        case location
        case timepost
        case date
        case detail
        case companyName = "cname"
    }
    
    init(title: String?, logo: String, featureImage: String, price: Int, location: String, date: String, detail: String, companyName: String, timepost: String) {
        self.title = title
        self.logo = logo
        self.price = price
        self.featureImage = featureImage
        self.location = location
        self.date = date
        self.detail = detail
        self.companyName = companyName
        self.timepost = timepost
    }
}
