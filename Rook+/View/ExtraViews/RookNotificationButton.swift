//
//  NotificationButton.swift
//  Rook+
//
//  Created by Delmwin Baeka on 1/29/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

@IBDesignable
class RookNotificationButton: UIButton {
    
    private let notificationShape = CAShapeLayer()
    private let ovalShape = CAShapeLayer()
    
    @IBInspectable var color: UIColor = RookColors.shared().rookMainBlue {
        didSet {
            notificationShape.fillColor = color.cgColor
        }
    }
    
    @IBInspectable var isUnread: Bool = false {
        didSet {
            if isUnread {
                self.ovalShape.isHidden = false
            }
            else {
                self.ovalShape.isHidden = true
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    private func setup() {
        layer.addSublayer(notificationShape)
        layer.addSublayer(ovalShape)
        
        func fastFloor(_ x: CGFloat) -> CGFloat { return floor(x) }
        
        //// Subframes
        let page1: CGRect = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: frame.height)
        
        
        //// Page-1
        //// Notification Drawing
        let notificationPath = UIBezierPath()
        notificationPath.move(to: CGPoint(x: page1.minX + 0.98008 * page1.width, y: page1.minY + 0.70349 * page1.height))
        notificationPath.addCurve(to: CGPoint(x: page1.minX + 0.50286 * page1.width, y: page1.minY + 0.85000 * page1.height), controlPoint1: CGPoint(x: page1.minX + 0.98008 * page1.width, y: page1.minY + 0.70349 * page1.height), controlPoint2: CGPoint(x: page1.minX + 1.14902 * page1.width, y: page1.minY + 0.85000 * page1.height))
        notificationPath.addLine(to: CGPoint(x: page1.minX + 0.49714 * page1.width, y: page1.minY + 0.85000 * page1.height))
        notificationPath.addCurve(to: CGPoint(x: page1.minX + 0.01992 * page1.width, y: page1.minY + 0.70349 * page1.height), controlPoint1: CGPoint(x: page1.minX + -0.14902 * page1.width, y: page1.minY + 0.85000 * page1.height), controlPoint2: CGPoint(x: page1.minX + 0.01992 * page1.width, y: page1.minY + 0.70349 * page1.height))
        notificationPath.addLine(to: CGPoint(x: page1.minX + 0.22035 * page1.width, y: page1.minY + 0.52106 * page1.height))
        notificationPath.addCurve(to: CGPoint(x: page1.minX + 0.22035 * page1.width, y: page1.minY + 0.30836 * page1.height), controlPoint1: CGPoint(x: page1.minX + 0.22035 * page1.width, y: page1.minY + 0.52106 * page1.height), controlPoint2: CGPoint(x: page1.minX + 0.22035 * page1.width, y: page1.minY + 0.49321 * page1.height))
        notificationPath.addCurve(to: CGPoint(x: page1.minX + 0.45514 * page1.width, y: page1.minY + 0.09000 * page1.height), controlPoint1: CGPoint(x: page1.minX + 0.22035 * page1.width, y: page1.minY + 0.12350 * page1.height), controlPoint2: CGPoint(x: page1.minX + 0.45514 * page1.width, y: page1.minY + 0.09000 * page1.height))
        notificationPath.addCurve(to: CGPoint(x: page1.minX + 0.45514 * page1.width, y: page1.minY + 0.04440 * page1.height), controlPoint1: CGPoint(x: page1.minX + 0.45514 * page1.width, y: page1.minY + 0.09000 * page1.height), controlPoint2: CGPoint(x: page1.minX + 0.45514 * page1.width, y: page1.minY + 0.08476 * page1.height))
        notificationPath.addCurve(to: CGPoint(x: page1.minX + 0.50000 * page1.width, y: page1.minY + 0.00000 * page1.height), controlPoint1: CGPoint(x: page1.minX + 0.45652 * page1.width, y: page1.minY + 0.02273 * page1.height), controlPoint2: CGPoint(x: page1.minX + 0.47490 * page1.width, y: page1.minY + 0.00453 * page1.height))
        notificationPath.addCurve(to: CGPoint(x: page1.minX + 0.54247 * page1.width, y: page1.minY + 0.04440 * page1.height), controlPoint1: CGPoint(x: page1.minX + 0.52415 * page1.width, y: page1.minY + 0.00530 * page1.height), controlPoint2: CGPoint(x: page1.minX + 0.54139 * page1.width, y: page1.minY + 0.02331 * page1.height))
        notificationPath.addCurve(to: CGPoint(x: page1.minX + 0.54247 * page1.width, y: page1.minY + 0.09000 * page1.height), controlPoint1: CGPoint(x: page1.minX + 0.54247 * page1.width, y: page1.minY + 0.08637 * page1.height), controlPoint2: CGPoint(x: page1.minX + 0.54247 * page1.width, y: page1.minY + 0.09000 * page1.height))
        notificationPath.addCurve(to: CGPoint(x: page1.minX + 0.77726 * page1.width, y: page1.minY + 0.30836 * page1.height), controlPoint1: CGPoint(x: page1.minX + 0.54247 * page1.width, y: page1.minY + 0.09000 * page1.height), controlPoint2: CGPoint(x: page1.minX + 0.77726 * page1.width, y: page1.minY + 0.12350 * page1.height))
        notificationPath.addCurve(to: CGPoint(x: page1.minX + 0.77726 * page1.width, y: page1.minY + 0.52106 * page1.height), controlPoint1: CGPoint(x: page1.minX + 0.77726 * page1.width, y: page1.minY + 0.49321 * page1.height), controlPoint2: CGPoint(x: page1.minX + 0.77726 * page1.width, y: page1.minY + 0.52106 * page1.height))
        notificationPath.addLine(to: CGPoint(x: page1.minX + 0.98008 * page1.width, y: page1.minY + 0.70349 * page1.height))
        notificationPath.close()
        notificationPath.move(to: CGPoint(x: page1.minX + 0.50000 * page1.width, y: page1.minY + 1.00000 * page1.height))
        notificationPath.addCurve(to: CGPoint(x: page1.minX + 0.43539 * page1.width, y: page1.minY + 0.96920 * page1.height), controlPoint1: CGPoint(x: page1.minX + 0.47530 * page1.width, y: page1.minY + 0.99916 * page1.height), controlPoint2: CGPoint(x: page1.minX + 0.45198 * page1.width, y: page1.minY + 0.98805 * page1.height))
        notificationPath.addCurve(to: CGPoint(x: page1.minX + 0.41196 * page1.width, y: page1.minY + 0.90000 * page1.height), controlPoint1: CGPoint(x: page1.minX + 0.41880 * page1.width, y: page1.minY + 0.95035 * page1.height), controlPoint2: CGPoint(x: page1.minX + 0.41034 * page1.width, y: page1.minY + 0.92538 * page1.height))
        notificationPath.addLine(to: CGPoint(x: page1.minX + 0.58804 * page1.width, y: page1.minY + 0.90000 * page1.height))
        notificationPath.addCurve(to: CGPoint(x: page1.minX + 0.56461 * page1.width, y: page1.minY + 0.96920 * page1.height), controlPoint1: CGPoint(x: page1.minX + 0.58966 * page1.width, y: page1.minY + 0.92538 * page1.height), controlPoint2: CGPoint(x: page1.minX + 0.58120 * page1.width, y: page1.minY + 0.95035 * page1.height))
        notificationPath.addCurve(to: CGPoint(x: page1.minX + 0.50000 * page1.width, y: page1.minY + 1.00000 * page1.height), controlPoint1: CGPoint(x: page1.minX + 0.54802 * page1.width, y: page1.minY + 0.98805 * page1.height), controlPoint2: CGPoint(x: page1.minX + 0.52470 * page1.width, y: page1.minY + 0.99916 * page1.height))
        notificationPath.close()
        notificationPath.usesEvenOddFillRule = true
        notificationShape.path = notificationPath.cgPath
        notificationShape.fillColor = color.cgColor
        
        
        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalIn: CGRect(x: page1.minX + fastFloor(page1.width * 0.53846 + 0.5), y: page1.minY + fastFloor(page1.height * 0.00000 + 0.5), width: fastFloor(page1.width * 1.00000 + 0.5) - fastFloor(page1.width * 0.53846 + 0.5), height: fastFloor(page1.height * 0.38710 + 0.5) - fastFloor(page1.height * 0.00000 + 0.5)))
        ovalShape.path = ovalPath.cgPath
        ovalShape.fillColor = UIColor.red.cgColor
        
        ovalShape.isHidden = true
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        notificationShape.opacity = 0.5
        ovalShape.opacity = 0.5
        return super.beginTracking(touch, with: event)
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        notificationShape.opacity = 1.0
        ovalShape.opacity = 1.0
    }
    
    override func cancelTracking(with event: UIEvent?) {
        notificationShape.opacity = 1.0
        ovalShape.opacity = 1.0
    }
}
