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
    
    @IBOutlet var contentView: UIView!
    @IBOutlet private weak var codeBoxView: UIStackView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var containerStackView: UIStackView!
    
    /// When reset is called, top 5 dots will shake to indicate whether the attempt is success or not. Defaule is set to false.
    @IBInspectable var shouldShakeOnReset: Bool = true
    
    private var digitCount = 5
    
    @IBInspectable var status: String? {
        didSet {
            guard let status = status else {
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
    
    private func setup() {
        Bundle.main.loadNibNamed("RookKeypadView", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.frame = self.bounds
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        // Configulations
        configureBoxAppearance()
        configureNumberPadAppearance()
        configureLabel(isHidden: true)
    }
    
    private func configureLabel(isHidden: Bool) {
        if isHidden {
            self.statusLabel.isHidden = true
            containerStackView.spacing = 40
        }
        else {
            self.statusLabel.isHidden = false
            containerStackView.spacing = 10
        }
    }

    private func configureNumberPadAppearance() {
        for index in 11...20 {
            let button = contentView.viewWithTag(index) as! UIButton
            button.cornerRadius = button.bounds.width/7
        }
        
        let backspaceButton = contentView.viewWithTag(-1) as! UIButton
        backspaceButton.cornerRadius = backspaceButton.bounds.width/7
        
    }
    
    
    private func configureBoxAppearance() {
         for index in 6...digitCount+5 {
            let viewDigit = contentView.viewWithTag(index) as! RookCodeTextField
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
    
    @IBAction private func numberTapped(_ sender: UIButton) {
        var items = codeBoxView.arrangedSubviews.flatMap({$0.subviews.map({$0 as! RookCodeTextField})})
        if sender.tag == -1 { //deleteBackWard
            if code.count > 0 {
                items[code.count-1].text = ""
            }
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
