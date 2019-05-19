//
//  DiscoveryItem.swift
//  Rook+
//
//  Created by Delmwin Baeka on 2/15/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

class DiscoverItem: NSObject, Codable {
    
    var image: String
    
    enum CodingKeys: String, CodingKey {
        case image
    }
    
    init(image: String) {
        self.image = image
    }
}

//class RookieOfTheWeekItem: DiscoverItem, Codable {
//
//    var profilePic: String?
//
//    var studentName: String
//
//    var points: Int
//
//    enum CodingKeys: String, CodingKey {
//        case points
//        case studentName = "name"
//        case profilePic = "image"
//    }
//
//    init(profilePic: String?, studentName: String, points: Int) {
//        self.profilePic = profilePic
//        self.studentName = studentName
//        self.points = points
//    }
//}
//
//class newCompany: DiscoverItem {
//
//    var logo: UIImage?
//
//    var companyName: String
//
//    init(logo: UIImage?, companyName: String) {
//        self.logo = logo
//        self.companyName = companyName
//    }
//}
//
//class newTask: DiscoverItem {
//
//    var logo: UIImage?
//
//    var taskTitle: String
//
//    var timePosted: Date
//
//    init(logo: UIImage?, taskTitle: String, timePosted: Date) {
//        self.logo = logo
//        self.taskTitle = taskTitle
//        self.timePosted = timePosted
//    }
//}
