//
//  CompaniesItem.swift
//  RookPlus
//
//  Created by Delmwin Baeka on 2/27/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

class CompaniesItem: NSObject, Codable {
    
    var type: String
    
    var logo: String
    
    var bio: String
    
    var location: String
    
    var companyName: String
    
    enum CodingKeys: String, CodingKey {
        case type
        case logo
        case bio
        case location
        case companyName = "cname"
    }
    
    init(type: String, logo: String, bio: String, location: String, companyName: String) {
        self.type = type
        self.logo = logo
        self.bio = bio
        self.location = location
        self.companyName = companyName
    }
}
