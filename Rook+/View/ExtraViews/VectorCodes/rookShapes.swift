//
//  rookShapes.swift
//  Rook+
//
//  Created by Delmwin Baeka on 1/21/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

@IBDesignable
class circleShape: UIView {
    
    let circleLayer = CAShapeLayer()
    
    @IBInspectable var color: UIColor = RookColors.shared().rookDeepBlue {
        didSet {
            self.circleLayer.fillColor = color.cgColor
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
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    func setup() {
        self.cornerRadius = bounds.width/2
        layer.addSublayer(circleLayer)
       
        let frame = CGRect(x: 0, y: 0, width: 400, height: 400)
        let circlePath = UIBezierPath(ovalIn: frame)
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = color.cgColor
    }
}

@IBDesignable
class loginGradient: UIView {
    
    private let maskLayer = CAShapeLayer()
    private let gradientLayer = CAGradientLayer()
    
    @IBInspectable var gradientColor1: UIColor =  {
        return UIColor(red: 0.000, green: 0.314, blue: 0.914, alpha: 1.000)
    }()
    
    @IBInspectable var gradientColor2: UIColor =  {
        return UIColor(red: 0.000, green: 0.914, blue: 0.800, alpha: 1.000)
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.addSublayer(gradientLayer)
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        layer.addSublayer(gradientLayer)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(gradientLayer)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.addSublayer(gradientLayer)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    func setup() {
        
        let frame = bounds
        let width = frame.width
        let height = frame.height
        
        let pathPath = UIBezierPath()
        pathPath.move(to: CGPoint(x: frame.minX, y: frame.minY))
        pathPath.addLine(to: CGPoint(x: frame.minX + width, y: frame.minY))
        pathPath.addLine(to: CGPoint(x: frame.minX + width, y: frame.minY + height/3.6))
        pathPath.addCurve(to: CGPoint(x: frame.minX + width/1.4, y: frame.minY + height/1.7), controlPoint1: CGPoint(x: frame.minX + width, y: frame.minY + height/3.6), controlPoint2: CGPoint(x: frame.minX + width, y: frame.minY + height/1.8))
        pathPath.addCurve(to: CGPoint(x: frame.minX + width/3.7, y: frame.minY + height/1.2), controlPoint1: CGPoint(x: frame.minX + width/2, y: frame.minY + height/1.6), controlPoint2: CGPoint(x: frame.minX + width/2.9, y: frame.minY + height/1.4))
        pathPath.addCurve(to: CGPoint(x: frame.minX, y: frame.minY + height), controlPoint1: CGPoint(x: frame.minX + width/5.4, y: frame.minY + height), controlPoint2: CGPoint(x: frame.minX, y: frame.minY + height))
        pathPath.addLine(to: CGPoint(x: frame.minX, y: frame.minY))
        pathPath.close()
        pathPath.usesEvenOddFillRule = true
        
        maskLayer.path = pathPath.cgPath
        
        gradientLayer.frame = frame
        gradientLayer.position = CGPoint(x: 0, y: 0)
        gradientLayer.anchorPoint = CGPoint(x: 0, y: 0)
        gradientLayer.colors = [gradientColor1.cgColor, gradientColor2.cgColor]
        gradientLayer.locations = [0, 1]
        gradientLayer.startPoint = CGPoint(x: 0.8, y: 0.1)
        gradientLayer.endPoint = CGPoint(x: 0.4, y: 1.1)
        gradientLayer.mask = maskLayer
        
        gradientLayer.zPosition = 5
    }
}

@IBDesignable
class spiralShape: UIView {
    
    private let spiralLayer = CAShapeLayer()
    private let maskLayer = CAShapeLayer()
    let strokeStartAnimation = CABasicAnimation()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.addSublayer(spiralLayer)
        setup()
    
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        layer.addSublayer(spiralLayer)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(spiralLayer)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.addSublayer(spiralLayer)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    func setup() {
        
        
        let width = bounds.width
        let height = bounds.height
        
        //// Frames
        let frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        //// Subframes
        let spiralFrame: CGRect = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: frame.height)
        
        let spiralPath = UIBezierPath()
        spiralPath.move(to: CGPoint(x: spiralFrame.minX + 0.00000 * spiralFrame.width, y: spiralFrame.minY + 1.00000 * spiralFrame.height))
        spiralPath.addCurve(to: CGPoint(x: spiralFrame.minX + 0.03921 * spiralFrame.width, y: spiralFrame.minY + 0.98262 * spiralFrame.height), controlPoint1: CGPoint(x: spiralFrame.minX + 0.01309 * spiralFrame.width, y: spiralFrame.minY + 0.99423 * spiralFrame.height), controlPoint2: CGPoint(x: spiralFrame.minX + 0.02623 * spiralFrame.width, y: spiralFrame.minY + 0.98869 * spiralFrame.height))
        spiralPath.addCurve(to: CGPoint(x: spiralFrame.minX + 0.07773 * spiralFrame.width, y: spiralFrame.minY + 0.96349 * spiralFrame.height), controlPoint1: CGPoint(x: spiralFrame.minX + 0.05218 * spiralFrame.width, y: spiralFrame.minY + 0.97654 * spiralFrame.height), controlPoint2: CGPoint(x: spiralFrame.minX + 0.06512 * spiralFrame.width, y: spiralFrame.minY + 0.97051 * spiralFrame.height))
        spiralPath.addCurve(to: CGPoint(x: spiralFrame.minX + 0.11456 * spiralFrame.width, y: spiralFrame.minY + 0.94039 * spiralFrame.height), controlPoint1: CGPoint(x: spiralFrame.minX + 0.09034 * spiralFrame.width, y: spiralFrame.minY + 0.95646 * spiralFrame.height), controlPoint2: CGPoint(x: spiralFrame.minX + 0.10269 * spiralFrame.width, y: spiralFrame.minY + 0.94894 * spiralFrame.height))
        spiralPath.addCurve(to: CGPoint(x: spiralFrame.minX + 0.12337 * spiralFrame.width, y: spiralFrame.minY + 0.93378 * spiralFrame.height), controlPoint1: CGPoint(x: spiralFrame.minX + 0.11750 * spiralFrame.width, y: spiralFrame.minY + 0.93816 * spiralFrame.height), controlPoint2: CGPoint(x: spiralFrame.minX + 0.12049 * spiralFrame.width, y: spiralFrame.minY + 0.93610 * spiralFrame.height))
        spiralPath.addLine(to: CGPoint(x: spiralFrame.minX + 0.13197 * spiralFrame.width, y: spiralFrame.minY + 0.92673 * spiralFrame.height))
        spiralPath.addLine(to: CGPoint(x: spiralFrame.minX + 0.14028 * spiralFrame.width, y: spiralFrame.minY + 0.91927 * spiralFrame.height))
        spiralPath.addCurve(to: CGPoint(x: spiralFrame.minX + 0.14830 * spiralFrame.width, y: spiralFrame.minY + 0.91134 * spiralFrame.height), controlPoint1: CGPoint(x: spiralFrame.minX + 0.14303 * spiralFrame.width, y: spiralFrame.minY + 0.91675 * spiralFrame.height), controlPoint2: CGPoint(x: spiralFrame.minX + 0.14562 * spiralFrame.width, y: spiralFrame.minY + 0.91397 * spiralFrame.height))
        spiralPath.addCurve(to: CGPoint(x: spiralFrame.minX + 0.17723 * spiralFrame.width, y: spiralFrame.minY + 0.87550 * spiralFrame.height), controlPoint1: CGPoint(x: spiralFrame.minX + 0.15879 * spiralFrame.width, y: spiralFrame.minY + 0.90062 * spiralFrame.height), controlPoint2: CGPoint(x: spiralFrame.minX + 0.16848 * spiralFrame.width, y: spiralFrame.minY + 0.88862 * spiralFrame.height))
        spiralPath.addCurve(to: CGPoint(x: spiralFrame.minX + 0.20059 * spiralFrame.width, y: spiralFrame.minY + 0.83319 * spiralFrame.height), controlPoint1: CGPoint(x: spiralFrame.minX + 0.18590 * spiralFrame.width, y: spiralFrame.minY + 0.86227 * spiralFrame.height), controlPoint2: CGPoint(x: spiralFrame.minX + 0.19371 * spiralFrame.width, y: spiralFrame.minY + 0.84812 * spiralFrame.height))
        spiralPath.addCurve(to: CGPoint(x: spiralFrame.minX + 0.23581 * spiralFrame.width, y: spiralFrame.minY + 0.73764 * spiralFrame.height), controlPoint1: CGPoint(x: spiralFrame.minX + 0.21459 * spiralFrame.width, y: spiralFrame.minY + 0.80342 * spiralFrame.height), controlPoint2: CGPoint(x: spiralFrame.minX + 0.22543 * spiralFrame.width, y: spiralFrame.minY + 0.77076 * spiralFrame.height))
        spiralPath.addCurve(to: CGPoint(x: spiralFrame.minX + 0.26760 * spiralFrame.width, y: spiralFrame.minY + 0.63687 * spiralFrame.height), controlPoint1: CGPoint(x: spiralFrame.minX + 0.24620 * spiralFrame.width, y: spiralFrame.minY + 0.70452 * spiralFrame.height), controlPoint2: CGPoint(x: spiralFrame.minX + 0.25587 * spiralFrame.width, y: spiralFrame.minY + 0.67038 * spiralFrame.height))
        spiralPath.addCurve(to: CGPoint(x: spiralFrame.minX + 0.30828 * spiralFrame.width, y: spiralFrame.minY + 0.53963 * spiralFrame.height), controlPoint1: CGPoint(x: spiralFrame.minX + 0.27919 * spiralFrame.width, y: spiralFrame.minY + 0.60311 * spiralFrame.height), controlPoint2: CGPoint(x: spiralFrame.minX + 0.29279 * spiralFrame.width, y: spiralFrame.minY + 0.57059 * spiralFrame.height))
        spiralPath.addCurve(to: CGPoint(x: spiralFrame.minX + 0.36263 * spiralFrame.width, y: spiralFrame.minY + 0.45307 * spiralFrame.height), controlPoint1: CGPoint(x: spiralFrame.minX + 0.32397 * spiralFrame.width, y: spiralFrame.minY + 0.50830 * spiralFrame.height), controlPoint2: CGPoint(x: spiralFrame.minX + 0.34220 * spiralFrame.width, y: spiralFrame.minY + 0.47928 * spiralFrame.height))
        spiralPath.addCurve(to: CGPoint(x: spiralFrame.minX + 0.37859 * spiralFrame.width, y: spiralFrame.minY + 0.43408 * spiralFrame.height), controlPoint1: CGPoint(x: spiralFrame.minX + 0.36780 * spiralFrame.width, y: spiralFrame.minY + 0.44653 * spiralFrame.height), controlPoint2: CGPoint(x: spiralFrame.minX + 0.37312 * spiralFrame.width, y: spiralFrame.minY + 0.44020 * spiralFrame.height))
        spiralPath.addCurve(to: CGPoint(x: spiralFrame.minX + 0.38696 * spiralFrame.width, y: spiralFrame.minY + 0.42517 * spiralFrame.height), controlPoint1: CGPoint(x: spiralFrame.minX + 0.38134 * spiralFrame.width, y: spiralFrame.minY + 0.43104 * spiralFrame.height), controlPoint2: CGPoint(x: spiralFrame.minX + 0.38418 * spiralFrame.width, y: spiralFrame.minY + 0.42812 * spiralFrame.height))
        spiralPath.addLine(to: CGPoint(x: spiralFrame.minX + 0.39115 * spiralFrame.width, y: spiralFrame.minY + 0.42072 * spiralFrame.height))
        spiralPath.addCurve(to: CGPoint(x: spiralFrame.minX + 0.39545 * spiralFrame.width, y: spiralFrame.minY + 0.41649 * spiralFrame.height), controlPoint1: CGPoint(x: spiralFrame.minX + 0.39255 * spiralFrame.width, y: spiralFrame.minY + 0.41923 * spiralFrame.height), controlPoint2: CGPoint(x: spiralFrame.minX + 0.39403 * spiralFrame.width, y: spiralFrame.minY + 0.41790 * spiralFrame.height))
        spiralPath.addLine(to: CGPoint(x: spiralFrame.minX + 0.40411 * spiralFrame.width, y: spiralFrame.minY + 0.40814 * spiralFrame.height))
        spiralPath.addCurve(to: CGPoint(x: spiralFrame.minX + 0.41300 * spiralFrame.width, y: spiralFrame.minY + 0.40020 * spiralFrame.height), controlPoint1: CGPoint(x: spiralFrame.minX + 0.40705 * spiralFrame.width, y: spiralFrame.minY + 0.40544 * spiralFrame.height), controlPoint2: CGPoint(x: spiralFrame.minX + 0.41003 * spiralFrame.width, y: spiralFrame.minY + 0.40286 * spiralFrame.height))
        spiralPath.addLine(to: CGPoint(x: spiralFrame.minX + 0.41745 * spiralFrame.width, y: spiralFrame.minY + 0.39623 * spiralFrame.height))
        spiralPath.addCurve(to: CGPoint(x: spiralFrame.minX + 0.42199 * spiralFrame.width, y: spiralFrame.minY + 0.39250 * spiralFrame.height), controlPoint1: CGPoint(x: spiralFrame.minX + 0.41896 * spiralFrame.width, y: spiralFrame.minY + 0.39494 * spiralFrame.height), controlPoint2: CGPoint(x: spiralFrame.minX + 0.42048 * spiralFrame.width, y: spiralFrame.minY + 0.39375 * spiralFrame.height))
        spiralPath.addLine(to: CGPoint(x: spiralFrame.minX + 0.43107 * spiralFrame.width, y: spiralFrame.minY + 0.38512 * spiralFrame.height))
        spiralPath.addCurve(to: CGPoint(x: spiralFrame.minX + 0.44035 * spiralFrame.width, y: spiralFrame.minY + 0.37819 * spiralFrame.height), controlPoint1: CGPoint(x: spiralFrame.minX + 0.43410 * spiralFrame.width, y: spiralFrame.minY + 0.38276 * spiralFrame.height), controlPoint2: CGPoint(x: spiralFrame.minX + 0.43726 * spiralFrame.width, y: spiralFrame.minY + 0.38050 * spiralFrame.height))
        spiralPath.addLine(to: CGPoint(x: spiralFrame.minX + 0.44500 * spiralFrame.width, y: spiralFrame.minY + 0.37474 * spiralFrame.height))
        spiralPath.addLine(to: CGPoint(x: spiralFrame.minX + 0.44971 * spiralFrame.width, y: spiralFrame.minY + 0.37151 * spiralFrame.height))
        spiralPath.addLine(to: CGPoint(x: spiralFrame.minX + 0.45914 * spiralFrame.width, y: spiralFrame.minY + 0.36504 * spiralFrame.height))
        spiralPath.addLine(to: CGPoint(x: spiralFrame.minX + 0.46867 * spiralFrame.width, y: spiralFrame.minY + 0.35893 * spiralFrame.height))
        spiralPath.addLine(to: CGPoint(x: spiralFrame.minX + 0.47344 * spiralFrame.width, y: spiralFrame.minY + 0.35589 * spiralFrame.height))
        spiralPath.addLine(to: CGPoint(x: spiralFrame.minX + 0.47825 * spiralFrame.width, y: spiralFrame.minY + 0.35301 * spiralFrame.height))
        spiralPath.addLine(to: CGPoint(x: spiralFrame.minX + 0.48788 * spiralFrame.width, y: spiralFrame.minY + 0.34728 * spiralFrame.height))
        spiralPath.addLine(to: CGPoint(x: spiralFrame.minX + 0.49760 * spiralFrame.width, y: spiralFrame.minY + 0.34186 * spiralFrame.height))
        spiralPath.addCurve(to: CGPoint(x: spiralFrame.minX + 0.50733 * spiralFrame.width, y: spiralFrame.minY + 0.33658 * spiralFrame.height), controlPoint1: CGPoint(x: spiralFrame.minX + 0.50082 * spiralFrame.width, y: spiralFrame.minY + 0.34001 * spiralFrame.height), controlPoint2: CGPoint(x: spiralFrame.minX + 0.50406 * spiralFrame.width, y: spiralFrame.minY + 0.33823 * spiralFrame.height))
        spiralPath.addCurve(to: CGPoint(x: spiralFrame.minX + 0.58605 * spiralFrame.width, y: spiralFrame.minY + 0.29971 * spiralFrame.height), controlPoint1: CGPoint(x: spiralFrame.minX + 0.53339 * spiralFrame.width, y: spiralFrame.minY + 0.32287 * spiralFrame.height), controlPoint2: CGPoint(x: spiralFrame.minX + 0.55974 * spiralFrame.width, y: spiralFrame.minY + 0.31092 * spiralFrame.height))
        spiralPath.addCurve(to: CGPoint(x: spiralFrame.minX + 0.66490 * spiralFrame.width, y: spiralFrame.minY + 0.26659 * spiralFrame.height), controlPoint1: CGPoint(x: spiralFrame.minX + 0.61236 * spiralFrame.width, y: spiralFrame.minY + 0.28850 * spiralFrame.height), controlPoint2: CGPoint(x: spiralFrame.minX + 0.63858 * spiralFrame.width, y: spiralFrame.minY + 0.27748 * spiralFrame.height))
        spiralPath.addLine(to: CGPoint(x: spiralFrame.minX + 0.70435 * spiralFrame.width, y: spiralFrame.minY + 0.25024 * spiralFrame.height))
        spiralPath.addLine(to: CGPoint(x: spiralFrame.minX + 0.74387 * spiralFrame.width, y: spiralFrame.minY + 0.23416 * spiralFrame.height))
        spiralPath.addLine(to: CGPoint(x: spiralFrame.minX + 0.78331 * spiralFrame.width, y: spiralFrame.minY + 0.21809 * spiralFrame.height))
        spiralPath.addCurve(to: CGPoint(x: spiralFrame.minX + 0.82221 * spiralFrame.width, y: spiralFrame.minY + 0.20114 * spiralFrame.height), controlPoint1: CGPoint(x: spiralFrame.minX + 0.79639 * spiralFrame.width, y: spiralFrame.minY + 0.21267 * spiralFrame.height), controlPoint2: CGPoint(x: spiralFrame.minX + 0.80936 * spiralFrame.width, y: spiralFrame.minY + 0.20708 * spiralFrame.height))
        spiralPath.addCurve(to: CGPoint(x: spiralFrame.minX + 0.89638 * spiralFrame.width, y: spiralFrame.minY + 0.15794 * spiralFrame.height), controlPoint1: CGPoint(x: spiralFrame.minX + 0.84785 * spiralFrame.width, y: spiralFrame.minY + 0.18924 * spiralFrame.height), controlPoint2: CGPoint(x: spiralFrame.minX + 0.87294 * spiralFrame.width, y: spiralFrame.minY + 0.17554 * spiralFrame.height))
        spiralPath.addCurve(to: CGPoint(x: spiralFrame.minX + 0.95966 * spiralFrame.width, y: spiralFrame.minY + 0.09246 * spiralFrame.height), controlPoint1: CGPoint(x: spiralFrame.minX + 0.92002 * spiralFrame.width, y: spiralFrame.minY + 0.14070 * spiralFrame.height), controlPoint2: CGPoint(x: spiralFrame.minX + 0.94138 * spiralFrame.width, y: spiralFrame.minY + 0.11859 * spiralFrame.height))
        spiralPath.addCurve(to: CGPoint(x: spiralFrame.minX + 0.98374 * spiralFrame.width, y: spiralFrame.minY + 0.04947 * spiralFrame.height), controlPoint1: CGPoint(x: spiralFrame.minX + 0.96882 * spiralFrame.width, y: spiralFrame.minY + 0.07928 * spiralFrame.height), controlPoint2: CGPoint(x: spiralFrame.minX + 0.97690 * spiralFrame.width, y: spiralFrame.minY + 0.06488 * spiralFrame.height))
        spiralPath.addCurve(to: CGPoint(x: spiralFrame.minX + 1.00000 * spiralFrame.width, y: spiralFrame.minY + 0.00000 * spiralFrame.height), controlPoint1: CGPoint(x: spiralFrame.minX + 0.99071 * spiralFrame.width, y: spiralFrame.minY + 0.03393 * spiralFrame.height), controlPoint2: CGPoint(x: spiralFrame.minX + 0.99617 * spiralFrame.width, y: spiralFrame.minY + 0.01731 * spiralFrame.height))
        spiralPath.addCurve(to: CGPoint(x: spiralFrame.minX + 0.98759 * spiralFrame.width, y: spiralFrame.minY + 0.05203 * spiralFrame.height), controlPoint1: CGPoint(x: spiralFrame.minX + 0.99763 * spiralFrame.width, y: spiralFrame.minY + 0.01798 * spiralFrame.height), controlPoint2: CGPoint(x: spiralFrame.minX + 0.99345 * spiralFrame.width, y: spiralFrame.minY + 0.03548 * spiralFrame.height))
        spiralPath.addCurve(to: CGPoint(x: spiralFrame.minX + 0.96577 * spiralFrame.width, y: spiralFrame.minY + 0.09904 * spiralFrame.height), controlPoint1: CGPoint(x: spiralFrame.minX + 0.98161 * spiralFrame.width, y: spiralFrame.minY + 0.06868 * spiralFrame.height), controlPoint2: CGPoint(x: spiralFrame.minX + 0.97430 * spiralFrame.width, y: spiralFrame.minY + 0.08444 * spiralFrame.height))
        spiralPath.addCurve(to: CGPoint(x: spiralFrame.minX + 0.93716 * spiralFrame.width, y: spiralFrame.minY + 0.13968 * spiralFrame.height), controlPoint1: CGPoint(x: spiralFrame.minX + 0.95721 * spiralFrame.width, y: spiralFrame.minY + 0.11372 * spiralFrame.height), controlPoint2: CGPoint(x: spiralFrame.minX + 0.94763 * spiralFrame.width, y: spiralFrame.minY + 0.12732 * spiralFrame.height))
        spiralPath.addCurve(to: CGPoint(x: spiralFrame.minX + 0.90377 * spiralFrame.width, y: spiralFrame.minY + 0.17370 * spiralFrame.height), controlPoint1: CGPoint(x: spiralFrame.minX + 0.92670 * spiralFrame.width, y: spiralFrame.minY + 0.15211 * spiralFrame.height), controlPoint2: CGPoint(x: spiralFrame.minX + 0.91554 * spiralFrame.width, y: spiralFrame.minY + 0.16348 * spiralFrame.height))
        spiralPath.addCurve(to: CGPoint(x: spiralFrame.minX + 0.82899 * spiralFrame.width, y: spiralFrame.minY + 0.22424 * spiralFrame.height), controlPoint1: CGPoint(x: spiralFrame.minX + 0.88025 * spiralFrame.width, y: spiralFrame.minY + 0.19412 * spiralFrame.height), controlPoint2: CGPoint(x: spiralFrame.minX + 0.85480 * spiralFrame.width, y: spiralFrame.minY + 0.21035 * spiralFrame.height))
        spiralPath.addCurve(to: CGPoint(x: spiralFrame.minX + 0.79003 * spiralFrame.width, y: spiralFrame.minY + 0.24397 * spiralFrame.height), controlPoint1: CGPoint(x: spiralFrame.minX + 0.81609 * spiralFrame.width, y: spiralFrame.minY + 0.23131 * spiralFrame.height), controlPoint2: CGPoint(x: spiralFrame.minX + 0.80306 * spiralFrame.width, y: spiralFrame.minY + 0.23772 * spiralFrame.height))
        spiralPath.addCurve(to: CGPoint(x: spiralFrame.minX + 0.75100 * spiralFrame.width, y: spiralFrame.minY + 0.26228 * spiralFrame.height), controlPoint1: CGPoint(x: spiralFrame.minX + 0.77699 * spiralFrame.width, y: spiralFrame.minY + 0.25022 * spiralFrame.height), controlPoint2: CGPoint(x: spiralFrame.minX + 0.76401 * spiralFrame.width, y: spiralFrame.minY + 0.25627 * spiralFrame.height))
        spiralPath.addCurve(to: CGPoint(x: spiralFrame.minX + 0.59478 * spiralFrame.width, y: spiralFrame.minY + 0.33372 * spiralFrame.height), controlPoint1: CGPoint(x: spiralFrame.minX + 0.69904 * spiralFrame.width, y: spiralFrame.minY + 0.28649 * spiralFrame.height), controlPoint2: CGPoint(x: spiralFrame.minX + 0.64684 * spiralFrame.width, y: spiralFrame.minY + 0.31015 * spiralFrame.height))
        spiralPath.addCurve(to: CGPoint(x: spiralFrame.minX + 0.55608 * spiralFrame.width, y: spiralFrame.minY + 0.35174 * spiralFrame.height), controlPoint1: CGPoint(x: spiralFrame.minX + 0.58180 * spiralFrame.width, y: spiralFrame.minY + 0.33968 * spiralFrame.height), controlPoint2: CGPoint(x: spiralFrame.minX + 0.56891 * spiralFrame.width, y: spiralFrame.minY + 0.34563 * spiralFrame.height))
        spiralPath.addCurve(to: CGPoint(x: spiralFrame.minX + 0.53697 * spiralFrame.width, y: spiralFrame.minY + 0.36123 * spiralFrame.height), controlPoint1: CGPoint(x: spiralFrame.minX + 0.54972 * spiralFrame.width, y: spiralFrame.minY + 0.35492 * spiralFrame.height), controlPoint2: CGPoint(x: spiralFrame.minX + 0.54329 * spiralFrame.width, y: spiralFrame.minY + 0.35793 * spiralFrame.height))
        spiralPath.addLine(to: CGPoint(x: spiralFrame.minX + 0.52750 * spiralFrame.width, y: spiralFrame.minY + 0.36611 * spiralFrame.height))
        spiralPath.addLine(to: CGPoint(x: spiralFrame.minX + 0.51810 * spiralFrame.width, y: spiralFrame.minY + 0.37109 * spiralFrame.height))
        spiralPath.addLine(to: CGPoint(x: spiralFrame.minX + 0.51339 * spiralFrame.width, y: spiralFrame.minY + 0.37361 * spiralFrame.height))
        spiralPath.addLine(to: CGPoint(x: spiralFrame.minX + 0.50874 * spiralFrame.width, y: spiralFrame.minY + 0.37625 * spiralFrame.height))
        spiralPath.addLine(to: CGPoint(x: spiralFrame.minX + 0.49943 * spiralFrame.width, y: spiralFrame.minY + 0.38151 * spiralFrame.height))
        spiralPath.addLine(to: CGPoint(x: spiralFrame.minX + 0.49026 * spiralFrame.width, y: spiralFrame.minY + 0.38705 * spiralFrame.height))
        spiralPath.addLine(to: CGPoint(x: spiralFrame.minX + 0.48572 * spiralFrame.width, y: spiralFrame.minY + 0.38980 * spiralFrame.height))
        spiralPath.addLine(to: CGPoint(x: spiralFrame.minX + 0.48118 * spiralFrame.width, y: spiralFrame.minY + 0.39272 * spiralFrame.height))
        spiralPath.addLine(to: CGPoint(x: spiralFrame.minX + 0.47209 * spiralFrame.width, y: spiralFrame.minY + 0.39856 * spiralFrame.height))
        spiralPath.addLine(to: CGPoint(x: spiralFrame.minX + 0.46321 * spiralFrame.width, y: spiralFrame.minY + 0.40483 * spiralFrame.height))
        spiralPath.addLine(to: CGPoint(x: spiralFrame.minX + 0.45877 * spiralFrame.width, y: spiralFrame.minY + 0.40792 * spiralFrame.height))
        spiralPath.addLine(to: CGPoint(x: spiralFrame.minX + 0.45443 * spiralFrame.width, y: spiralFrame.minY + 0.41118 * spiralFrame.height))
        spiralPath.addLine(to: CGPoint(x: spiralFrame.minX + 0.44574 * spiralFrame.width, y: spiralFrame.minY + 0.41769 * spiralFrame.height))
        spiralPath.addCurve(to: CGPoint(x: spiralFrame.minX + 0.38225 * spiralFrame.width, y: spiralFrame.minY + 0.47998 * spiralFrame.height), controlPoint1: CGPoint(x: spiralFrame.minX + 0.42286 * spiralFrame.width, y: spiralFrame.minY + 0.43525 * spiralFrame.height), controlPoint2: CGPoint(x: spiralFrame.minX + 0.40156 * spiralFrame.width, y: spiralFrame.minY + 0.45615 * spiralFrame.height))
        spiralPath.addCurve(to: CGPoint(x: spiralFrame.minX + 0.33079 * spiralFrame.width, y: spiralFrame.minY + 0.55967 * spiralFrame.height), controlPoint1: CGPoint(x: spiralFrame.minX + 0.36304 * spiralFrame.width, y: spiralFrame.minY + 0.50413 * spiralFrame.height), controlPoint2: CGPoint(x: spiralFrame.minX + 0.34579 * spiralFrame.width, y: spiralFrame.minY + 0.53084 * spiralFrame.height))
        spiralPath.addCurve(to: CGPoint(x: spiralFrame.minX + 0.29041 * spiralFrame.width, y: spiralFrame.minY + 0.65123 * spiralFrame.height), controlPoint1: CGPoint(x: spiralFrame.minX + 0.31564 * spiralFrame.width, y: spiralFrame.minY + 0.58886 * spiralFrame.height), controlPoint2: CGPoint(x: spiralFrame.minX + 0.30215 * spiralFrame.width, y: spiralFrame.minY + 0.61946 * spiralFrame.height))
        spiralPath.addCurve(to: CGPoint(x: spiralFrame.minX + 0.27328 * spiralFrame.width, y: spiralFrame.minY + 0.69983 * spiralFrame.height), controlPoint1: CGPoint(x: spiralFrame.minX + 0.28436 * spiralFrame.width, y: spiralFrame.minY + 0.66711 * spiralFrame.height), controlPoint2: CGPoint(x: spiralFrame.minX + 0.27885 * spiralFrame.width, y: spiralFrame.minY + 0.68338 * spiralFrame.height))
        spiralPath.addLine(to: CGPoint(x: spiralFrame.minX + 0.25646 * spiralFrame.width, y: spiralFrame.minY + 0.74944 * spiralFrame.height))
        spiralPath.addCurve(to: CGPoint(x: spiralFrame.minX + 0.23811 * spiralFrame.width, y: spiralFrame.minY + 0.79896 * spiralFrame.height), controlPoint1: CGPoint(x: spiralFrame.minX + 0.25074 * spiralFrame.width, y: spiralFrame.minY + 0.76607 * spiralFrame.height), controlPoint2: CGPoint(x: spiralFrame.minX + 0.24465 * spiralFrame.width, y: spiralFrame.minY + 0.78262 * spiralFrame.height))
        spiralPath.addCurve(to: CGPoint(x: spiralFrame.minX + 0.21633 * spiralFrame.width, y: spiralFrame.minY + 0.84674 * spiralFrame.height), controlPoint1: CGPoint(x: spiralFrame.minX + 0.23160 * spiralFrame.width, y: spiralFrame.minY + 0.81545 * spiralFrame.height), controlPoint2: CGPoint(x: spiralFrame.minX + 0.22432 * spiralFrame.width, y: spiralFrame.minY + 0.83141 * spiralFrame.height))
        spiralPath.addLine(to: CGPoint(x: spiralFrame.minX + 0.21330 * spiralFrame.width, y: spiralFrame.minY + 0.85252 * spiralFrame.height))
        spiralPath.addCurve(to: CGPoint(x: spiralFrame.minX + 0.21011 * spiralFrame.width, y: spiralFrame.minY + 0.85815 * spiralFrame.height), controlPoint1: CGPoint(x: spiralFrame.minX + 0.21227 * spiralFrame.width, y: spiralFrame.minY + 0.85450 * spiralFrame.height), controlPoint2: CGPoint(x: spiralFrame.minX + 0.21117 * spiralFrame.width, y: spiralFrame.minY + 0.85627 * spiralFrame.height))
        spiralPath.addLine(to: CGPoint(x: spiralFrame.minX + 0.20690 * spiralFrame.width, y: spiralFrame.minY + 0.86375 * spiralFrame.height))
        spiralPath.addLine(to: CGPoint(x: spiralFrame.minX + 0.20530 * spiralFrame.width, y: spiralFrame.minY + 0.86657 * spiralFrame.height))
        spiralPath.addLine(to: CGPoint(x: spiralFrame.minX + 0.20365 * spiralFrame.width, y: spiralFrame.minY + 0.86919 * spiralFrame.height))
        spiralPath.addLine(to: CGPoint(x: spiralFrame.minX + 0.19679 * spiralFrame.width, y: spiralFrame.minY + 0.88002 * spiralFrame.height))
        spiralPath.addLine(to: CGPoint(x: spiralFrame.minX + 0.18946 * spiralFrame.width, y: spiralFrame.minY + 0.89032 * spiralFrame.height))
        spiralPath.addCurve(to: CGPoint(x: spiralFrame.minX + 0.15658 * spiralFrame.width, y: spiralFrame.minY + 0.92632 * spiralFrame.height), controlPoint1: CGPoint(x: spiralFrame.minX + 0.17943 * spiralFrame.width, y: spiralFrame.minY + 0.90371 * spiralFrame.height), controlPoint2: CGPoint(x: spiralFrame.minX + 0.16842 * spiralFrame.width, y: spiralFrame.minY + 0.91576 * spiralFrame.height))
        spiralPath.addCurve(to: CGPoint(x: spiralFrame.minX + 0.14764 * spiralFrame.width, y: spiralFrame.minY + 0.93388 * spiralFrame.height), controlPoint1: CGPoint(x: spiralFrame.minX + 0.15356 * spiralFrame.width, y: spiralFrame.minY + 0.92884 * spiralFrame.height), controlPoint2: CGPoint(x: spiralFrame.minX + 0.15068 * spiralFrame.width, y: spiralFrame.minY + 0.93152 * spiralFrame.height))
        spiralPath.addLine(to: CGPoint(x: spiralFrame.minX + 0.13848 * spiralFrame.width, y: spiralFrame.minY + 0.94092 * spiralFrame.height))
        spiralPath.addLine(to: CGPoint(x: spiralFrame.minX + 0.12911 * spiralFrame.width, y: spiralFrame.minY + 0.94737 * spiralFrame.height))
        spiralPath.addCurve(to: CGPoint(x: spiralFrame.minX + 0.11959 * spiralFrame.width, y: spiralFrame.minY + 0.95333 * spiralFrame.height), controlPoint1: CGPoint(x: spiralFrame.minX + 0.12597 * spiralFrame.width, y: spiralFrame.minY + 0.94950 * spiralFrame.height), controlPoint2: CGPoint(x: spiralFrame.minX + 0.12275 * spiralFrame.width, y: spiralFrame.minY + 0.95134 * spiralFrame.height))
        spiralPath.addCurve(to: CGPoint(x: spiralFrame.minX + 0.08052 * spiralFrame.width, y: spiralFrame.minY + 0.97317 * spiralFrame.height), controlPoint1: CGPoint(x: spiralFrame.minX + 0.10687 * spiralFrame.width, y: spiralFrame.minY + 0.96094 * spiralFrame.height), controlPoint2: CGPoint(x: spiralFrame.minX + 0.09382 * spiralFrame.width, y: spiralFrame.minY + 0.96756 * spiralFrame.height))
        spiralPath.addCurve(to: CGPoint(x: spiralFrame.minX + 0.04048 * spiralFrame.width, y: spiralFrame.minY + 0.98799 * spiralFrame.height), controlPoint1: CGPoint(x: spiralFrame.minX + 0.06727 * spiralFrame.width, y: spiralFrame.minY + 0.97883 * spiralFrame.height), controlPoint2: CGPoint(x: spiralFrame.minX + 0.05389 * spiralFrame.width, y: spiralFrame.minY + 0.98359 * spiralFrame.height))
        spiralPath.addCurve(to: CGPoint(x: spiralFrame.minX + 0.00000 * spiralFrame.width, y: spiralFrame.minY + 1.00000 * spiralFrame.height), controlPoint1: CGPoint(x: spiralFrame.minX + 0.02707 * spiralFrame.width, y: spiralFrame.minY + 0.99240 * spiralFrame.height), controlPoint2: CGPoint(x: spiralFrame.minX + 0.01353 * spiralFrame.width, y: spiralFrame.minY + 0.99633 * spiralFrame.height))
        spiralPath.close()
        spiralPath.usesEvenOddFillRule = true
        spiralLayer.path = spiralPath.cgPath
        
        spiralLayer.fillColor = RookColors.shared().rookWhite.cgColor
        
        let maskPath = UIBezierPath()
        maskPath.move(to: CGPoint(x: frame.midX, y: frame.minY))
        maskPath.addLine(to: CGPoint(x: frame.midX, y: frame.maxY))
        maskLayer.path = maskPath.cgPath
        maskLayer.strokeColor = UIColor.red.cgColor
        maskLayer.lineWidth = frame.width
        
        spiralLayer.mask = maskLayer
        
        maskLayer.strokeStart = 1
        
        
        
        
    }
    
    func startAnimation(){
         strokeStartAnimation.keyPath = "strokeStart"
        strokeStartAnimation.duration = 0.2
        strokeStartAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        strokeStartAnimation.fromValue = 1
        strokeStartAnimation.toValue = 0
        maskLayer.strokeStart = 0
        self.maskLayer.add(self.strokeStartAnimation, forKey: "strokeStartAnimation")
    }
}


@IBDesignable
class rectGradient: UIView {
    
    private let gradientLayer = CAGradientLayer()
    
    @IBInspectable var gradientColor1: UIColor =  {
        return UIColor(red: 0.000, green: 0.314, blue: 0.914, alpha: 1.000)
    }()
    
    @IBInspectable var gradientColor2: UIColor =  {
        return UIColor(red: 0.000, green: 0.914, blue: 0.800, alpha: 1.000)
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.addSublayer(gradientLayer)
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        layer.addSublayer(gradientLayer)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(gradientLayer)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.addSublayer(gradientLayer)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    func setup() {
        
        
        let frame = bounds

        gradientLayer.frame = frame
        gradientLayer.position = CGPoint(x: 0, y: 0)
        gradientLayer.anchorPoint = CGPoint(x: 0, y: 0)
        gradientLayer.colors = [gradientColor1.cgColor, gradientColor2.cgColor]
        gradientLayer.locations = [0, 1]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.9)
        
        gradientLayer.zPosition = 5
    }
}
