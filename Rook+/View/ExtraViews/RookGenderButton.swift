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
    
    public enum Gender: String {
        case male = "MaleCard", female = "FemaleCard"
        
        var string: String {
            return rawValue
        }
    }
    
    private var coloredImage: UIImage? {
        guard let imageName = imageName else {return nil}
        return UIImage(named: imageName.string)
    }
    
    private var noirImage: UIImage? {
        guard let coloredImage = coloredImage else {return nil}
        return coloredImage.noir
    }
    
    var imageName: Gender?
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }

    private func setup() {
        layer.cornerRadius = frame.width/4
        layer.shadowOpacity = 0
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 4
        imageView?.contentMode = .scaleAspectFit
    }
    
    func setColor() {
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
