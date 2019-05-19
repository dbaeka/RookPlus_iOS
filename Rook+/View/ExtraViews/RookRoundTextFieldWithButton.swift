//
//  RookRoundTextFieldWithButton.swift
//  Rook+
//
//  Created by Delmwin Baeka on 1/29/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit


class RookRoundTextFieldWithButton: RookRoundTextField {
    
    /// A UILabel value that identifies the label used to display the icon
    open var button: UIButton!
    
    var isLeft = true {
        didSet {
            setNeedsLayout()
        }
    }
    
    /// A String value that determines the text used when displaying the icon
    @IBInspectable
    open var buttonText: String? = "Button" {
        didSet {
            updateTitle()
        }
    }
    
    @IBInspectable
    open var buttonTextColor: UIColor? = UIColor(displayP3Red: 92/255, green: 92/255, blue: 92/255, alpha: 1) {
        didSet {
            button.setTitleColor(buttonTextColor, for: .normal)
        }
    }
    
    /// A float value that determines the width of the icon
    @IBInspectable
    dynamic open var buttonWidth: CGFloat = 60 {
        didSet {
            updateFrame()
        }
    }
    
    /**
     A float value that determines the left margin of the icon.
     Use this value to position the icon more precisely horizontally.
     */
    @IBInspectable
    dynamic open var buttonMarginLeft: CGFloat = 2 {
        didSet {
            updateFrame()
        }
    }
    
    /**
     A float value that determines the bottom margin of the icon.
     Use this value to position the icon more precisely vertically.
     */
    @IBInspectable
    dynamic open var buttonMarginBottom: CGFloat = 4 {
        didSet {
            updateFrame()
        }
    }
    
    
    // MARK: Initializers
    
    /**
     Initializes the control
     - parameter frame the frame of the control
     */
    override public init(frame: CGRect) {
        super.init(frame: frame)
        createButton()
    }
    
    /**
     Intialzies the control by deserializing it
     - parameter coder the object to deserialize the control from
     */
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createButton()
    }
    
    // MARK: Creating the button
    
    /// Creates the both icon label and icon image view
    fileprivate func createButton() {
        let button = UIButton()
        button.autoresizingMask = [.flexibleTopMargin, .flexibleRightMargin]
        button.addTarget(self, action: #selector(handleButtonTap(_:from:)), for: .touchUpInside)
        button.setTitleColor(buttonTextColor, for: .normal)
        self.button = button
        button.showsTouchWhenHighlighted = true
        updateTitle()
        addSubview(button)
    }
    
    fileprivate func updateTitle() {
        let textAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont(name: "Roboto-Medium", size: 11), NSAttributedString.Key.foregroundColor: self.buttonTextColor]
        let text = NSMutableAttributedString(string: buttonText ?? "Button", attributes: textAttributes)
        button.setAttributedTitle(text, for: .normal)
    }
    
    @objc func handleButtonTap(_ sender: UIButton, from touch: UITouch) {
        sender.titleLabel?.alpha = 0.5
        UIView.animate(withDuration: 0.1, delay: 0.2, options: [.curveEaseOut], animations: {
            sender.titleLabel?.alpha = 1.0
            }, completion: nil)
    }
    
    // MARK: Custom layout overrides
    
    /**
     Calculate the bounds for the textfield component of the control.
     Override to create a custom size textbox in the control.
     - parameter bounds: The current bounds of the textfield component
     - returns: The rectangle that the textfield component should render in
     */
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.textRect(forBounds: bounds)
        if isLeft {
            rect.origin.x += CGFloat(buttonWidth + buttonMarginLeft)
        } else {
            // don't change the editing field X position for RTL languages
        }
        rect.size.width -= CGFloat(buttonWidth + buttonMarginLeft)
        return rect
    }
    
    /**
     Calculate the rectangle for the textfield when it is being edited
     - parameter bounds: The current bounds of the field
     - returns: The rectangle that the textfield should render in
     */
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.editingRect(forBounds: bounds)
        if isLeft {
            rect.origin.x += CGFloat(buttonWidth + buttonMarginLeft)
        } else {
            // don't change the editing field X position for RTL languages
        }
        rect.size.width -= CGFloat(buttonWidth + buttonMarginLeft)
        return rect
    }

    
    /**
     Calculates the bounds for the placeholder component of the control.
     Override to create a custom size textbox in the control.
     - parameter bounds: The current bounds of the placeholder component
     - returns: The rectangle that the placeholder component should render in
     */
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.placeholderRect(forBounds: bounds)
        if isLeft {
            rect.origin.x += CGFloat(buttonWidth + buttonMarginLeft)
        } else {
            // don't change the editing field X position for RTL languages
        }
        rect.size.width -= CGFloat(buttonWidth + buttonMarginLeft)
        return rect
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        return super.beginTracking(touch, with: event)
    }
    
    /// Invoked by layoutIfNeeded automatically
    override open func layoutSubviews() {
        super.layoutSubviews()
        updateFrame()
    }
    
    fileprivate func updateFrame() {
        let textWidth: CGFloat = bounds.size.width
        if isLeft {
            button.frame = CGRect(
                x: 0,
                y: 0,
                width: buttonWidth,
                height: bounds.height
            )
        } else {
            button.frame = CGRect(
                x: textWidth - buttonWidth,
                y: 0,
                width: buttonWidth,
                height: bounds.height
            )
        }
    }
}



