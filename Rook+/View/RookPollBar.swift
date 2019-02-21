//
//  RookPollBar.swift
//  Rook+
//
//  Created by Delmwin Baeka on 2/16/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

@IBDesignable
class RookPollBar: UIView {
    
    @IBInspectable var topColor: UIColor = UIColor(hexString: "#FF6D00") {
        didSet{
            TopLayer.strokeColor = topColor.cgColor
        }
    }
    
    @IBInspectable var bottomColor: UIColor = UIColor(hexString: "#D60000") {
        didSet{
            BottomLayer.strokeColor = bottomColor.cgColor
        }
    }
    
    @IBInspectable var fill: CGFloat = 0.6 {
        didSet {
            self.TopLayer.strokeEnd = fill
            self.BottomLayer.strokeEnd = 1 - fill
        }
    }
    
    private let TopLayer = CAShapeLayer()
    private let BottomLayer = CAShapeLayer()
    
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
        layer.frame = self.bounds
        
        let bottomPath = UIBezierPath()
        bottomPath.move(to: CGPoint(x: frame.midX, y: frame.maxY))
        bottomPath.addLine(to: CGPoint(x: frame.midX, y: frame.minY))
        BottomLayer.path = bottomPath.cgPath
        BottomLayer.lineWidth = frame.width
        
        let topPath = UIBezierPath()
        topPath.move(to: CGPoint(x: frame.midX, y: frame.minY))
        topPath.addLine(to: CGPoint(x: frame.midX, y: frame.maxY))
        TopLayer.path = topPath.cgPath
        TopLayer.lineWidth = frame.width
        
    }
    
    fileprivate func setup() {
        layer.addSublayer(TopLayer)
        layer.addSublayer(BottomLayer)
        
        //// bar
        //// Bottom Drawing
        
        
        BottomLayer.strokeColor = bottomColor.cgColor
        BottomLayer.strokeEnd = fill
        
        
        //// Top Drawing
       
        TopLayer.strokeColor = topColor.cgColor
        TopLayer.strokeEnd = 1 - fill
        
    }
}

