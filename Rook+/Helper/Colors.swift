//
//  Colors.swift
//  Rook+
//
//  Created by Delmwin Baeka on 1/21/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

public class RookColors: NSObject {
    
    private static var privateShared: RookColors?
    
    class func shared() -> RookColors {
        guard let stillAlive = privateShared else {
            privateShared = RookColors()
            return privateShared!
        }
        return stillAlive
    }
    
    private struct Cache {
        static let rookBlue: UIColor = UIColor(red: 0.000, green: 0.576, blue: 0.929, alpha: 1.000)
        static let rookWhite: UIColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
        static let rookMainBlue: UIColor = UIColor(red: 0, green: 74/255, blue: 239/255, alpha: 1.000)
        static let color: UIColor = UIColor(red: 0.532, green: 0.518, blue: 0.518, alpha: 0.500)
        static let rookDeepBlue: UIColor = UIColor(red: 0.008, green: 0.506, blue: 0.757, alpha: 1.000)
    }
    var rookBlue: UIColor { return Cache.rookBlue }
    var rookWhite: UIColor { return Cache.rookWhite }
    var color: UIColor { return Cache.color }
    var rookDeepBlue: UIColor { return Cache.rookDeepBlue }
    var rookMainBlue: UIColor { return Cache.rookMainBlue }
}


