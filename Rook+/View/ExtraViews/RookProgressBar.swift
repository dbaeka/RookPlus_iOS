//
//  RookProgressBar.swift
//  RookPlus
//
//  Created by Delmwin Baeka on 5/6/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

@IBDesignable
class RookProgressBar: UIView {
    
    @IBInspectable var tubeColor: UIColor = UIColor.white {
        didSet {
            tubeLayer.strokeColor = tubeColor.cgColor
        }
    }
    
    
    @IBInspectable var gaugeColor: UIColor = UIColor.red {
        didSet {
            gaugeLayer.strokeColor = gaugeColor.cgColor
        }
    }
    
    
    @IBInspectable var percentFill: Double = 0.5 {
        didSet {
            if (percentFill >= 0 && percentFill <= 1.0) {
                gaugeLayer.strokeEnd = CGFloat(percentFill)
            }
        }
    }
    
    private let tubeLayer = CAShapeLayer()
    private let gaugeLayer = CAShapeLayer()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.addSublayer(tubeLayer)
        layer.addSublayer(gaugeLayer)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(tubeLayer)
        layer.addSublayer(gaugeLayer)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.addSublayer(tubeLayer)
        layer.addSublayer(gaugeLayer)
        setup()
    }
    
    override open func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        layer.addSublayer(tubeLayer)
        layer.addSublayer(gaugeLayer)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    fileprivate func setup() {
        let width = bounds.width
        let height = bounds.height
        
        let frame: CGRect = CGRect(x: bounds.minX, y: bounds.midY, width: width, height: height)
        
        let pathPath = UIBezierPath()
        pathPath.move(to: CGPoint(x: height/2, y: frame.origin.y))
        pathPath.addLine(to: CGPoint(x: bounds.maxX - height/2, y: frame.origin.y))
        pathPath.usesEvenOddFillRule = true
        tubeLayer.path = pathPath.cgPath
        tubeLayer.strokeColor = tubeColor.cgColor
        tubeLayer.lineWidth = height
        tubeLayer.lineCap = .round
        
        let gaugePath = UIBezierPath()
        gaugePath.move(to: CGPoint(x: height/2, y: frame.origin.y))
        gaugePath.addLine(to: CGPoint(x: bounds.maxX - height/2, y: frame.origin.y))
        gaugePath.usesEvenOddFillRule = true
        gaugeLayer.path = gaugePath.cgPath
        gaugeLayer.strokeColor = gaugeColor.cgColor
        gaugeLayer.strokeEnd = CGFloat(percentFill)
        gaugeLayer.lineWidth = height
        gaugeLayer.lineCap = .round
    }
}

