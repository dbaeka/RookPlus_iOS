//
//  RookKeypadVerificationView.swift
//  Rook+
//
//  Created by Delmwin Baeka on 1/30/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

@objc
protocol RookKeypadVerificationViewDelegate: class {
    func codeView(sender: RookKeypadVerificationView, didFinishInput code: String)
}

@IBDesignable
class RookKeypadVerificationView: UIView {
    
    private let codeBoxView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 15
        return stack
    }()

    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Medium", size: 12)
        label.text = "Status"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        return label
    }()
    
    private let containerStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 10
        return stack
    }()
    
    /// When reset is called, top 5 dots will shake to indicate whether the attempt is success or not. Defaule is set to false.
    @IBInspectable var shouldShakeOnReset: Bool = true
    
    private var digitCount = 5
    
    private var buttonSize: CGFloat = 67
    
    @IBInspectable var status: String? {
        didSet {
            guard let status = status else {
                self.statusLabel.text = ""
                self.configureLabel(isHidden: true)
                return
            }
            self.configureLabel(isHidden: false)
            self.statusLabel.text = status
        }
    }
    
    open var code: String {
        get {
            let items = codeBoxView.arrangedSubviews.flatMap({$0.subviews.map({$0 as! RookCodeTextField})})
            let values = items.map({$0.text ?? ""})
            return values.joined()
        }
        set {
            let array = newValue.map(String.init)
            for i in 0..<array.count {
                let item = codeBoxView.arrangedSubviews[i].subviews[0] as! RookCodeTextField
                item.text = array[i]
            }
        }
    }
    
    open weak var delegate: RookKeypadVerificationViewDelegate?
    
    // MARK: - Private
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureNumberPadAppearance()
    }
    
    private func setup() {
        addSubview(containerStackView)
        containerStackView.addArrangedSubview(codeBoxView)
        containerStackView.addArrangedSubview(statusLabel)
        
        configureConstraints()
        configureBoxAppearance()
        configureNumberPadAppearance()
        configureLabel(isHidden: true)
    }
    
    private func configureConstraints() {
        self.containerStackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        self.containerStackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        let height = UIScreen.main.bounds.height
        let width = UIScreen.main.bounds.width
        let codeBoxWIdth: CGFloat = (width > 700) ? 54 : (width/8.5)
        let buttonWIdth: CGFloat = (width > 700) ? 70 : 55
        let buttonWidthResize: CGFloat = ((height < 570)) ? 45 : buttonWIdth
        self.buttonSize = buttonWidthResize
        
        for i in 1...5 {
            let view = UIView()
            view.tag = i
            view.backgroundColor = UIColor.white
            view.translatesAutoresizingMaskIntoConstraints = false
            view.widthAnchor.constraint(equalToConstant: codeBoxWIdth).isActive = true
            view.heightAnchor.constraint(equalToConstant: codeBoxWIdth).isActive = true
            self.codeBoxView.addArrangedSubview(view)
            let label = RookCodeTextField()
            view.addSubview(label)
            label.font = UIFont(name: "Roboto-Regular", size: 24)
            label.adjustsFontSizeToFitWidth = true
            label.minimumFontSize = 17
            label.tag = i+5
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            label.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            label.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        }
        
        let keypad = UIStackView()
        self.containerStackView.addArrangedSubview(keypad)
        keypad.translatesAutoresizingMaskIntoConstraints = false
        keypad.axis = .vertical
        keypad.alignment = .center
        keypad.distribution = .fillEqually
        keypad.spacing = buttonWidthResize/2
        keypad.centerXAnchor.constraint(equalTo: containerStackView.centerXAnchor).isActive = true
        
        for i in 0..<4 {
            let stack = UIStackView()
            keypad.addArrangedSubview(stack)
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis = .horizontal
            stack.alignment = .fill
            stack.distribution = .fillEqually
            stack.spacing = buttonWidthResize/2
            
            let leftButton = UIButton()
            stack.addArrangedSubview(leftButton)
            let offset = i*3
            let textAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont(name: "Roboto-Medium", size: 24), NSAttributedString.Key.foregroundColor: UIColor(hexString: "#707070")]
            var attributedString1 = NSMutableAttributedString(string: "\(1+offset)", attributes: textAttributes)
            leftButton.tag = 11+offset
            leftButton.backgroundColor = UIColor(hexString: "#FAFAFB")
            if i == 3 {
                let textAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont(name: "Roboto-Bold", size: 15), NSAttributedString.Key.foregroundColor: UIColor(hexString: "#004AEF")]
                attributedString1 = NSMutableAttributedString(string: "Resend", attributes: textAttributes)
                leftButton.tag = -2
                leftButton.titleLabel?.minimumScaleFactor = 0.5
                leftButton.titleLabel?.adjustsFontSizeToFitWidth = true
                leftButton.backgroundColor = UIColor.clear
            }
            leftButton.setAttributedTitle(attributedString1, for: .normal)
            leftButton.widthAnchor.constraint(equalToConstant: buttonWidthResize).isActive = true
            leftButton.heightAnchor.constraint(equalToConstant: buttonWidthResize).isActive = true
            leftButton.translatesAutoresizingMaskIntoConstraints = false
            leftButton.addTarget(self, action: #selector(numberTapped(_:)), for: .touchUpInside)
            
            let middleButton = UIButton()
            stack.addArrangedSubview(middleButton)
            var attributedString2 = NSMutableAttributedString(string: "\(2+offset)", attributes: textAttributes)
            middleButton.tag = 12+offset
            if i == 3 {
                attributedString2 = NSMutableAttributedString(string: "0", attributes: textAttributes)
                middleButton.tag = 20
            }
            middleButton.setAttributedTitle(attributedString2, for: .normal)
            middleButton.backgroundColor = UIColor(hexString: "#FAFAFB")
            middleButton.translatesAutoresizingMaskIntoConstraints = false
            middleButton.addTarget(self, action: #selector(numberTapped(_:)), for: .touchUpInside)
            
            let rightButton = UIButton()
            stack.addArrangedSubview(rightButton)
            var attributedString3 = NSMutableAttributedString(string: "\(3+offset)", attributes: textAttributes)
            rightButton.tag = 13+offset
            if i == 3 {
                attributedString3 = NSMutableAttributedString(string: "", attributes: textAttributes)
                rightButton.setImage(UIImage(named: "clear"), for: .normal)
                rightButton.tag = -1
            }
            rightButton.setAttributedTitle(attributedString3, for: .normal)
            rightButton.backgroundColor = UIColor(hexString: "#FAFAFB")
            rightButton.translatesAutoresizingMaskIntoConstraints = false
            rightButton.addTarget(self, action: #selector(numberTapped(_:)), for: .touchUpInside)
        }
    }

    
    private func configureLabel(isHidden: Bool) {
        if isHidden {
            self.statusLabel.isHidden = true
            containerStackView.spacing = 40
        }
        else {
            self.statusLabel.isHidden = false
            containerStackView.spacing = 0
        }
    }

    private func configureNumberPadAppearance() {
        for index in 11...20 {
            let button = self.viewWithTag(index) as! UIButton
            button.cornerRadius = buttonSize/7
        }
        
        let backspaceButton = self.viewWithTag(-1) as! UIButton
        
        backspaceButton.cornerRadius = buttonSize/7
        
    }
    
    
    private func configureBoxAppearance() {
         for index in 6...digitCount+5 {
            let viewDigit = self.viewWithTag(index) as! RookCodeTextField
            viewDigit.text = ""
        }
    }
    
    // Shakes the top 5 box views when then authentication failed
    private func shakeAnimate() {
        codeBoxView.transform = CGAffineTransform(translationX: 20, y: 0)
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 4, options: .beginFromCurrentState, animations: {
            self.codeBoxView.transform = .identity
        })
    }
    
    override func becomeFirstResponder() -> Bool {
        let items = codeBoxView.arrangedSubviews.flatMap({$0.subviews.map({$0 as! RookCodeTextField})})
        return (items.filter({($0.text ?? "").isEmpty}).first ?? items.last)!.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        codeBoxView.arrangedSubviews.forEach({$0.resignFirstResponder()})
        return true
    }
    
}



// MARK: - Public
extension RookKeypadVerificationView {
    func reset() {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
            let items = self.codeBoxView.arrangedSubviews.flatMap({$0.subviews.map({$0 as! RookCodeTextField})})
            for item in items {
                item.text = ""
            }
            })
        if self.shouldShakeOnReset {
            self.shakeAnimate()
        }
    }
}



// MARK: - Actions
extension RookKeypadVerificationView {
    
    @objc private func numberTapped(_ sender: UIButton) {
        var items = codeBoxView.arrangedSubviews.flatMap({$0.subviews.map({$0 as! RookCodeTextField})})
        if sender.tag == -1 { //deleteBackWard
            if code.count > 0 {
                items[code.count-1].text = ""
            }
        } else if sender.tag == -2 {
            print("resend code")
        } else {  //Register the digits in text field
            if code.count < digitCount {
                items[code.count].text = sender.titleLabel?.text
            }
            if code.count == 5 {
                reset()
                delegate?.codeView(sender: self, didFinishInput: self.code)
            }
        }
        
    }
    
}
