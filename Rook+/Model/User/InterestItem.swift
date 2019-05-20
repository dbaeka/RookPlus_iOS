//
//  InterestItem.swift
//  RookPlus
//
//  Created by Delmwin Baeka on 5/4/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

class InterestItem: NSObject, Codable {
    
    var id: String
    
    var title: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
    }
    
    init(id: String, title: String) {
        self.id = id
        self.title = title
    }
}
