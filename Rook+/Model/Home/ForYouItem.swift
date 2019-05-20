//
//  ForYouItem.swift
//  Rook+
//
//  Created by Delmwin Baeka on 2/18/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

class ForYouItem: NSObject, Codable {
    
    var title: String?
    
    var logo: String
    
    var category: String
    
    var views: Int
    
    var timepost: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case logo
        case views
        case timepost
        case category
    }
    
    init(title: String?, logo: String, views: Int, category: String, timepost: String) {
        self.title = title
        self.logo = logo
        self.views = views
        self.category = category
        self.timepost = timepost
    }
}
