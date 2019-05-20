//
//  EducationItem.swift
//  RookPlus
//
//  Created by Delmwin Baeka on 5/4/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//
import UIKit

class EducationItem: NSObject, Codable {
    
    var completion: String
    
    var course: String
    
    var id: String
    
    var level: String
    
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case completion
        case course
        case id
        case level
        case name
    }
    
    init(name: String, course: String, completion: String, id: String, level: String) {
        self.completion = completion
        self.course = course
        self.id = id
        self.level = level
        self.name = name
    }
}
