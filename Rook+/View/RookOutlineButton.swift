//
//  RookOutlineButton.swift
//  Rook+
//
//  Created by Delmwin Baeka on 1/21/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

@IBDesignable
class RookOutlineButton: UIButton {
    

    @IBInspectable var title: String = "BEGIN" {
        didSet {
            self.setNeedsDisplay()
        }
    }

    @IBInspectable var width: CGFloat = 107 {
        didSet {
            self.setNeedsDisplay()
        }
    }

    @IBInspectable var height: CGFloat = 42 {
        didSet {
            self.setNeedsDisplay()
        }
    }

    @IBInspectable var titleSize: CGFloat = 17.6 {
        didSet {
            self.setNeedsDisplay()
        }
    }

    @IBInspectable var isPressed: Bool = false {
        didSet {
            self.setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {
        self.drawOutlineButton(frame: rect, resizing: .aspectFit, width: self.width, height: self.height, titleSize: self.titleSize, isPressed: self.isPressed, title: self.title)
    }
    

    //// Drawing Methods
    
    func drawOutlineButton(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 240, height: 120), resizing: ResizingBehavior = .aspectFit, width: CGFloat, height: CGFloat, titleSize: CGFloat, isPressed: Bool, title: String) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 107, height: 42), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 107, y: resizedFrame.height / 42)
        
       
        
        //// Frames
        let outlineFrame = CGRect(x: 3, y: 1, width: (width - 6), height: (height - 3))
        
        //// Subframes
        let titleFrame = CGRect(x: outlineFrame.minX + 22, y: outlineFrame.minY + 10, width: outlineFrame.width - 44, height: outlineFrame.height - 21)
        
        
        //// BeginButton
        //// Rectangle 2 Drawing
        let rectangle2Path = UIBezierPath(roundedRect: CGRect(x: outlineFrame.minX + 1, y: outlineFrame.minY + 1, width: outlineFrame.width - 2, height: outlineFrame.height - 2), cornerRadius: 18.5)
        RookColors.shared().rookWhite.setStroke()
        rectangle2Path.lineWidth = 1
        rectangle2Path.stroke()
        
        
        //// NormalTitle Drawing
        let normalTitleRect = CGRect(x: titleFrame.minX + 2.29, y: titleFrame.minY + 2, width: titleFrame.width - 4.29, height: titleFrame.height - 4)
        let normalTitleStyle = NSMutableParagraphStyle()
        normalTitleStyle.alignment = .center
        let normalTitleFontAttributes = [
            .font: UIFont(name: "Roboto-Regular", size: titleSize)!,
            .foregroundColor: RookColors.shared().rookWhite,
            .paragraphStyle: normalTitleStyle,
            ] as [NSAttributedString.Key: Any]
        
        let normalTitleTextHeight: CGFloat = title.boundingRect(with: CGSize(width: normalTitleRect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: normalTitleFontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: normalTitleRect)
        title.draw(in: CGRect(x: normalTitleRect.minX, y: normalTitleRect.minY + (normalTitleRect.height - normalTitleTextHeight) / 2, width: normalTitleRect.width, height: normalTitleTextHeight), withAttributes: normalTitleFontAttributes)
        context.restoreGState()
        
        
        if (isPressed) {
            //// PressedTitle Drawing
            let pressedTitleRect = CGRect(x: titleFrame.minX + 2.29, y: titleFrame.minY + 2, width: titleFrame.width - 4.29, height: titleFrame.height - 4)
            let pressedTitleStyle = NSMutableParagraphStyle()
            pressedTitleStyle.alignment = .center
            let pressedTitleFontAttributes = [
                .font: UIFont(name: "Roboto-Regular", size: titleSize)!,
                .foregroundColor: RookColors.shared().color,
                .paragraphStyle: pressedTitleStyle,
                ] as [NSAttributedString.Key: Any]
            
            let pressedTitleTextHeight: CGFloat = title.boundingRect(with: CGSize(width: pressedTitleRect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: pressedTitleFontAttributes, context: nil).height
            context.saveGState()
            context.clip(to: pressedTitleRect)
            title.draw(in: CGRect(x: pressedTitleRect.minX, y: pressedTitleRect.minY + (pressedTitleRect.height - pressedTitleTextHeight) / 2, width: pressedTitleRect.width, height: pressedTitleTextHeight), withAttributes: pressedTitleFontAttributes)
            context.restoreGState()
        }
        
        context.restoreGState()
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        self.isPressed = true
        return super.beginTracking(touch, with: event)
    }
    
    override func cancelTracking(with event: UIEvent?) {
        super.cancelTracking(with: event)
        self.isPressed = false
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        super.endTracking(touch, with: event)
        self.isPressed = false
    }
}
