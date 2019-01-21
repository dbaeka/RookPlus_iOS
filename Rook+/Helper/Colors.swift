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
    }
    var rookBlue: UIColor { return Cache.rookBlue }
}
