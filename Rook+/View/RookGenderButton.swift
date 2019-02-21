//
//  RookGenderButton.swift
//  Rook+
//
//  Created by Delmwin Baeka on 1/29/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

@IBDesignable
class RookGenderButton: UIButton {
    
    private var coloredImage: UIImage?
    private var noirImage: UIImage?
    
    @IBInspectable var isActive: Bool = false {
        didSet {
            setColor()
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
    
    private func setup() {
        layer.cornerRadius = bounds.width/4
        coloredImage = self.imageView?.image
        noirImage = coloredImage?.noir
        
        layer.shadowOpacity = 0
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 4
        
        setColor()
    }
    
    private func setColor() {
        if isActive {
            saturate()
        } else {
            desaturate()
        }
    }
    
    private func desaturate() {
        self.setImage(noirImage, for: .normal)
        layer.shadowOpacity = 0
    }
    
    private func saturate(){
        self.setImage(coloredImage, for: .normal)
        layer.shadowOpacity = 0.4
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        self.isActive = !isActive
        return super.beginTracking(touch, with: event)
    }
}
