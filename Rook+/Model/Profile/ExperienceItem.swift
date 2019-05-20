//
//  ExperienceItem.swift
//  RookPlus
//
//  Created by Delmwin Baeka on 5/4/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

class ExperienceItem: NSObject, Codable {
    
    var title: String
    
    var id: String
    
    var name: String
    
    var location: String
    
    var isCurrent: String
    
    var startDate: String
    
    var endDate: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case id
        case name
        case location
        case isCurrent = "is_current"
        case startDate = "start_date"
        case endDate = "end_date"
    }
    
    init(title: String, id: String, name: String, location: String, isCurrent: String, startDate: String, endDate: String) {
        self.title = title
        self.id = id
        self.name = name
        self.location = location
        self.isCurrent = isCurrent
        self.startDate = startDate
        self.endDate = endDate
    }
}
