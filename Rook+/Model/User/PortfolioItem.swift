//
//  PortfolioItem.swift
//  RookPlus
//
//  Created by Delmwin Baeka on 5/4/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

class PortfolioItem: NSObject, Codable {
    
    struct Item: Codable {
        var item_id: String
        
        var type: String
        
        var url: String
    }
    
    var title: String
    
    var id: String
    
    var desc: String
    
    var items: [Item]?
    
    var startDate: String
    
    var endDate: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case id
        case desc = "description"
        case items
        case startDate = "start_date"
        case endDate = "end_date"
    }
    
    init(title: String, id: String, desc: String, items: [Item]?, startDate: String, endDate: String) {
        self.title = title
        self.id = id
        self.desc = desc
        self.items = items
        self.startDate = startDate
        self.endDate = endDate
    }
}
