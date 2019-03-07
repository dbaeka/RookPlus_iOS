//
//  RookAnimatedLoadingButton.swift
//  Rook+
//
//  Created by Delmwin Baeka on 1/28/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

@IBDesignable
class RookAnimatedLoadingButton: UIButton {
    
    @IBInspectable var loaderColor: UIColor = RookColors.shared().rookWhite {
        didSet {
            circularLoader.strokeColor = loaderColor.cgColor
        }
    }
    
    @IBInspectable var loaderLineWidth: CGFloat = 2.0 {
        didSet {
            circularLoader.lineWidth = loaderLineWidth
            setNeedsLayout()
        }
    }
    
    @IBInspectable var textSize: CGFloat = 12 {
        didSet {
            text.font = UIFont(name: fontString, size: textSize)
        }
    }
    
    @IBInspectable var isAnimatable: Bool = true
    
    @IBInspectable var title: String = "Sign In"  {
        didSet {
            text.text = title
        }
    }
    
    @IBInspectable var fontString: String = "Roboto-Regular"
    
    private let circularLoader = CAShapeLayer()
    private let buttonShape = CAShapeLayer()
    private let animator = circularLoaderAnimator()
    
    private let text: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "Sign In"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont(name: "Roboto-Regular", size: 12)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var isAnimating = false
    
    convenience init() {
        self.init(frame: .zero)
        layer.addSublayer(buttonShape)
        layer.addSublayer(circularLoader)
        addSubview(text)
        self.setup()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(buttonShape)
        layer.addSublayer(circularLoader)
        addSubview(text)
        self.setup()
    }
    
    override var titleLabel: UILabel? {
        return nil
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        layer.addSublayer(buttonShape)
        layer.addSublayer(circularLoader)
        addSubview(text)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.addSublayer(buttonShape)
        layer.addSublayer(circularLoader)
        addSubview(text)
        self.setup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        layer.addSublayer(buttonShape)
        layer.addSublayer(circularLoader)
        addSubview(text)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    private func configureConstraint() {
        self.text.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        self.text.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        self.text.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        self.text.rightAnchor.constraint(equalTo: rightAnchor, constant: -5).isActive = true
    }
    
    private func setup() {
         configureConstraint()
        
        //// Color Declarations
        let fillColor3 = UIColor(red: 0.000, green: 0.290, blue: 0.937, alpha: 1.000)
        
        //// Frames
        let frame2 = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.width, height: bounds.width/2.34)
        
        //// Subframes
        let shape: CGRect = CGRect(x: frame2.minX, y: frame2.minY, width: frame2.width, height: frame2.height)
        
        //// RookButtonShape Drawing
        let rookButtonShapePath = UIBezierPath()
        rookButtonShapePath.move(to: CGPoint(x: shape.minX + 1.00000 * shape.width, y: shape.minY + 0.49383 * shape.height))
        rookButtonShapePath.addLine(to: CGPoint(x: shape.minX + 1.00000 * shape.width, y: shape.minY + 1.00000 * shape.height))
        rookButtonShapePath.addLine(to: CGPoint(x: shape.minX + 0.21316 * shape.width, y: shape.minY + 1.00000 * shape.height))
        rookButtonShapePath.addCurve(to: CGPoint(x: shape.minX + 0.00000 * shape.width, y: shape.minY + 0.50000 * shape.height), controlPoint1: CGPoint(x: shape.minX + 0.09543 * shape.width, y: shape.minY + 1.00000 * shape.height), controlPoint2: CGPoint(x: shape.minX + 0.00000 * shape.width, y: shape.minY + 0.77614 * shape.height))
        rookButtonShapePath.addCurve(to: CGPoint(x: shape.minX + 0.21316 * shape.width, y: shape.minY + 0.00000 * shape.height), controlPoint1: CGPoint(x: shape.minX + 0.00000 * shape.width, y: shape.minY + 0.22386 * shape.height), controlPoint2: CGPoint(x: shape.minX + 0.09543 * shape.width, y: shape.minY + 0.00000 * shape.height))
        rookButtonShapePath.addLine(to: CGPoint(x: shape.minX + 0.78684 * shape.width, y: shape.minY + 0.00000 * shape.height))
        rookButtonShapePath.addCurve(to: CGPoint(x: shape.minX + 0.99998 * shape.width, y: shape.minY + 0.49383 * shape.height), controlPoint1: CGPoint(x: shape.minX + 0.90369 * shape.width, y: shape.minY + 0.00000 * shape.height), controlPoint2: CGPoint(x: shape.minX + 0.99857 * shape.width, y: shape.minY + 0.22053 * shape.height))
        rookButtonShapePath.addLine(to: CGPoint(x: shape.minX + 1.00000 * shape.width, y: shape.minY + 0.49383 * shape.height))
        rookButtonShapePath.close()
        rookButtonShapePath.usesEvenOddFillRule = true
        buttonShape.path = rookButtonShapePath.cgPath
        buttonShape.fillColor = fillColor3.cgColor
        
        //Circular Loader
        circularLoader.strokeColor = loaderColor.cgColor
        circularLoader.frame = frame2
        let diameter = frame2.size.min - circularLoader.lineWidth
        let path = UIBezierPath(center: frame2.center, radius: diameter/3)
        circularLoader.path = path.cgPath
        circularLoader.fillColor = nil
        circularLoader.lineWidth = loaderLineWidth
        circularLoader.strokeStart = 0.0
        circularLoader.strokeEnd = 0.0
    }
    
    public func startAnimating() {
        guard !isAnimating else {
            return
        }
        
        animator.addAnimation(to: circularLoader)
        self.text.isHidden = true
        isAnimating = true
    }
    
    public func stopAnimating() {
        guard isAnimating else {
            return
        }
        
        animator.removeAnimation(from: circularLoader)
        self.text.isHidden = false
        isAnimating = false
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        if isAnimatable {
            self.startAnimating()
        }
        self.text.alpha = 0.5
        return super.beginTracking(touch, with: event)
    }
    
    override func cancelTracking(with event: UIEvent?) {
        super.cancelTracking(with: event)
        self.text.alpha = 1.0
        self.stopAnimating()
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        super.endTracking(touch, with: event)
        self.text.alpha = 1.0
    }
}


final class circularLoaderAnimator {
    enum Animation: String {
        var key: String {
            return rawValue
        }
        
        case spring = "Rook.circularLoader.spring"
        case rotation = "Rook.circularLoader.rotation"
    }
    
    public func addAnimation(to layer: CALayer) {
        layer.add(rotationAnimation(), forKey: Animation.rotation.key)
        layer.add(springAnimation(), forKey: Animation.spring.key)
    }
    
    public func removeAnimation(from layer: CALayer) {
        layer.removeAnimation(forKey: Animation.rotation.key)
        layer.removeAnimation(forKey: Animation.spring.key)
    }
    
    private func rotationAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(key: .rotationZ)
        animation.duration = 3
        animation.fromValue = 0
        animation.toValue = (2.0 * .pi)
        animation.repeatCount = .infinity
        
        return animation
    }
    
    private func strokeStartAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(key: .strokeStart)
        animation.duration = 1
        animation.fromValue = 0
        animation.toValue = 0.15
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        return animation
    }
    
    private func strokeEndAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(key: .strokeEnd)
        animation.duration = 1
        animation.fromValue = 0
        animation.toValue = 0.1
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        return animation
    }
    
    private func strokeCatchAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(key: .strokeStart)
        animation.beginTime = 1
        animation.duration = 0.5
        animation.fromValue = 0.15
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        return animation
    }
    
    private func strokeFreezeAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(key: .strokeEnd)
        animation.beginTime = 1
        animation.duration = 0.5
        animation.fromValue = 1
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        return animation
    }
    
    private func springAnimation() -> CAAnimationGroup {
        let animation = CAAnimationGroup()
        animation.duration = 1.5
        animation.animations = [strokeStartAnimation(), strokeEndAnimation(), strokeCatchAnimation(), strokeFreezeAnimation()]
        animation.repeatCount = .infinity
        
        return animation
    }
}
