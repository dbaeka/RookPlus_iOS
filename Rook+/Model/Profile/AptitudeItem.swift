//
//  AptitudeItem.swift
//  RookPlus
//
//  Created by Delmwin Baeka on 5/4/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//
import UIKit

class AptitudeItem: NSObject, Codable {
    
    var average_score: Int
    
    var highest_score: Int
    
    var percentile: Int
    
    var tests_taken: Int
    
    enum CodingKeys: String, CodingKey {
        case average_score
        case highest_score
        case percentile
        case tests_taken
    }
    
    init(average_score: Int, highest_score: Int, percentile: Int, tests_taken: Int) {
        self.average_score = average_score
        self.highest_score = highest_score
        self.percentile = percentile
        self.tests_taken = tests_taken
    }
}
