//
//  barRook.swift
//  Rook+
//
//  Created by Delmwin Baeka on 1/22/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

@IBDesignable
class barRook: UIView {
    
    private let RookTextLayer = CAShapeLayer()
    private let barLayer = CAShapeLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.addSublayer(barLayer)
        layer.addSublayer(RookTextLayer)
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        layer.addSublayer(barLayer)
        layer.addSublayer(RookTextLayer)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(barLayer)
        layer.addSublayer(RookTextLayer)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.addSublayer(barLayer)
        layer.addSublayer(RookTextLayer)
        setup()
    }
    
    
    func setup() {
        
        let barRookWidth: CGFloat = bounds.width
        let barRookHeight: CGFloat = barRookWidth / 3.69
        
        //// General Declarations
        // This non-generic function dramatically improves compilation times of complex expressions.
        func fastFloor(_ x: CGFloat) -> CGFloat { return floor(x) }
        
        
        //// Frames
        let frame = CGRect(x: 0, y: 0, width: barRookWidth, height: barRookHeight)
        
        //// Subframes
        let rook: CGRect = CGRect(x: frame.minX + fastFloor((frame.width + 1) * 0.26119 + 0.5), y: frame.minY + 1, width: frame.width + 1 - fastFloor((frame.width + 1) * 0.26119 + 0.5), height: fastFloor((frame.height - 1) * 1.00000 + 0.5))
        let barFrame = CGRect(x: frame.minX, y: frame.minY + fastFloor(frame.height * 0.83333 + 0.5), width: fastFloor((frame.width) * 0.18797 + 0.5), height: fastFloor(frame.height * 1.00000 + 0.5) - fastFloor(frame.height * 0.83333 + 0.5))
        
        let leftBarRectanglePath = UIBezierPath(rect: CGRect(x: barFrame.minX, y: barFrame.minY + 1, width: fastFloor((barFrame.width) * 1.00000 + 0.5), height: barFrame.height - 1))
        barLayer.path = leftBarRectanglePath.cgPath
        barLayer.fillColor = RookColors.shared().rookWhite.cgColor
        
        
        //// Rook+
        //// R Drawing
        let rookPath = UIBezierPath()
        rookPath.move(to: CGPoint(x: rook.minX + 0.22699 * rook.width, y: rook.minY + 0.48642 * rook.height))
        rookPath.addCurve(to: CGPoint(x: rook.minX + 0.17612 * rook.width, y: rook.minY + 0.70263 * rook.height), controlPoint1: CGPoint(x: rook.minX + 0.22799 * rook.width, y: rook.minY + 0.58224 * rook.height), controlPoint2: CGPoint(x: rook.minX + 0.20753 * rook.width, y: rook.minY + 0.66922 * rook.height))
        rookPath.addLine(to: CGPoint(x: rook.minX + 0.22212 * rook.width, y: rook.minY + 0.98485 * rook.height))
        rookPath.addLine(to: CGPoint(x: rook.minX + 0.15056 * rook.width, y: rook.minY + 0.98485 * rook.height))
        rookPath.addLine(to: CGPoint(x: rook.minX + 0.11275 * rook.width, y: rook.minY + 0.72073 * rook.height))
        rookPath.addLine(to: CGPoint(x: rook.minX + 0.06787 * rook.width, y: rook.minY + 0.72073 * rook.height))
        rookPath.addLine(to: CGPoint(x: rook.minX + 0.06787 * rook.width, y: rook.minY + 0.98485 * rook.height))
        rookPath.addLine(to: CGPoint(x: rook.minX + 0.00000 * rook.width, y: rook.minY + 0.98485 * rook.height))
        rookPath.addLine(to: CGPoint(x: rook.minX + 0.00000 * rook.width, y: rook.minY + 0.24242 * rook.height))
        rookPath.addLine(to: CGPoint(x: rook.minX + 0.13705 * rook.width, y: rook.minY + 0.24242 * rook.height))
        rookPath.addCurve(to: CGPoint(x: rook.minX + 0.20325 * rook.width, y: rook.minY + 0.31194 * rook.height), controlPoint1: CGPoint(x: rook.minX + 0.16548 * rook.width, y: rook.minY + 0.24242 * rook.height), controlPoint2: CGPoint(x: rook.minX + 0.18755 * rook.width, y: rook.minY + 0.26560 * rook.height))
        rookPath.addCurve(to: CGPoint(x: rook.minX + 0.22699 * rook.width, y: rook.minY + 0.48642 * rook.height), controlPoint1: CGPoint(x: rook.minX + 0.21908 * rook.width, y: rook.minY + 0.35853 * rook.height), controlPoint2: CGPoint(x: rook.minX + 0.22765 * rook.width, y: rook.minY + 0.42147 * rook.height))
        rookPath.close()
        rookPath.move(to: CGPoint(x: rook.minX + 0.06787 * rook.width, y: rook.minY + 0.39306 * rook.height))
        rookPath.addLine(to: CGPoint(x: rook.minX + 0.06787 * rook.width, y: rook.minY + 0.57020 * rook.height))
        rookPath.addLine(to: CGPoint(x: rook.minX + 0.12280 * rook.width, y: rook.minY + 0.57020 * rook.height))
        rookPath.addCurve(to: CGPoint(x: rook.minX + 0.15804 * rook.width, y: rook.minY + 0.48110 * rook.height), controlPoint1: CGPoint(x: rook.minX + 0.14627 * rook.width, y: rook.minY + 0.57020 * rook.height), controlPoint2: CGPoint(x: rook.minX + 0.15801 * rook.width, y: rook.minY + 0.54050 * rook.height))
        rookPath.addCurve(to: CGPoint(x: rook.minX + 0.14914 * rook.width, y: rook.minY + 0.41637 * rook.height), controlPoint1: CGPoint(x: rook.minX + 0.15851 * rook.width, y: rook.minY + 0.45685 * rook.height), controlPoint2: CGPoint(x: rook.minX + 0.15526 * rook.width, y: rook.minY + 0.43321 * rook.height))
        rookPath.addCurve(to: CGPoint(x: rook.minX + 0.12280 * rook.width, y: rook.minY + 0.39306 * rook.height), controlPoint1: CGPoint(x: rook.minX + 0.14319 * rook.width, y: rook.minY + 0.40083 * rook.height), controlPoint2: CGPoint(x: rook.minX + 0.13441 * rook.width, y: rook.minY + 0.39306 * rook.height))
        rookPath.addLine(to: CGPoint(x: rook.minX + 0.06787 * rook.width, y: rook.minY + 0.39306 * rook.height))
        
        /// 1st o drawing
        rookPath.move(to: CGPoint(x: rook.minX + 0.41035 * rook.width, y: rook.minY + 0.92578 * rook.height))
        rookPath.addCurve(to: CGPoint(x: rook.minX + 0.33514 * rook.width, y: rook.minY + 1.00000 * rook.height), controlPoint1: CGPoint(x: rook.minX + 0.39201 * rook.width, y: rook.minY + 0.97533 * rook.height), controlPoint2: CGPoint(x: rook.minX + 0.36693 * rook.width, y: rook.minY + 1.00007 * rook.height))
        rookPath.addCurve(to: CGPoint(x: rook.minX + 0.25992 * rook.width, y: rook.minY + 0.92578 * rook.height), controlPoint1: CGPoint(x: rook.minX + 0.30334 * rook.width, y: rook.minY + 0.99993 * rook.height), controlPoint2: CGPoint(x: rook.minX + 0.27826 * rook.width, y: rook.minY + 0.97519 * rook.height))
        rookPath.addCurve(to: CGPoint(x: rook.minX + 0.23243 * rook.width, y: rook.minY + 0.71855 * rook.height), controlPoint1: CGPoint(x: rook.minX + 0.24159 * rook.width, y: rook.minY + 0.87630 * rook.height), controlPoint2: CGPoint(x: rook.minX + 0.23243 * rook.width, y: rook.minY + 0.80722 * rook.height))
        rookPath.addCurve(to: CGPoint(x: rook.minX + 0.25973 * rook.width, y: rook.minY + 0.51236 * rook.height), controlPoint1: CGPoint(x: rook.minX + 0.23243 * rook.width, y: rook.minY + 0.62988 * rook.height), controlPoint2: CGPoint(x: rook.minX + 0.24153 * rook.width, y: rook.minY + 0.56115 * rook.height))
        rookPath.addCurve(to: CGPoint(x: rook.minX + 0.33514 * rook.width, y: rook.minY + 0.43939 * rook.height), controlPoint1: CGPoint(x: rook.minX + 0.27794 * rook.width, y: rook.minY + 0.46372 * rook.height), controlPoint2: CGPoint(x: rook.minX + 0.30307 * rook.width, y: rook.minY + 0.43939 * rook.height))
        rookPath.addCurve(to: CGPoint(x: rook.minX + 0.41054 * rook.width, y: rook.minY + 0.51236 * rook.height), controlPoint1: CGPoint(x: rook.minX + 0.36720 * rook.width, y: rook.minY + 0.43939 * rook.height), controlPoint2: CGPoint(x: rook.minX + 0.39233 * rook.width, y: rook.minY + 0.46372 * rook.height))
        rookPath.addCurve(to: CGPoint(x: rook.minX + 0.43784 * rook.width, y: rook.minY + 0.71855 * rook.height), controlPoint1: CGPoint(x: rook.minX + 0.42874 * rook.width, y: rook.minY + 0.56101 * rook.height), controlPoint2: CGPoint(x: rook.minX + 0.43784 * rook.width, y: rook.minY + 0.62974 * rook.height))
        rookPath.addCurve(to: CGPoint(x: rook.minX + 0.41035 * rook.width, y: rook.minY + 0.92578 * rook.height), controlPoint1: CGPoint(x: rook.minX + 0.43784 * rook.width, y: rook.minY + 0.80736 * rook.height), controlPoint2: CGPoint(x: rook.minX + 0.42868 * rook.width, y: rook.minY + 0.87644 * rook.height))
        rookPath.close()
        rookPath.move(to: CGPoint(x: rook.minX + 0.33514 * rook.width, y: rook.minY + 0.86501 * rook.height))
        rookPath.addCurve(to: CGPoint(x: rook.minX + 0.37483 * rook.width, y: rook.minY + 0.72064 * rook.height), controlPoint1: CGPoint(x: rook.minX + 0.36160 * rook.width, y: rook.minY + 0.86501 * rook.height), controlPoint2: CGPoint(x: rook.minX + 0.37483 * rook.width, y: rook.minY + 0.81688 * rook.height))
        rookPath.addCurve(to: CGPoint(x: rook.minX + 0.33514 * rook.width, y: rook.minY + 0.57418 * rook.height), controlPoint1: CGPoint(x: rook.minX + 0.37483 * rook.width, y: rook.minY + 0.62293 * rook.height), controlPoint2: CGPoint(x: rook.minX + 0.36160 * rook.width, y: rook.minY + 0.57411 * rook.height))
        rookPath.addCurve(to: CGPoint(x: rook.minX + 0.29544 * rook.width, y: rook.minY + 0.72105 * rook.height), controlPoint1: CGPoint(x: rook.minX + 0.30867 * rook.width, y: rook.minY + 0.57425 * rook.height), controlPoint2: CGPoint(x: rook.minX + 0.29544 * rook.width, y: rook.minY + 0.62320 * rook.height))
        rookPath.addCurve(to: CGPoint(x: rook.minX + 0.33514 * rook.width, y: rook.minY + 0.86543 * rook.height), controlPoint1: CGPoint(x: rook.minX + 0.29544 * rook.width, y: rook.minY + 0.81730 * rook.height), controlPoint2: CGPoint(x: rook.minX + 0.30867 * rook.width, y: rook.minY + 0.86543 * rook.height))
        rookPath.addLine(to: CGPoint(x: rook.minX + 0.33514 * rook.width, y: rook.minY + 0.86501 * rook.height))
        
        /// 2nd o drawing
        rookPath.move(to: CGPoint(x: rook.minX + 0.62113 * rook.width, y: rook.minY + 0.92542 * rook.height))
        rookPath.addCurve(to: CGPoint(x: rook.minX + 0.54609 * rook.width, y: rook.minY + 1.00000 * rook.height), controlPoint1: CGPoint(x: rook.minX + 0.60278 * rook.width, y: rook.minY + 0.97521 * rook.height), controlPoint2: CGPoint(x: rook.minX + 0.57777 * rook.width, y: rook.minY + 1.00007 * rook.height))
        rookPath.addCurve(to: CGPoint(x: rook.minX + 0.47073 * rook.width, y: rook.minY + 0.92542 * rook.height), controlPoint1: CGPoint(x: rook.minX + 0.51442 * rook.width, y: rook.minY + 0.99993 * rook.height), controlPoint2: CGPoint(x: rook.minX + 0.48930 * rook.width, y: rook.minY + 0.97507 * rook.height))
        rookPath.addCurve(to: CGPoint(x: rook.minX + 0.44324 * rook.width, y: rook.minY + 0.71834 * rook.height), controlPoint1: CGPoint(x: rook.minX + 0.45243 * rook.width, y: rook.minY + 0.87598 * rook.height), controlPoint2: CGPoint(x: rook.minX + 0.44327 * rook.width, y: rook.minY + 0.80695 * rook.height))
        rookPath.addCurve(to: CGPoint(x: rook.minX + 0.47055 * rook.width, y: rook.minY + 0.51231 * rook.height), controlPoint1: CGPoint(x: rook.minX + 0.44322 * rook.width, y: rook.minY + 0.62973 * rook.height), controlPoint2: CGPoint(x: rook.minX + 0.45232 * rook.width, y: rook.minY + 0.56106 * rook.height))
        rookPath.addCurve(to: CGPoint(x: rook.minX + 0.54595 * rook.width, y: rook.minY + 0.43939 * rook.height), controlPoint1: CGPoint(x: rook.minX + 0.48875 * rook.width, y: rook.minY + 0.46370 * rook.height), controlPoint2: CGPoint(x: rook.minX + 0.51388 * rook.width, y: rook.minY + 0.43939 * rook.height))
        rookPath.addCurve(to: CGPoint(x: rook.minX + 0.62135 * rook.width, y: rook.minY + 0.51231 * rook.height), controlPoint1: CGPoint(x: rook.minX + 0.57801 * rook.width, y: rook.minY + 0.43939 * rook.height), controlPoint2: CGPoint(x: rook.minX + 0.60315 * rook.width, y: rook.minY + 0.46370 * rook.height))
        rookPath.addCurve(to: CGPoint(x: rook.minX + 0.64865 * rook.width, y: rook.minY + 0.71834 * rook.height), controlPoint1: CGPoint(x: rook.minX + 0.63955 * rook.width, y: rook.minY + 0.56092 * rook.height), controlPoint2: CGPoint(x: rook.minX + 0.64865 * rook.width, y: rook.minY + 0.62960 * rook.height))
        rookPath.addCurve(to: CGPoint(x: rook.minX + 0.62113 * rook.width, y: rook.minY + 0.92542 * rook.height), controlPoint1: CGPoint(x: rook.minX + 0.64865 * rook.width, y: rook.minY + 0.80709 * rook.height), controlPoint2: CGPoint(x: rook.minX + 0.63947 * rook.width, y: rook.minY + 0.87612 * rook.height))
        rookPath.close()
        rookPath.move(to: CGPoint(x: rook.minX + 0.54609 * rook.width, y: rook.minY + 0.86511 * rook.height))
        rookPath.addCurve(to: CGPoint(x: rook.minX + 0.58578 * rook.width, y: rook.minY + 0.72084 * rook.height), controlPoint1: CGPoint(x: rook.minX + 0.57255 * rook.width, y: rook.minY + 0.86511 * rook.height), controlPoint2: CGPoint(x: rook.minX + 0.58578 * rook.width, y: rook.minY + 0.81702 * rook.height))
        rookPath.addCurve(to: CGPoint(x: rook.minX + 0.54609 * rook.width, y: rook.minY + 0.57501 * rook.height), controlPoint1: CGPoint(x: rook.minX + 0.58578 * rook.width, y: rook.minY + 0.62328 * rook.height), controlPoint2: CGPoint(x: rook.minX + 0.57255 * rook.width, y: rook.minY + 0.57467 * rook.height))
        rookPath.addCurve(to: CGPoint(x: rook.minX + 0.50651 * rook.width, y: rook.minY + 0.72084 * rook.height), controlPoint1: CGPoint(x: rook.minX + 0.51963 * rook.width, y: rook.minY + 0.57536 * rook.height), controlPoint2: CGPoint(x: rook.minX + 0.50644 * rook.width, y: rook.minY + 0.62397 * rook.height))
        rookPath.addCurve(to: CGPoint(x: rook.minX + 0.54609 * rook.width, y: rook.minY + 0.86511 * rook.height), controlPoint1: CGPoint(x: rook.minX + 0.50634 * rook.width, y: rook.minY + 0.81695 * rook.height), controlPoint2: CGPoint(x: rook.minX + 0.51953 * rook.width, y: rook.minY + 0.86504 * rook.height))
        
        
        /// k drawing
        rookPath.move(to: CGPoint(x: rook.minX + 0.85946 * rook.width, y: rook.minY + 0.43621 * rook.height))
        rookPath.addLine(to: CGPoint(x: rook.minX + 0.79021 * rook.width, y: rook.minY + 0.65247 * rook.height))
        rookPath.addLine(to: CGPoint(x: rook.minX + 0.85641 * rook.width, y: rook.minY + 0.98474 * rook.height))
        rookPath.addLine(to: CGPoint(x: rook.minX + 0.78693 * rook.width, y: rook.minY + 0.98474 * rook.height))
        rookPath.addLine(to: CGPoint(x: rook.minX + 0.74916 * rook.width, y: rook.minY + 0.78119 * rook.height))
        rookPath.addLine(to: CGPoint(x: rook.minX + 0.72709 * rook.width, y: rook.minY + 0.84978 * rook.height))
        rookPath.addLine(to: CGPoint(x: rook.minX + 0.72709 * rook.width, y: rook.minY + 0.98485 * rook.height))
        rookPath.addLine(to: CGPoint(x: rook.minX + 0.66486 * rook.width, y: rook.minY + 0.98485 * rook.height))
        rookPath.addLine(to: CGPoint(x: rook.minX + 0.66486 * rook.width, y: rook.minY + 0.21212 * rook.height))
        rookPath.addLine(to: CGPoint(x: rook.minX + 0.72717 * rook.width, y: rook.minY + 0.21212 * rook.height))
        rookPath.addLine(to: CGPoint(x: rook.minX + 0.72717 * rook.width, y: rook.minY + 0.64612 * rook.height))
        rookPath.addLine(to: CGPoint(x: rook.minX + 0.79131 * rook.width, y: rook.minY + 0.43621 * rook.height))
        rookPath.addLine(to: CGPoint(x: rook.minX + 0.85946 * rook.width, y: rook.minY + 0.43621 * rook.height))
        
        rookPath.move(to: CGPoint(x: rook.minX + 0.93549 * rook.width, y: rook.minY + 0.00000 * rook.height))
        rookPath.addLine(to: CGPoint(x: rook.minX + 0.93549 * rook.width, y: rook.minY + 0.18615 * rook.height))
        rookPath.addLine(to: CGPoint(x: rook.minX + 1.00000 * rook.width, y: rook.minY + 0.18615 * rook.height))
        rookPath.addLine(to: CGPoint(x: rook.minX + 1.00000 * rook.width, y: rook.minY + 0.31364 * rook.height))
        rookPath.addLine(to: CGPoint(x: rook.minX + 0.93549 * rook.width, y: rook.minY + 0.31364 * rook.height))
        rookPath.addLine(to: CGPoint(x: rook.minX + 0.93549 * rook.width, y: rook.minY + 0.50000 * rook.height))
        rookPath.addLine(to: CGPoint(x: rook.minX + 0.89135 * rook.width, y: rook.minY + 0.50000 * rook.height))
        rookPath.addLine(to: CGPoint(x: rook.minX + 0.89135 * rook.width, y: rook.minY + 0.31364 * rook.height))
        rookPath.addLine(to: CGPoint(x: rook.minX + 0.82703 * rook.width, y: rook.minY + 0.31364 * rook.height))
        rookPath.addLine(to: CGPoint(x: rook.minX + 0.82703 * rook.width, y: rook.minY + 0.18615 * rook.height))
        rookPath.addLine(to: CGPoint(x: rook.minX + 0.89154 * rook.width, y: rook.minY + 0.18615 * rook.height))
        rookPath.addLine(to: CGPoint(x: rook.minX + 0.89154 * rook.width, y: rook.minY + 0.00000 * rook.height))
        rookPath.addLine(to: CGPoint(x: rook.minX + 0.93549 * rook.width, y: rook.minY + 0.00000 * rook.height))
        rookPath.close()
        
        rookPath.usesEvenOddFillRule = true
        RookTextLayer.path = rookPath.cgPath
        RookTextLayer.fillColor = RookColors.shared().rookWhite.cgColor
        
        barLayer.zPosition = 10
        RookTextLayer.zPosition = 10
    }
    
}
