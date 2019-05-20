//
//  RookCheckMark.swift
//  Rook+
//
//  Created by Delmwin Baeka on 1/30/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

@IBDesignable
class RookCheckMark: UIView {
    
    @IBInspectable var isOn: Bool = false {
        didSet {
            updateColors()
        }
    }
    
    private var fillColor: UIColor {
        if !isOn {
            return UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
        }
        else {
            return UIColor(red: 110/255, green: 234/255, blue: 116/255, alpha: 1.000)
        }
    }
    
    private var strokeColor: UIColor {
        if !isOn {
            return UIColor(red: 0.443, green: 0.651, blue: 0.690, alpha: 1.000)
        }
        else {
            return UIColor.white
        }
    }
    
    private let ovalShape = CAShapeLayer()
    private let checkMarkShape = CAShapeLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.addSublayer(ovalShape)
        layer.addSublayer(checkMarkShape)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(ovalShape)
        layer.addSublayer(checkMarkShape)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.addSublayer(ovalShape)
        layer.addSublayer(checkMarkShape)
        setup()
    }
    
    override open func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        layer.addSublayer(ovalShape)
        layer.addSublayer(checkMarkShape)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    fileprivate func updateColors() {
        ovalShape.fillColor = fillColor.cgColor
        checkMarkShape.strokeColor = strokeColor.cgColor
    }
    
    fileprivate func setup() {
        backgroundColor = .clear
        
        func fastFloor(_ x: CGFloat) -> CGFloat { return floor(x) }
        
        //// Frames
        let outerFrame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        
        //// Subframes
        let insideFrame = CGRect(x: outerFrame.minX + fastFloor(outerFrame.width * 0.24242 + 0.5), y: outerFrame.minY + fastFloor(outerFrame.height * 0.27273 + 0.5), width: fastFloor(outerFrame.width * 0.75758 + 0.5) - fastFloor(outerFrame.width * 0.24242 + 0.5), height: fastFloor(outerFrame.height * 0.72727 + 0.5) - fastFloor(outerFrame.height * 0.27273 + 0.5))
        let checkMark: CGRect = CGRect(x: insideFrame.minX + 1, y: insideFrame.minY + 1, width: insideFrame.width - 2, height: insideFrame.height - 2)
        
        
        //// CheckOval
        //// Oval 2 Drawing
        let ovalPath = UIBezierPath(ovalIn: CGRect(x: outerFrame.minX, y: outerFrame.minY, width: outerFrame.width, height: outerFrame.height))
        ovalShape.path = ovalPath.cgPath
        
        
        //// CheckMark
        //// Check Drawing
        let checkPath = UIBezierPath()
        checkPath.move(to: CGPoint(x: checkMark.minX + 0.00000 * checkMark.width, y: checkMark.minY + 0.46596 * checkMark.height))
        checkPath.addLine(to: CGPoint(x: checkMark.minX + 0.37449 * checkMark.width, y: checkMark.minY + 1.00000 * checkMark.height))
        checkPath.addLine(to: CGPoint(x: checkMark.minX + 1.00000 * checkMark.width, y: checkMark.minY + 0.00000 * checkMark.height))
        checkMarkShape.path = checkPath.cgPath
        checkMarkShape.miterLimit = 4
        checkMarkShape.lineCap = .round
        checkMarkShape.lineWidth = bounds.width/25
        checkMarkShape.fillColor = nil
        
        updateColors()

    }
}
