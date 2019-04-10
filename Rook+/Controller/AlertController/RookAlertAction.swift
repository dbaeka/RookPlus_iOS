//
//  RookAlert.swift
//  RookPlus
//
//  Created by Delmwin Baeka on 4/8/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

/**
 An enumeration for the kinds of actions that can be created
 
 - VSAlertActionStyleDefault: A normal action
 - VSAlertActionStyleCancel: An action that indicates to the user that the current process wil be cancelled
 - VSAlertActionStyleDestructive: An action indicates to the user that an irreversible process is about to happen.
 */
public enum RookAlertActionStyle : Int {
    /**
     A normal action
     */
    case `default`
    /**
     An action that indicates to the user that the current process wil be cancelled
     */
    case cancel
    /**
     An action indicates to the user that an irreversible process is about to happen.
     */
    case destructive
}

class RookAlertAction: UIButton {
    
    private var separator: UIImageView?
    
    // Redesignate initializers so you can call 'super'
    internal required override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.style = RookAlertActionStyle.default
        action = { _ in }
        alertTitle = ""
        
        _setUp()
        
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        style = RookAlertActionStyle.default
        action = { _ in }
        alertTitle = ""
        
        _setUp()
        
    }
    
    /**
     @name Creating Actions
     */
    
    /**
     A factory method to create an instance of UIAlertAction. This is the prefered way to create alert actions.
     
     @param title The title of the action
     @param style The style of the action
     @param action The block to be executed when the user interacts with the action, but before the alert is dismissed
     @return The instantiaed action
     */
    required init(title: String?, style: RookAlertActionStyle, action: ((_ action: RookAlertAction) -> Void)? = nil) {
        super.init(frame: .zero)
        
        self.style = style;
        self.action = action;
        self.alertTitle = title;
        
        self.action = action
    }
    
    /**
     @name Configuring Action Appearance
     */
    
    /**
     The color of the title text used in non-desctructive actions
     */
    var _actionTextColor: UIColor?
    /**
     The color of the title text used in destructive actions
     */
    var _destructiveActionTextColor: UIColor?
    /**
     The font of the title used in non-cancel actions
     */
    var _actionTextFont: UIFont?
    /**
     The font of the title used in cancel actions
     */
    var _cancelActionTextFont: UIFont?
    /**
     @name Interacting with Actions
     */
    
    /**
     The title of the alert
     */
    private(set) var alertTitle: String?
    /**
     The display style of the alert
     */
    private(set) var style: RookAlertActionStyle?
    /**
     The block that will be executed when the user interacts with the action. The block is called on the main thread always, and begins executed before the alert is dismissed
     */
    private(set) var action: ((_ action: RookAlertAction) -> Void)?

    // MARK: - Property Access Methods
    func actionTextColor() -> UIColor? {
        return _actionTextColor
    }
    
    func setActionTextColor(_ actionTextColor: UIColor) {
        
        _actionTextColor = actionTextColor
        
        if style != RookAlertActionStyle.destructive {
            
            setTitleColor(self.actionTextColor(), for: .normal)
            setTitleColor(self.actionTextColor()?.withAlphaComponent(0.5), for: .highlighted)
        }
        
    }
    
    func destructiveActionTextColor() -> UIColor? {
        return _destructiveActionTextColor
    }
    
    func setDestructiveActionTextColor(_ destructiveActionTextColor: UIColor) {
        _destructiveActionTextColor = destructiveActionTextColor
        if style == RookAlertActionStyle.destructive {
            
            setTitleColor(self.destructiveActionTextColor(), for: .normal)
            setTitleColor(self.destructiveActionTextColor()?.withAlphaComponent(0.5), for: .highlighted)
        }
    }
    
    func actionTextFont() -> UIFont? {
        return _actionTextFont
    }
    
    
    // MARK: - Overridden Instance Methods
    
    func setActionTextFont(_ actionTextFont: UIFont?) {
        self._actionTextFont = actionTextFont
        
        if style != RookAlertActionStyle.cancel {
            titleLabel?.font = self._actionTextFont!
        }
    }
    
    func cancelTextFont() -> UIFont? {
        
        return _cancelActionTextFont
        
    }
    
    func setCancelTextFont(_ cancelActionTextFont: UIFont?) {
        _cancelActionTextFont = cancelActionTextFont
        
        if style == RookAlertActionStyle.cancel {
            titleLabel?.font = cancelTextFont()
        }
        
    }
    
    // MARK: - Public Instance Methods
    init(title: String?, style: RookAlertActionStyle, action: @escaping (RookAlertAction) -> Void) {
        
        super.init(frame: CGRect.zero)
        self.style = style
        self.action = action
        alertTitle = title
        _setUp()
    }
    
    // MARK: - Private Instance Methods
    func _setUp() {
        
        _actionTextColor = tintColor
        _destructiveActionTextColor = UIColor.red
        _actionTextFont = UIFont.systemFont(ofSize: 17.0, weight: .regular)
        
        setTitle(alertTitle, for: .normal)
        
        setTitleColor(style == RookAlertActionStyle.destructive ? _destructiveActionTextColor : actionTextColor(), for: .normal)
        setTitleColor(style == RookAlertActionStyle.destructive ? _destructiveActionTextColor?.withAlphaComponent(0.5) : actionTextColor()?.withAlphaComponent(0.5), for: .highlighted)
        
        titleLabel?.font = style == RookAlertActionStyle.cancel ? UIFont.systemFont(ofSize: 17.0, weight: .semibold) : actionTextFont()
        
        _addSeparator()
        
    }
    
    func _addSeparator() {
        
        separator = UIImageView(frame: CGRect.zero)
        separator?.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        separator?.translatesAutoresizingMaskIntoConstraints = false
        
        if let separator = separator {
            addSubview(separator)
        }
        
        if let separator = separator {
            addConstraints([
                NSLayoutConstraint(item: separator, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0),
                NSLayoutConstraint(item: separator, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 8.0),
                NSLayoutConstraint(item: separator, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: -8.0),
                NSLayoutConstraint(item: separator, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 0.0, constant: 1.0)
                ])
        }
    }
}
