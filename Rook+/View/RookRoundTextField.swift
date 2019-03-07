//
//  RookRoundButton.swift
//  Rook+
//
//  Created by Delmwin Baeka on 1/28/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

public enum RookRoundTFType: Int {
    case button
    case noButton
}

@IBDesignable
class RookRoundText: UIView {
    
    var textField: RookRoundTextField!
    
    var textFieldWithButton: RookRoundTextFieldWithButton!
    
    @IBInspectable var isLeft: Bool = true {
        didSet {
            textFieldWithButton.isLeft = isLeft
        }
    }
    
    @IBInspectable var buttonText: String? = "Button" {
        didSet {
            textFieldWithButton.buttonText = buttonText
        }
    }
    
    @IBInspectable var placeholderFontSize: CGFloat = 11 {
        didSet{
            textField.placeholderFont = UIFont(name: "Roboto-Regular", size: placeholderFontSize)
            textFieldWithButton.placeholderFont = textField.placeholderFont
        }
    }
    
    @IBInspectable var placeholder: String? {
        didSet{
            textField.placeholder = placeholder
            textFieldWithButton.placeholder = placeholder
        }
    }
    
    @IBInspectable var isSecureEntry: Bool = false {
        didSet{
            textField.isSecureTextEntry = isSecureEntry
            textFieldWithButton.isSecureTextEntry = isSecureEntry
        }
    }
    
    @IBInspectable
    var TFTypeValue: Int {
        get {
            return self.TFType.rawValue
        }
        set(TFIndex) {
            self.TFType = RookRoundTFType(rawValue: TFIndex) ?? .noButton
        }
    }
    
    open var TFType: RookRoundTFType = .noButton {
        didSet {
            updateHiddenState()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override open func prepareForInterfaceBuilder() {
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
        updateView()
    }
    
    fileprivate func setup() {
        createTextField()
        createTextFieldWithButton()
        
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 4
        layer.shadowColor = UIColor.black.cgColor
        
        updateHiddenState()
    }
    
    private func updateView(){
        textField.frame = bounds
        textFieldWithButton.frame = bounds
    }
    
    fileprivate func createTextField() {
        textField = RookRoundTextField(frame: bounds)
        textField.placeholderFont = UIFont(name: "Roboto-Regular", size: placeholderFontSize)
        textField.font = UIFont(name: "Roboto-Regular", size: placeholderFontSize + 2.0)
        textField.placeholder = self.placeholder
        textField.borderStyle = .roundedRect
        layer.cornerRadius = textField.cornerRadius
        addSubview(textField)
    }
    
    fileprivate func createTextFieldWithButton() {
        textFieldWithButton = RookRoundTextFieldWithButton(frame: bounds)
        textFieldWithButton.placeholderFont = UIFont(name: "Roboto-Regular", size: placeholderFontSize)
        textFieldWithButton.font = UIFont(name: "Roboto-Regular", size: placeholderFontSize + 2.0)
        textFieldWithButton.placeholder = self.placeholder
        textFieldWithButton.borderStyle = .roundedRect
        textFieldWithButton.isLeft = isLeft
        textFieldWithButton.buttonText = buttonText
        layer.cornerRadius = textFieldWithButton.cornerRadius
        addSubview(textFieldWithButton)
    }
    
    fileprivate func updateHiddenState() {
        switch TFType {
        case .button:
            self.textField.isHidden = true
            self.textFieldWithButton.isHidden = false
        case .noButton:
            self.textField.isHidden = false
            self.textFieldWithButton.isHidden = true
        }
    }
}


@IBDesignable
open class RookRoundTextField: UITextField { // swiftlint:disable:this type_body_length
    /**
     A Boolean value that determines if the language displayed is LTR.
     Default value set automatically from the application language settings.
     */
    @objc open var isLTRLanguage: Bool = UIApplication.shared.userInterfaceLayoutDirection == .leftToRight {
        didSet {
            updateTextAligment()
        }
    }
  
    fileprivate func updateTextAligment() {
        if isLTRLanguage {
            textAlignment = .left
        } else {
            textAlignment = .right
        }
    }
    
    
    // MARK: Colors
    
    fileprivate var cachedTextColor: UIColor?
    
    /// A UIColor value that determines the text color of the editable text
    @IBInspectable
    override dynamic open var textColor: UIColor? {
        set {
            cachedTextColor = newValue
            updateControl(false)
        }
        get {
            return cachedTextColor
        }
    }
    
    /// A UIColor value that determines text color of the placeholder label
    @IBInspectable dynamic open var placeholderColor: UIColor = UIColor.lightGray {
        didSet {
            updatePlaceholder()
        }
    }
    
    /// A UIFont value that determines text color of the placeholder label
    @objc dynamic open var placeholderFont: UIFont? {
        didSet {
            updatePlaceholder()
        }
    }
    
    fileprivate func updatePlaceholder() {
        guard let placeholder = placeholder, let font = placeholderFont ?? font else {
            return
        }
        let color = isEnabled ? placeholderColor : disabledColor
        #if swift(>=4.2)
        attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: font
            ]
        )
        #elseif swift(>=4.0)
        attributedPlaceholder = NSAttributedString(
        string: placeholder,
        attributes: [
        NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: font
        ]
        )
        #else
        attributedPlaceholder = NSAttributedString(
        string: placeholder,
        attributes: [NSForegroundColorAttributeName: color, NSFontAttributeName: font]
        )
        #endif
    }
    
    /// A UIColor value that determines the color used for the title label and line when the error message is not `nil`
    @IBInspectable dynamic open var errorColor: UIColor = .red {
        didSet {
            updateColors()
        }
    }
    
    /// A UIColor value that determines the color used for the line when error message is not `nil`
    @IBInspectable dynamic open var borderErrorColor: UIColor? {
        didSet {
            updateColors()
        }
    }
    
    /// A UIColor value that determines the color used for the text when error message is not `nil`
    @IBInspectable dynamic open var textErrorColor: UIColor? {
        didSet {
            updateColors()
        }
    }
    
    
    /// A UIColor value that determines the color used for the title label and line when text field is disabled
    @IBInspectable dynamic open var disabledColor: UIColor = UIColor(white: 0.88, alpha: 1.0) {
        didSet {
            updateControl()
            updatePlaceholder()
        }
    }
    
    
    
    @IBInspectable dynamic open var borderColor: UIColor = .clear {
        didSet {
            updateBorderColor()
        }
    }
    
    
    /// A UIColor value that determines the color of the line in a selected state
    @IBInspectable dynamic open var selectedBorderColor: UIColor = RookColors.shared().rookBlue {
        didSet {
            updateBorderColor()
        }
    }
    
    // MARK: Properties
    
    
    /**
     Identifies whether the text object should hide the text being entered.
     */
    override open var isSecureTextEntry: Bool {
        set {
            super.isSecureTextEntry = newValue
            fixCaretPosition()
        }
        get {
            return super.isSecureTextEntry
        }
    }
    
    /// A String value for the error message to display.
    @IBInspectable
    open var errorMessage: String? {
        didSet {
            updateControl(true)
        }
    }
    
    /// The backing property for the highlighted property
    fileprivate var _highlighted: Bool = false
    
    /**
     A Boolean value that determines whether the receiver is highlighted.
     When changing this value, highlighting will be done with animation
     */
    override open var isHighlighted: Bool {
        get {
            return _highlighted
        }
        set {
            _highlighted = newValue
            updateBorderColor()
        }
    }
    
    /// A Boolean value that determines whether the textfield is being edited or is selected.
    open var editingOrSelected: Bool {
        return super.isEditing || isSelected
    }
    
    /// A Boolean value that determines whether the receiver has an error message.
    open var hasErrorMessage: Bool {
        return errorMessage != nil && errorMessage != ""
    }
    
    /// The text content of the textfield
    @IBInspectable
    override open var text: String? {
        didSet {
            updateControl(false)
        }
    }
    
    /**
     The String to display when the input field is empty.
     The placeholder can also appear in the title label when both `title` `selectedTitle` and are `nil`.
     */
    @IBInspectable
    override open var placeholder: String? {
        didSet {
            setNeedsDisplay()
            updatePlaceholder()
        }
    }
    
    // Determines whether the field is selected. When selected, the title floats above the textbox.
    open override var isSelected: Bool {
        didSet {
            updateControl(true)
        }
    }
    
    // MARK: - Initializers
    
    /**
     Initializes the control
     - parameter frame the frame of the control
     */
    override public init(frame: CGRect) {
        super.init(frame: frame)
        addEditingChangedObserver()
        init_RookRoundButton()
    }
    
    /**
     Intialzies the control by deserializing it
     - parameter coder the object to deserialize the control from
     */
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addEditingChangedObserver()
        init_RookRoundButton()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        init_RookRoundButton()
    }
    
    fileprivate final func init_RookRoundButton() {
        //.borderStyle = .none
        updateColors()
        updateTextAligment()
        layer.cornerRadius = bounds.height/2
        layer.masksToBounds = true
    }
    
    fileprivate func addEditingChangedObserver() {
        self.addTarget(self, action: #selector(RookRoundTextField.editingChanged), for: .editingChanged)
    }
    
    /**
     Invoked when the editing state of the textfield changes. Override to respond to this change.
     */
    @objc open func editingChanged() {
        updateControl(true)
    }
    
    // MARK: Responder handling
    
    /**
     Attempt the control to become the first responder
     - returns: True when successfull becoming the first responder
     */
    @discardableResult
    override open func becomeFirstResponder() -> Bool {
        let result = super.becomeFirstResponder()
        updateControl(true)
        return result
    }
    
    /**
     Attempt the control to resign being the first responder
     - returns: True when successfull resigning being the first responder
     */
    @discardableResult
    override open func resignFirstResponder() -> Bool {
        let result = super.resignFirstResponder()
        updateControl(true)
        return result
    }
    
    /// update colors when is enabled changed
    override open var isEnabled: Bool {
        didSet {
            updateControl()
            updatePlaceholder()
        }
    }
    
    // MARK: - View updates
    
    fileprivate func updateControl(_ animated: Bool = false) {
        updateColors()
        updateBorderColor()
    }
    
    // MARK: - Color updates
    
    /// Update the colors for the control. Override to customize colors.
    open func updateColors() {
        updateBorderColor()
        updateTextColor()
    }
    
    fileprivate func updateBorderColor() {
        if !isEnabled {
            layer.borderColor = disabledColor.cgColor
            layer.borderWidth = 1
        } else if hasErrorMessage {
            layer.borderColor = borderErrorColor?.cgColor ?? errorColor.cgColor
            layer.borderWidth = 1
        } else {
            layer.borderWidth = 1
            layer.borderColor = editingOrSelected ? selectedBorderColor.cgColor : borderColor.cgColor
        }
    }
    
    
    
    fileprivate func updateTextColor() {
        if !isEnabled {
            super.textColor = disabledColor
        } else if hasErrorMessage {
            super.textColor = textErrorColor ?? errorColor
        } else {
            super.textColor = cachedTextColor
        }
    }
    
    
    // MARK: - UITextField text/placeholder positioning overrides
    
    /**
     Calculate the rectangle for the textfield when it is not being edited
     - parameter bounds: The current bounds of the field
     - returns: The rectangle that the textfield should render in
     */
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        let superRect = super.textRect(forBounds: bounds)
        let rect = CGRect(
            x: layer.cornerRadius,
            y: 2,
            width: superRect.width,
            height: superRect.height
        )
        return rect
    }
    
    /**
     Calculate the rectangle for the textfield when it is being edited
     - parameter bounds: The current bounds of the field
     - returns: The rectangle that the textfield should render in
     */
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        let superRect = super.editingRect(forBounds: bounds)
        let rect = CGRect(
            x: layer.cornerRadius,
            y: 2,
            width: superRect.width,
            height: superRect.height
        )
        return rect
    }
    
    /**
     Calculate the rectangle for the placeholder
     - parameter bounds: The current bounds of the placeholder
     - returns: The rectangle that the placeholder should render in
     */
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let rect = CGRect(
            x: layer.cornerRadius,
            y: 0,
            width: bounds.width,
            height: bounds.height
        )
        return rect
    }
    
    // MARK: - Positioning Overrides
    
    
    /**
     Calcualte the height of the textfield.
     -returns: the calculated height of the textfield. Override to size the textfield with a different height
     */
    open func textHeight() -> CGFloat {
        guard let font = self.font else {
            return 0.0
        }
        
        return font.lineHeight + 7.0
    }
    
    // MARK: - Layout
    
    /// Invoked when the interface builder renders the control
    override open func prepareForInterfaceBuilder() {
        if #available(iOS 8.0, *) {
            super.prepareForInterfaceBuilder()
        }
        init_RookRoundButton()
        updateControl(false)
    }
    
    /**
     Calculate the content size for auto layout
     
     - returns: the content size to be used for auto layout
     */
    override open var intrinsicContentSize: CGSize {
        return CGSize(width: bounds.size.width, height:textHeight())
    }
    
    // MARK: - Helpers
    
} // swiftlint:disable:this file_length



