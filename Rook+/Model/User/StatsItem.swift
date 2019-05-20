//
//  StatsItem.swift
//  RookPlus
//
//  Created by Delmwin Baeka on 5/4/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit



class StatsItem: NSObject, Codable {
    
    struct Badge: Codable {
        var image: String
        
        var name: String
    }
    
    var completed: Int
    
    var points: Int
    
    var speed: Int
    
    var successRate: Int
    
    var totalTasks: Int
    
    var badges: [Badge]?
    
    enum CodingKeys: String, CodingKey {
        case completed
        case points
        case speed
        case successRate = "success_rate"
        case totalTasks = "total_tasks"
        case badges
    }
    
    init(completed: Int, points: Int, speed: Int, successRate: Int, totalTasks: Int, badges: [Badge]?) {
        self.completed = completed
        self.points = points
        self.speed = speed
        self.successRate = successRate
        self.totalTasks = totalTasks
        self.badges = badges
    }
}

