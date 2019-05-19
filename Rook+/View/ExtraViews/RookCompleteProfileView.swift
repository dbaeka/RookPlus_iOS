//
//  CompleteProfileView.swift
//  Rook+
//
//  Created by Delmwin Baeka on 2/18/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

@IBDesignable
class RookCompleteProfile: UIView {
    
    @IBInspectable var gradientColor1: UIColor =  {
        return UIColor(red: 0.016, green: 0.314, blue: 0.914, alpha: 1.000)
    }()
    
    @IBInspectable var gradientColor2: UIColor =  {
        return UIColor(red: 0.000, green: 0.863, blue: 0.808, alpha: 1.000)
    }()
    
    private let maskLayer = CAShapeLayer()
    private let gradientLayer = CAGradientLayer()
    private let circleLayer = CAShapeLayer()
    private let percentTextLayer = CATextLayer()
    private let textLayer = CATextLayer()
    
    @IBInspectable var fontString: String = "Roboto-Bold"
    
    private var titleFont: UIFont {
        guard let robotoFont = UIFont(name: self.fontString, size: 18) else {
            return UIFont.systemFont(ofSize: 18)
        }
        return robotoFont
    }
    
    @IBInspectable var percent: Int = 100  {
        didSet {
            self.percentTextLayer.string =  String(percent)+"%"
        }
    }
    
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    fileprivate func setup() {
        layer.addSublayer(gradientLayer)
        layer.addSublayer(maskLayer)
        layer.addSublayer(circleLayer)
        layer.addSublayer(percentTextLayer)
        layer.addSublayer(textLayer)
        
        
        func fastFloor(_ x: CGFloat) -> CGFloat { return floor(x) }
        
        
        //// Color Declarations
        let color = UIColor(red: 0.000, green: 0.290, blue: 0.937, alpha: 1.000)
        let width = bounds.width
        let height = width/4.851
        
        let group20: CGRect = CGRect(x: bounds.minX, y: bounds.midY-height/2, width: width, height: height)
        
        
        let pathPath = UIBezierPath()
        pathPath.move(to: CGPoint(x: group20.minX + 0.79308 * group20.width, y: group20.minY + 0.49291 * group20.height))
        pathPath.addCurve(to: CGPoint(x: group20.minX + 0.81316 * group20.width, y: group20.minY + 0.19697 * group20.height), controlPoint1: CGPoint(x: group20.minX + 0.79305 * group20.width, y: group20.minY + 0.38677 * group20.height), controlPoint2: CGPoint(x: group20.minX + 0.80007 * group20.width, y: group20.minY + 0.28327 * group20.height))
        pathPath.addLine(to: CGPoint(x: group20.minX + 0.06419 * group20.width, y: group20.minY + 0.19697 * group20.height))
        pathPath.addCurve(to: CGPoint(x: group20.minX + 0.00000 * group20.width, y: group20.minY + 0.50000 * group20.height), controlPoint1: CGPoint(x: group20.minX + 0.02874 * group20.width, y: group20.minY + 0.19697 * group20.height), controlPoint2: CGPoint(x: group20.minX + 0.00000 * group20.width, y: group20.minY + 0.33264 * group20.height))
        pathPath.addCurve(to: CGPoint(x: group20.minX + 0.06419 * group20.width, y: group20.minY + 0.80303 * group20.height), controlPoint1: CGPoint(x: group20.minX + -0.00000 * group20.width, y: group20.minY + 0.66736 * group20.height), controlPoint2: CGPoint(x: group20.minX + 0.02874 * group20.width, y: group20.minY + 0.80303 * group20.height))
        pathPath.addLine(to: CGPoint(x: group20.minX + 0.81538 * group20.width, y: group20.minY + 0.80303 * group20.height))
        pathPath.addCurve(to: CGPoint(x: group20.minX + 0.79308 * group20.width, y: group20.minY + 0.49291 * group20.height), controlPoint1: CGPoint(x: group20.minX + 0.80088 * group20.width, y: group20.minY + 0.71418 * group20.height), controlPoint2: CGPoint(x: group20.minX + 0.79303 * group20.width, y: group20.minY + 0.60510 * group20.height))
        pathPath.close()
        pathPath.usesEvenOddFillRule = true
        maskLayer.path = pathPath.cgPath
        
        gradientLayer.frame = frame
        gradientLayer.position = CGPoint(x: 0, y: 0)
        gradientLayer.anchorPoint = CGPoint(x: 0, y: 0)
        gradientLayer.colors = [gradientColor1.cgColor, gradientColor2.cgColor]
        gradientLayer.locations = [0, 1]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.mask = maskLayer
        
        let shapePath = UIBezierPath()
        shapePath.move(to: CGPoint(x: group20.minX + 0.89692 * group20.width, y: group20.minY + 0.06211 * group20.height))
        shapePath.addCurve(to: CGPoint(x: group20.minX + 0.98720 * group20.width, y: group20.minY + 0.50000 * group20.height), controlPoint1: CGPoint(x: group20.minX + 0.94678 * group20.width, y: group20.minY + 0.06211 * group20.height), controlPoint2: CGPoint(x: group20.minX + 0.98720 * group20.width, y: group20.minY + 0.25816 * group20.height))
        shapePath.addCurve(to: CGPoint(x: group20.minX + 0.89692 * group20.width, y: group20.minY + 0.93789 * group20.height), controlPoint1: CGPoint(x: group20.minX + 0.98720 * group20.width, y: group20.minY + 0.74184 * group20.height), controlPoint2: CGPoint(x: group20.minX + 0.94678 * group20.width, y: group20.minY + 0.93789 * group20.height))
        shapePath.addCurve(to: CGPoint(x: group20.minX + 0.80665 * group20.width, y: group20.minY + 0.50000 * group20.height), controlPoint1: CGPoint(x: group20.minX + 0.84707 * group20.width, y: group20.minY + 0.93789 * group20.height), controlPoint2: CGPoint(x: group20.minX + 0.80665 * group20.width, y: group20.minY + 0.74184 * group20.height))
        shapePath.addCurve(to: CGPoint(x: group20.minX + 0.89692 * group20.width, y: group20.minY + 0.06211 * group20.height), controlPoint1: CGPoint(x: group20.minX + 0.80671 * group20.width, y: group20.minY + 0.25827 * group20.height), controlPoint2: CGPoint(x: group20.minX + 0.84709 * group20.width, y: group20.minY + 0.06239 * group20.height))
        shapePath.close()
        shapePath.move(to: CGPoint(x: group20.minX + 0.89692 * group20.width, y: group20.minY + 0.00000 * group20.height))
        shapePath.addCurve(to: CGPoint(x: group20.minX + 0.79385 * group20.width, y: group20.minY + 0.50000 * group20.height), controlPoint1: CGPoint(x: group20.minX + 0.84000 * group20.width, y: group20.minY + 0.00000 * group20.height), controlPoint2: CGPoint(x: group20.minX + 0.79385 * group20.width, y: group20.minY + 0.22386 * group20.height))
        shapePath.addCurve(to: CGPoint(x: group20.minX + 0.89692 * group20.width, y: group20.minY + 1.00000 * group20.height), controlPoint1: CGPoint(x: group20.minX + 0.79385 * group20.width, y: group20.minY + 0.77614 * group20.height), controlPoint2: CGPoint(x: group20.minX + 0.84000 * group20.width, y: group20.minY + 1.00000 * group20.height))
        shapePath.addCurve(to: CGPoint(x: group20.minX + 1.00000 * group20.width, y: group20.minY + 0.50000 * group20.height), controlPoint1: CGPoint(x: group20.minX + 0.95385 * group20.width, y: group20.minY + 1.00000 * group20.height), controlPoint2: CGPoint(x: group20.minX + 1.00000 * group20.width, y: group20.minY + 0.77614 * group20.height))
        shapePath.addCurve(to: CGPoint(x: group20.minX + 0.89692 * group20.width, y: group20.minY + 0.00000 * group20.height), controlPoint1: CGPoint(x: group20.minX + 1.00000 * group20.width, y: group20.minY + 0.22386 * group20.height), controlPoint2: CGPoint(x: group20.minX + 0.95385 * group20.width, y: group20.minY + 0.00000 * group20.height))
        shapePath.close()
        circleLayer.path = shapePath.cgPath
        circleLayer.fillColor = color.cgColor
        
        let gradientBounds = pathPath.cgPath.boundingBox
        //TextDrawing
        let circleWidth = shapePath.cgPath.boundingBox.height
        percentTextLayer.frame = CGRect(x: 0, y: 0, width: circleWidth, height: circleWidth)
        percentTextLayer.position = CGPoint(x: shapePath.cgPath.boundingBox.minX+circleWidth/2, y: gradientBounds.midY+circleWidth/3)
        percentTextLayer.needsDisplayOnBoundsChange = true
        percentTextLayer.string = String(self.percent)+"%"
        percentTextLayer.fontSize = circleWidth/3.6
        percentTextLayer.foregroundColor = UIColor.black.cgColor
        percentTextLayer.contentsScale = UIScreen.main.scale
        percentTextLayer.font = self.titleFont
        percentTextLayer.isWrapped = true
        percentTextLayer.alignmentMode = CATextLayerAlignmentMode.center
        
        //TextDrawing
        
        textLayer.frame = CGRect(x: 0, y: 0, width: gradientBounds.width, height: gradientBounds.height/2)
        textLayer.position = CGPoint(x: gradientBounds.minX + gradientBounds.width/2.3, y: gradientBounds.midY)
        textLayer.needsDisplayOnBoundsChange = true
        textLayer.string = "Complete your profile"
        textLayer.fontSize = gradientBounds.height/2.5
        textLayer.foregroundColor = UIColor.white.cgColor
        textLayer.contentsScale = UIScreen.main.scale
        textLayer.font = self.titleFont
        textLayer.isWrapped = true
        textLayer.alignmentMode = CATextLayerAlignmentMode.center
    }
}
