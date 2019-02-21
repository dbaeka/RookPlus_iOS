//
//  CVOnboardViewController.swift
//  Rook+
//
//  Created by Delmwin Baeka on 1/25/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

// MARK: - 1st Screen
class CVOnboardViewController: UIViewController {
    // MARK: - Properties
    var controllerColor: UIColor = UIColor(red: 0, green: 147/255, blue: 237/255, alpha: 1)
    var circleColor: UIColor = UIColor(red: 2/255, green: 129/255, blue: 193/255, alpha: 1)
    var pageNumber: Int = 0
}

extension CVOnboardViewController: OnboardView {}

// MARK: - 2nd Screen
class ExperienceOnboardViewController: UIViewController {
    
    // MARK: - Properties
    var controllerColor: UIColor = UIColor(red: 0, green: 210/255, blue: 232/255, alpha: 1)
    var circleColor: UIColor = UIColor(red: 2/255, green: 189/255, blue: 198/255, alpha: 1)
     var pageNumber: Int = 1
}

extension ExperienceOnboardViewController: OnboardView {}


// MARK: - 3rd Screen
class JobReadyOnboardViewController: UIViewController {
    
    // MARK: - Properties
    var controllerColor: UIColor = UIColor(red: 0, green: 210/255, blue: 232/255, alpha: 1)
    var circleColor: UIColor = UIColor(red: 2/255, green: 189/255, blue: 198/255, alpha: 1)
    var pageNumber: Int = 2
}

extension JobReadyOnboardViewController: OnboardView {}

