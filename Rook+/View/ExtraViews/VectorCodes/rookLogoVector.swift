//
//  barRook.swift
//  Rook+
//
//  Created by Delmwin Baeka on 1/22/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

@IBDesignable
class rookLogoVector: UIView {
    
    
    
    @IBInspectable var textColor: UIColor = RookColors.shared().rookMainBlue {
        didSet {
            RookTextLayer.fillColor = textColor.cgColor
        }
    }
    
    private let RookTextLayer = CAShapeLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override open func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    
    fileprivate func setup() {
        layer.addSublayer(RookTextLayer)
        
        //// Subframes
        let group: CGRect = CGRect(x: bounds.minX, y: bounds.minY, width: bounds.width, height: bounds.height + 1)
        
        
        //// Group
        //// R Drawing
        let path = UIBezierPath()
        path.move(to: CGPoint(x: group.minX + 0.22699 * group.width, y: group.minY + 0.48642 * group.height))
        path.addCurve(to: CGPoint(x: group.minX + 0.17612 * group.width, y: group.minY + 0.70263 * group.height), controlPoint1: CGPoint(x: group.minX + 0.22799 * group.width, y: group.minY + 0.58224 * group.height), controlPoint2: CGPoint(x: group.minX + 0.20753 * group.width, y: group.minY + 0.66922 * group.height))
        path.addLine(to: CGPoint(x: group.minX + 0.22212 * group.width, y: group.minY + 0.98485 * group.height))
        path.addLine(to: CGPoint(x: group.minX + 0.15056 * group.width, y: group.minY + 0.98485 * group.height))
        path.addLine(to: CGPoint(x: group.minX + 0.11275 * group.width, y: group.minY + 0.72073 * group.height))
        path.addLine(to: CGPoint(x: group.minX + 0.06787 * group.width, y: group.minY + 0.72073 * group.height))
        path.addLine(to: CGPoint(x: group.minX + 0.06787 * group.width, y: group.minY + 0.98485 * group.height))
        path.addLine(to: CGPoint(x: group.minX + 0.00000 * group.width, y: group.minY + 0.98485 * group.height))
        path.addLine(to: CGPoint(x: group.minX + 0.00000 * group.width, y: group.minY + 0.24242 * group.height))
        path.addLine(to: CGPoint(x: group.minX + 0.13705 * group.width, y: group.minY + 0.24242 * group.height))
        path.addCurve(to: CGPoint(x: group.minX + 0.20325 * group.width, y: group.minY + 0.31194 * group.height), controlPoint1: CGPoint(x: group.minX + 0.16548 * group.width, y: group.minY + 0.24242 * group.height), controlPoint2: CGPoint(x: group.minX + 0.18755 * group.width, y: group.minY + 0.26560 * group.height))
        path.addCurve(to: CGPoint(x: group.minX + 0.22699 * group.width, y: group.minY + 0.48642 * group.height), controlPoint1: CGPoint(x: group.minX + 0.21908 * group.width, y: group.minY + 0.35853 * group.height), controlPoint2: CGPoint(x: group.minX + 0.22765 * group.width, y: group.minY + 0.42147 * group.height))
        path.close()
        path.move(to: CGPoint(x: group.minX + 0.06787 * group.width, y: group.minY + 0.39306 * group.height))
        path.addLine(to: CGPoint(x: group.minX + 0.06787 * group.width, y: group.minY + 0.57020 * group.height))
        path.addLine(to: CGPoint(x: group.minX + 0.12280 * group.width, y: group.minY + 0.57020 * group.height))
        path.addCurve(to: CGPoint(x: group.minX + 0.15804 * group.width, y: group.minY + 0.48110 * group.height), controlPoint1: CGPoint(x: group.minX + 0.14627 * group.width, y: group.minY + 0.57020 * group.height), controlPoint2: CGPoint(x: group.minX + 0.15801 * group.width, y: group.minY + 0.54050 * group.height))
        path.addCurve(to: CGPoint(x: group.minX + 0.14914 * group.width, y: group.minY + 0.41637 * group.height), controlPoint1: CGPoint(x: group.minX + 0.15851 * group.width, y: group.minY + 0.45685 * group.height), controlPoint2: CGPoint(x: group.minX + 0.15526 * group.width, y: group.minY + 0.43321 * group.height))
        path.addCurve(to: CGPoint(x: group.minX + 0.12280 * group.width, y: group.minY + 0.39306 * group.height), controlPoint1: CGPoint(x: group.minX + 0.14319 * group.width, y: group.minY + 0.40083 * group.height), controlPoint2: CGPoint(x: group.minX + 0.13441 * group.width, y: group.minY + 0.39306 * group.height))
        path.addLine(to: CGPoint(x: group.minX + 0.06787 * group.width, y: group.minY + 0.39306 * group.height))
        path.close()
        
        
        
        //// o Drawing
        path.move(to: CGPoint(x: group.minX + 0.41035 * group.width, y: group.minY + 0.92578 * group.height))
        path.addCurve(to: CGPoint(x: group.minX + 0.33514 * group.width, y: group.minY + 1.00000 * group.height), controlPoint1: CGPoint(x: group.minX + 0.39201 * group.width, y: group.minY + 0.97533 * group.height), controlPoint2: CGPoint(x: group.minX + 0.36693 * group.width, y: group.minY + 1.00007 * group.height))
        path.addCurve(to: CGPoint(x: group.minX + 0.25992 * group.width, y: group.minY + 0.92578 * group.height), controlPoint1: CGPoint(x: group.minX + 0.30334 * group.width, y: group.minY + 0.99993 * group.height), controlPoint2: CGPoint(x: group.minX + 0.27826 * group.width, y: group.minY + 0.97519 * group.height))
        path.addCurve(to: CGPoint(x: group.minX + 0.23243 * group.width, y: group.minY + 0.71855 * group.height), controlPoint1: CGPoint(x: group.minX + 0.24159 * group.width, y: group.minY + 0.87630 * group.height), controlPoint2: CGPoint(x: group.minX + 0.23243 * group.width, y: group.minY + 0.80722 * group.height))
        path.addCurve(to: CGPoint(x: group.minX + 0.25973 * group.width, y: group.minY + 0.51236 * group.height), controlPoint1: CGPoint(x: group.minX + 0.23243 * group.width, y: group.minY + 0.62988 * group.height), controlPoint2: CGPoint(x: group.minX + 0.24153 * group.width, y: group.minY + 0.56115 * group.height))
        path.addCurve(to: CGPoint(x: group.minX + 0.33514 * group.width, y: group.minY + 0.43939 * group.height), controlPoint1: CGPoint(x: group.minX + 0.27794 * group.width, y: group.minY + 0.46372 * group.height), controlPoint2: CGPoint(x: group.minX + 0.30307 * group.width, y: group.minY + 0.43939 * group.height))
        path.addCurve(to: CGPoint(x: group.minX + 0.41054 * group.width, y: group.minY + 0.51236 * group.height), controlPoint1: CGPoint(x: group.minX + 0.36720 * group.width, y: group.minY + 0.43939 * group.height), controlPoint2: CGPoint(x: group.minX + 0.39233 * group.width, y: group.minY + 0.46372 * group.height))
        path.addCurve(to: CGPoint(x: group.minX + 0.43784 * group.width, y: group.minY + 0.71855 * group.height), controlPoint1: CGPoint(x: group.minX + 0.42874 * group.width, y: group.minY + 0.56101 * group.height), controlPoint2: CGPoint(x: group.minX + 0.43784 * group.width, y: group.minY + 0.62974 * group.height))
        path.addCurve(to: CGPoint(x: group.minX + 0.41035 * group.width, y: group.minY + 0.92578 * group.height), controlPoint1: CGPoint(x: group.minX + 0.43784 * group.width, y: group.minY + 0.80736 * group.height), controlPoint2: CGPoint(x: group.minX + 0.42868 * group.width, y: group.minY + 0.87644 * group.height))
        path.close()
        path.move(to: CGPoint(x: group.minX + 0.33514 * group.width, y: group.minY + 0.86501 * group.height))
        path.addCurve(to: CGPoint(x: group.minX + 0.37483 * group.width, y: group.minY + 0.72064 * group.height), controlPoint1: CGPoint(x: group.minX + 0.36160 * group.width, y: group.minY + 0.86501 * group.height), controlPoint2: CGPoint(x: group.minX + 0.37483 * group.width, y: group.minY + 0.81688 * group.height))
        path.addCurve(to: CGPoint(x: group.minX + 0.33514 * group.width, y: group.minY + 0.57418 * group.height), controlPoint1: CGPoint(x: group.minX + 0.37483 * group.width, y: group.minY + 0.62293 * group.height), controlPoint2: CGPoint(x: group.minX + 0.36160 * group.width, y: group.minY + 0.57411 * group.height))
        path.addCurve(to: CGPoint(x: group.minX + 0.29544 * group.width, y: group.minY + 0.72105 * group.height), controlPoint1: CGPoint(x: group.minX + 0.30867 * group.width, y: group.minY + 0.57425 * group.height), controlPoint2: CGPoint(x: group.minX + 0.29544 * group.width, y: group.minY + 0.62320 * group.height))
        path.addCurve(to: CGPoint(x: group.minX + 0.33514 * group.width, y: group.minY + 0.86543 * group.height), controlPoint1: CGPoint(x: group.minX + 0.29544 * group.width, y: group.minY + 0.81730 * group.height), controlPoint2: CGPoint(x: group.minX + 0.30867 * group.width, y: group.minY + 0.86543 * group.height))
        path.addLine(to: CGPoint(x: group.minX + 0.33514 * group.width, y: group.minY + 0.86501 * group.height))
        path.close()
        
        
        
        //// o 2 Drawing
        path.move(to: CGPoint(x: group.minX + 0.62113 * group.width, y: group.minY + 0.92542 * group.height))
        path.addCurve(to: CGPoint(x: group.minX + 0.54609 * group.width, y: group.minY + 1.00000 * group.height), controlPoint1: CGPoint(x: group.minX + 0.60278 * group.width, y: group.minY + 0.97521 * group.height), controlPoint2: CGPoint(x: group.minX + 0.57777 * group.width, y: group.minY + 1.00007 * group.height))
        path.addCurve(to: CGPoint(x: group.minX + 0.47073 * group.width, y: group.minY + 0.92542 * group.height), controlPoint1: CGPoint(x: group.minX + 0.51442 * group.width, y: group.minY + 0.99993 * group.height), controlPoint2: CGPoint(x: group.minX + 0.48930 * group.width, y: group.minY + 0.97507 * group.height))
        path.addCurve(to: CGPoint(x: group.minX + 0.44324 * group.width, y: group.minY + 0.71834 * group.height), controlPoint1: CGPoint(x: group.minX + 0.45243 * group.width, y: group.minY + 0.87598 * group.height), controlPoint2: CGPoint(x: group.minX + 0.44327 * group.width, y: group.minY + 0.80695 * group.height))
        path.addCurve(to: CGPoint(x: group.minX + 0.47055 * group.width, y: group.minY + 0.51231 * group.height), controlPoint1: CGPoint(x: group.minX + 0.44322 * group.width, y: group.minY + 0.62973 * group.height), controlPoint2: CGPoint(x: group.minX + 0.45232 * group.width, y: group.minY + 0.56106 * group.height))
        path.addCurve(to: CGPoint(x: group.minX + 0.54595 * group.width, y: group.minY + 0.43939 * group.height), controlPoint1: CGPoint(x: group.minX + 0.48875 * group.width, y: group.minY + 0.46370 * group.height), controlPoint2: CGPoint(x: group.minX + 0.51388 * group.width, y: group.minY + 0.43939 * group.height))
        path.addCurve(to: CGPoint(x: group.minX + 0.62135 * group.width, y: group.minY + 0.51231 * group.height), controlPoint1: CGPoint(x: group.minX + 0.57801 * group.width, y: group.minY + 0.43939 * group.height), controlPoint2: CGPoint(x: group.minX + 0.60315 * group.width, y: group.minY + 0.46370 * group.height))
        path.addCurve(to: CGPoint(x: group.minX + 0.64865 * group.width, y: group.minY + 0.71834 * group.height), controlPoint1: CGPoint(x: group.minX + 0.63955 * group.width, y: group.minY + 0.56092 * group.height), controlPoint2: CGPoint(x: group.minX + 0.64865 * group.width, y: group.minY + 0.62960 * group.height))
        path.addCurve(to: CGPoint(x: group.minX + 0.62113 * group.width, y: group.minY + 0.92542 * group.height), controlPoint1: CGPoint(x: group.minX + 0.64865 * group.width, y: group.minY + 0.80709 * group.height), controlPoint2: CGPoint(x: group.minX + 0.63947 * group.width, y: group.minY + 0.87612 * group.height))
        path.close()
        path.move(to: CGPoint(x: group.minX + 0.54609 * group.width, y: group.minY + 0.86511 * group.height))
        path.addCurve(to: CGPoint(x: group.minX + 0.58578 * group.width, y: group.minY + 0.72084 * group.height), controlPoint1: CGPoint(x: group.minX + 0.57255 * group.width, y: group.minY + 0.86511 * group.height), controlPoint2: CGPoint(x: group.minX + 0.58578 * group.width, y: group.minY + 0.81702 * group.height))
        path.addCurve(to: CGPoint(x: group.minX + 0.54609 * group.width, y: group.minY + 0.57501 * group.height), controlPoint1: CGPoint(x: group.minX + 0.58578 * group.width, y: group.minY + 0.62328 * group.height), controlPoint2: CGPoint(x: group.minX + 0.57255 * group.width, y: group.minY + 0.57467 * group.height))
        path.addCurve(to: CGPoint(x: group.minX + 0.50651 * group.width, y: group.minY + 0.72084 * group.height), controlPoint1: CGPoint(x: group.minX + 0.51963 * group.width, y: group.minY + 0.57536 * group.height), controlPoint2: CGPoint(x: group.minX + 0.50644 * group.width, y: group.minY + 0.62397 * group.height))
        path.addCurve(to: CGPoint(x: group.minX + 0.54609 * group.width, y: group.minY + 0.86511 * group.height), controlPoint1: CGPoint(x: group.minX + 0.50634 * group.width, y: group.minY + 0.81695 * group.height), controlPoint2: CGPoint(x: group.minX + 0.51953 * group.width, y: group.minY + 0.86504 * group.height))
        path.close()
        
        
        path.move(to: CGPoint(x: group.minX + 0.85946 * group.width, y: group.minY + 0.43621 * group.height))
        path.addLine(to: CGPoint(x: group.minX + 0.79021 * group.width, y: group.minY + 0.65247 * group.height))
        path.addLine(to: CGPoint(x: group.minX + 0.85641 * group.width, y: group.minY + 0.98474 * group.height))
        path.addLine(to: CGPoint(x: group.minX + 0.78693 * group.width, y: group.minY + 0.98474 * group.height))
        path.addLine(to: CGPoint(x: group.minX + 0.74916 * group.width, y: group.minY + 0.78119 * group.height))
        path.addLine(to: CGPoint(x: group.minX + 0.72709 * group.width, y: group.minY + 0.84978 * group.height))
        path.addLine(to: CGPoint(x: group.minX + 0.72709 * group.width, y: group.minY + 0.98485 * group.height))
        path.addLine(to: CGPoint(x: group.minX + 0.66486 * group.width, y: group.minY + 0.98485 * group.height))
        path.addLine(to: CGPoint(x: group.minX + 0.66486 * group.width, y: group.minY + 0.21212 * group.height))
        path.addLine(to: CGPoint(x: group.minX + 0.72717 * group.width, y: group.minY + 0.21212 * group.height))
        path.addLine(to: CGPoint(x: group.minX + 0.72717 * group.width, y: group.minY + 0.64612 * group.height))
        path.addLine(to: CGPoint(x: group.minX + 0.79131 * group.width, y: group.minY + 0.43621 * group.height))
        path.addLine(to: CGPoint(x: group.minX + 0.85946 * group.width, y: group.minY + 0.43621 * group.height))
        path.close()
        path.usesEvenOddFillRule = true
        
        
        path.move(to: CGPoint(x: group.minX + 0.93549 * group.width, y: group.minY + 0.00000 * group.height))
        path.addLine(to: CGPoint(x: group.minX + 0.93549 * group.width, y: group.minY + 0.18615 * group.height))
        path.addLine(to: CGPoint(x: group.minX + 1.00000 * group.width, y: group.minY + 0.18615 * group.height))
        path.addLine(to: CGPoint(x: group.minX + 1.00000 * group.width, y: group.minY + 0.31364 * group.height))
        path.addLine(to: CGPoint(x: group.minX + 0.93549 * group.width, y: group.minY + 0.31364 * group.height))
        path.addLine(to: CGPoint(x: group.minX + 0.93549 * group.width, y: group.minY + 0.50000 * group.height))
        path.addLine(to: CGPoint(x: group.minX + 0.89135 * group.width, y: group.minY + 0.50000 * group.height))
        path.addLine(to: CGPoint(x: group.minX + 0.89135 * group.width, y: group.minY + 0.31364 * group.height))
        path.addLine(to: CGPoint(x: group.minX + 0.82703 * group.width, y: group.minY + 0.31364 * group.height))
        path.addLine(to: CGPoint(x: group.minX + 0.82703 * group.width, y: group.minY + 0.18615 * group.height))
        path.addLine(to: CGPoint(x: group.minX + 0.89154 * group.width, y: group.minY + 0.18615 * group.height))
        path.addLine(to: CGPoint(x: group.minX + 0.89154 * group.width, y: group.minY + 0.00000 * group.height))
        path.addLine(to: CGPoint(x: group.minX + 0.93549 * group.width, y: group.minY + 0.00000 * group.height))
        path.close()
        path.usesEvenOddFillRule = true
        
        
        RookTextLayer.path = path.cgPath
        RookTextLayer.fillColor = RookColors.shared().rookMainBlue.cgColor
    }
}
