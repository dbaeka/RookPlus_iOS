//
//  VideosItem.swift
//  Rook+
//
//  Created by Delmwin Baeka on 2/18/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

class VideosItem: NSObject, Codable {
    
    var title: String?
    
    var logo: String
    
    var category: String
    
    var views: Int
    
    var timepost: String
    
    var videoImage: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case logo
        case views
        case timepost
        case category
        case videoImage = "image"
    }
    
    init(title: String?, logo: String, views: Int, category: String, timepost: String, videoImage: String) {
        self.title = title
        self.logo = logo
        self.views = views
        self.category = category
        self.videoImage = videoImage
        self.timepost = timepost
    }
}
