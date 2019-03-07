//
//  InternshipItem.swift
//  RookPlus
//
//  Created by Delmwin Baeka on 3/1/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

class InternshipItem: NSObject, Codable {
    
    var title: String
    
    var logo: String
    
    var type: String
    
    var location: String
    
    var companyName: String
    
    var deadline: String
    
    var category: String
    
    var ratio: CGFloat?
    
    enum CodingKeys: String, CodingKey {
        case type
        case logo
        case title
        case location
        case ratio
        case category
        case companyName = "cname"
        case deadline = "date"
    }
    
    init(type: String, logo: String, title: String, location: String, companyName: String, deadline: String, category: String, ratio: CGFloat) {
        self.type = type
        self.logo = logo
        self.title = title
        self.location = location
        self.companyName = companyName
        self.deadline = deadline
        self.category = category
        self.ratio = ratio
    }
}
