//
//  rookLogoVector.swift
//  Rook+
//
//  Created by Delmwin Baeka on 1/21/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

public class RookLogoVector : NSObject {
    //// Drawing Methods
    
    @objc dynamic public class func drawRookLogo(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 295, height: 142), resizing: ResizingBehavior = .aspectFit, logoSize: CGFloat = 1) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 295, height: 142), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 295, y: resizedFrame.height / 142)
        
        
        //// Rook+
        context.saveGState()
        context.translateBy(x: 46, y: 29)
        context.scaleBy(x: logoSize, y: logoSize)
        
        
        
        //// R Drawing
        let rPath = UIBezierPath()
        rPath.move(to: CGPoint(x: 41.99, y: 32.1))
        rPath.addCurve(to: CGPoint(x: 32.58, y: 46.37), controlPoint1: CGPoint(x: 42.18, y: 38.43), controlPoint2: CGPoint(x: 38.39, y: 44.17))
        rPath.addLine(to: CGPoint(x: 41.09, y: 65))
        rPath.addLine(to: CGPoint(x: 27.85, y: 65))
        rPath.addLine(to: CGPoint(x: 20.86, y: 47.57))
        rPath.addLine(to: CGPoint(x: 12.56, y: 47.57))
        rPath.addLine(to: CGPoint(x: 12.56, y: 65))
        rPath.addLine(to: CGPoint(x: 0, y: 65))
        rPath.addLine(to: CGPoint(x: 0, y: 16))
        rPath.addLine(to: CGPoint(x: 25.35, y: 16))
        rPath.addCurve(to: CGPoint(x: 37.6, y: 20.59), controlPoint1: CGPoint(x: 30.61, y: 16), controlPoint2: CGPoint(x: 34.7, y: 17.53))
        rPath.addCurve(to: CGPoint(x: 41.99, y: 32.1), controlPoint1: CGPoint(x: 40.53, y: 23.66), controlPoint2: CGPoint(x: 42.11, y: 27.82))
        rPath.close()
        rPath.move(to: CGPoint(x: 12.56, y: 25.94))
        rPath.addLine(to: CGPoint(x: 12.56, y: 37.63))
        rPath.addLine(to: CGPoint(x: 22.72, y: 37.63))
        rPath.addCurve(to: CGPoint(x: 29.24, y: 31.75), controlPoint1: CGPoint(x: 27.06, y: 37.63), controlPoint2: CGPoint(x: 29.23, y: 35.67))
        rPath.addCurve(to: CGPoint(x: 27.59, y: 27.48), controlPoint1: CGPoint(x: 29.32, y: 30.15), controlPoint2: CGPoint(x: 28.72, y: 28.59))
        rPath.addCurve(to: CGPoint(x: 22.72, y: 25.94), controlPoint1: CGPoint(x: 26.49, y: 26.45), controlPoint2: CGPoint(x: 24.87, y: 25.94))
        rPath.addLine(to: CGPoint(x: 12.56, y: 25.94))
        rPath.close()
        RookColors.shared().rookBlue.setFill()
        rPath.fill()
        
        
        //// o Drawing
        let oPath = UIBezierPath()
        oPath.move(to: CGPoint(x: 75.92, y: 61.1))
        oPath.addCurve(to: CGPoint(x: 62, y: 66), controlPoint1: CGPoint(x: 72.52, y: 64.37), controlPoint2: CGPoint(x: 67.88, y: 66))
        oPath.addCurve(to: CGPoint(x: 48.08, y: 61.1), controlPoint1: CGPoint(x: 56.12, y: 66), controlPoint2: CGPoint(x: 51.48, y: 64.36))
        oPath.addCurve(to: CGPoint(x: 43, y: 47.42), controlPoint1: CGPoint(x: 44.69, y: 57.84), controlPoint2: CGPoint(x: 43, y: 53.28))
        oPath.addCurve(to: CGPoint(x: 48.05, y: 33.82), controlPoint1: CGPoint(x: 43, y: 41.57), controlPoint2: CGPoint(x: 44.68, y: 37.04))
        oPath.addCurve(to: CGPoint(x: 62, y: 29), controlPoint1: CGPoint(x: 51.42, y: 30.61), controlPoint2: CGPoint(x: 56.07, y: 29))
        oPath.addCurve(to: CGPoint(x: 75.95, y: 33.82), controlPoint1: CGPoint(x: 67.93, y: 29), controlPoint2: CGPoint(x: 72.58, y: 30.61))
        oPath.addCurve(to: CGPoint(x: 81, y: 47.42), controlPoint1: CGPoint(x: 79.32, y: 37.03), controlPoint2: CGPoint(x: 81, y: 41.56))
        oPath.addCurve(to: CGPoint(x: 75.92, y: 61.1), controlPoint1: CGPoint(x: 81, y: 53.29), controlPoint2: CGPoint(x: 79.31, y: 57.85))
        oPath.close()
        oPath.move(to: CGPoint(x: 62, y: 57.09))
        oPath.addCurve(to: CGPoint(x: 69.34, y: 47.56), controlPoint1: CGPoint(x: 66.9, y: 57.09), controlPoint2: CGPoint(x: 69.34, y: 53.91))
        oPath.addCurve(to: CGPoint(x: 62, y: 37.9), controlPoint1: CGPoint(x: 69.34, y: 41.11), controlPoint2: CGPoint(x: 66.9, y: 37.89))
        oPath.addCurve(to: CGPoint(x: 54.66, y: 47.59), controlPoint1: CGPoint(x: 57.1, y: 37.9), controlPoint2: CGPoint(x: 54.66, y: 41.13))
        oPath.addCurve(to: CGPoint(x: 62, y: 57.12), controlPoint1: CGPoint(x: 54.66, y: 53.94), controlPoint2: CGPoint(x: 57.1, y: 57.12))
        oPath.addLine(to: CGPoint(x: 62, y: 57.09))
        oPath.close()
        RookColors.shared().rookBlue.setFill()
        oPath.fill()
        
        
        //// o 2 Drawing
        let o2Path = UIBezierPath()
        o2Path.move(to: CGPoint(x: 114.91, y: 61.08))
        o2Path.addCurve(to: CGPoint(x: 101.03, y: 66), controlPoint1: CGPoint(x: 111.51, y: 64.36), controlPoint2: CGPoint(x: 106.89, y: 66))
        o2Path.addCurve(to: CGPoint(x: 87.08, y: 61.08), controlPoint1: CGPoint(x: 95.17, y: 66), controlPoint2: CGPoint(x: 90.52, y: 64.35))
        o2Path.addCurve(to: CGPoint(x: 82, y: 47.41), controlPoint1: CGPoint(x: 83.7, y: 57.81), controlPoint2: CGPoint(x: 82, y: 53.26))
        o2Path.addCurve(to: CGPoint(x: 87.05, y: 33.81), controlPoint1: CGPoint(x: 82, y: 41.56), controlPoint2: CGPoint(x: 83.68, y: 37.03))
        o2Path.addCurve(to: CGPoint(x: 101, y: 29), controlPoint1: CGPoint(x: 90.42, y: 30.6), controlPoint2: CGPoint(x: 95.07, y: 29))
        o2Path.addCurve(to: CGPoint(x: 114.95, y: 33.81), controlPoint1: CGPoint(x: 106.93, y: 29), controlPoint2: CGPoint(x: 111.58, y: 30.6))
        o2Path.addCurve(to: CGPoint(x: 120, y: 47.41), controlPoint1: CGPoint(x: 118.32, y: 37.02), controlPoint2: CGPoint(x: 120, y: 41.55))
        o2Path.addCurve(to: CGPoint(x: 114.91, y: 61.08), controlPoint1: CGPoint(x: 120, y: 53.27), controlPoint2: CGPoint(x: 118.3, y: 57.82))
        o2Path.close()
        o2Path.move(to: CGPoint(x: 101.03, y: 57.1))
        o2Path.addCurve(to: CGPoint(x: 108.37, y: 47.58), controlPoint1: CGPoint(x: 105.92, y: 57.1), controlPoint2: CGPoint(x: 108.37, y: 53.92))
        o2Path.addCurve(to: CGPoint(x: 101.03, y: 37.95), controlPoint1: CGPoint(x: 108.37, y: 41.14), controlPoint2: CGPoint(x: 105.92, y: 37.93))
        o2Path.addCurve(to: CGPoint(x: 93.7, y: 47.58), controlPoint1: CGPoint(x: 96.13, y: 37.97), controlPoint2: CGPoint(x: 93.69, y: 41.18))
        o2Path.addCurve(to: CGPoint(x: 101.03, y: 57.1), controlPoint1: CGPoint(x: 93.67, y: 53.92), controlPoint2: CGPoint(x: 96.11, y: 57.09))
        o2Path.close()
        RookColors.shared().rookBlue.setFill()
        o2Path.fill()
        
        
        //// k Drawing
        let kPath = UIBezierPath()
        kPath.move(to: CGPoint(x: 159, y: 28.79))
        kPath.addLine(to: CGPoint(x: 146.19, y: 43.06))
        kPath.addLine(to: CGPoint(x: 158.44, y: 64.99))
        kPath.addLine(to: CGPoint(x: 145.58, y: 64.99))
        kPath.addLine(to: CGPoint(x: 138.59, y: 51.56))
        kPath.addLine(to: CGPoint(x: 134.51, y: 56.09))
        kPath.addLine(to: CGPoint(x: 134.51, y: 65))
        kPath.addLine(to: CGPoint(x: 123, y: 65))
        kPath.addLine(to: CGPoint(x: 123, y: 14))
        kPath.addLine(to: CGPoint(x: 134.53, y: 14))
        kPath.addLine(to: CGPoint(x: 134.53, y: 42.64))
        kPath.addLine(to: CGPoint(x: 146.39, y: 28.79))
        kPath.addLine(to: CGPoint(x: 159, y: 28.79))
        kPath.close()
        kPath.usesEvenOddFillRule = true
        RookColors.shared().rookBlue.setFill()
        kPath.fill()
        
        
        //// Bezier + 6 Drawing
        let bezier6Path = UIBezierPath()
        bezier6Path.move(to: CGPoint(x: 173.07, y: 0))
        bezier6Path.addLine(to: CGPoint(x: 173.07, y: 12.29))
        bezier6Path.addLine(to: CGPoint(x: 185, y: 12.29))
        bezier6Path.addLine(to: CGPoint(x: 185, y: 20.7))
        bezier6Path.addLine(to: CGPoint(x: 173.07, y: 20.7))
        bezier6Path.addLine(to: CGPoint(x: 173.07, y: 33))
        bezier6Path.addLine(to: CGPoint(x: 164.9, y: 33))
        bezier6Path.addLine(to: CGPoint(x: 164.9, y: 20.7))
        bezier6Path.addLine(to: CGPoint(x: 153, y: 20.7))
        bezier6Path.addLine(to: CGPoint(x: 153, y: 12.29))
        bezier6Path.addLine(to: CGPoint(x: 164.93, y: 12.29))
        bezier6Path.addLine(to: CGPoint(x: 164.93, y: 0))
        bezier6Path.addLine(to: CGPoint(x: 173.07, y: 0))
        bezier6Path.close()
        bezier6Path.usesEvenOddFillRule = true
        RookColors.shared().rookBlue.setFill()
        bezier6Path.fill()
        
        
        
        context.restoreGState()
        
        context.restoreGState()
        
    }
    
    
    
    
    @objc(RookLogoVectorResizingBehavior)
    public enum ResizingBehavior: Int {
        case aspectFit /// The content is proportionally resized to fit into the target rectangle.
        case aspectFill /// The content is proportionally resized to completely fill the target rectangle.
        case stretch /// The content is stretched to match the entire target rectangle.
        case center /// The content is centered in the target rectangle, but it is NOT resized.
        
        public func apply(rect: CGRect, target: CGRect) -> CGRect {
            if rect == target || target == CGRect.zero {
                return rect
            }
            
            var scales = CGSize.zero
            scales.width = abs(target.width / rect.width)
            scales.height = abs(target.height / rect.height)
            
            switch self {
            case .aspectFit:
                scales.width = min(scales.width, scales.height)
                scales.height = scales.width
            case .aspectFill:
                scales.width = max(scales.width, scales.height)
                scales.height = scales.width
            case .stretch:
                break
            case .center:
                scales.width = 1
                scales.height = 1
            }
            
            var result = rect.standardized
            result.size.width *= scales.width
            result.size.height *= scales.height
            result.origin.x = target.minX + (target.width - result.width) / 2
            result.origin.y = target.minY + (target.height - result.height) / 2
            return result
        }
    }
}

