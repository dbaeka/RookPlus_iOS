//
//  PollsItem.swift
//  Rook+
//
//  Created by Delmwin Baeka on 2/16/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

class PollsItem: NSObject, Codable {
    
    var title: String?
    
    var logo: String
    
    var yes: Int
    
    var no: Int
    
    var timepost: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case logo = "image"
        case yes
        case no
        case timepost
    }
    
    init(title: String?, logo: String, yes: Int, no: Int, timepost: String) {
        self.title = title
        self.logo = logo
        self.yes = yes
        self.no = no
        self.timepost = timepost
    }
}
