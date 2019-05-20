//
//  RecInternhipItem.swift
//  RookPlus
//
//  Created by Delmwin Baeka on 3/1/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

class RecInternshipItem: NSObject, Codable {
    
    var title: String
    
    var logo: String
    
    var location: String
    
    var companyName: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case logo
        case location
        case companyName = "cname"
    }
    
    init(title: String, logo: String, location: String, companyName: String) {
        self.title = title
        self.logo = logo
        self.location = location
        self.companyName = companyName
    }
}
