//
//  RookRoundButton.swift
//  Rook+
//
//  Created by Delmwin Baeka on 1/28/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit


@IBDesignable
class RookRoundButton: UIButton {
    
    @IBInspectable var isShadowOn: Bool = false {
        didSet {
            activateShadow()
        }
    }
    
    @IBInspectable var marginLabel: CGFloat = 0.0 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
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
    
    private func setup() {
        layer.cornerRadius = frame.height/2
        activateShadow()
    }
    
    private func activateShadow(){
        if isShadowOn {
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 3, height: 3)
            layer.shadowRadius = 4
            layer.shadowOpacity = 0.3
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let superRect = super.titleRect(forContentRect: contentRect)
        var rect = CGRect(x: superRect.origin.x, y: superRect.origin.y, width: superRect.width, height: superRect.height)
        if self.marginLabel != 0.0 {
            rect.origin.x = self.marginLabel
        }
        return rect
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        self.titleLabel?.alpha = 0.5
        return super.beginTracking(touch, with: event)
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        self.titleLabel?.alpha = 1.0
    }
    
    override func cancelTracking(with event: UIEvent?) {
        self.titleLabel?.alpha = 1.0
    }
}
