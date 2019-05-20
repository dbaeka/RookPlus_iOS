//
//  SignUpPage1ViewController.swift
//  Rook+
//
//  Created by Delmwin Baeka on 1/29/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit
import VSAlert

class SignUpPage1ViewController: UIViewController {
    
    private let firstNameTextField: RookRoundText = {
        let textfield = RookRoundText()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "First Name"
        textfield.textField.keyboardType = UIKeyboardType.alphabet
        textfield.textField.tag = 1
        return textfield
    }()
    
    private let lastNameTextField: RookRoundText = {
        let textfield = RookRoundText()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "Last Name"
        textfield.textField.keyboardType = UIKeyboardType.alphabet
        textfield.textField.tag = 2
        return textfield
    }()
    
    private let emailTextField: RookRoundText = {
        let textfield = RookRoundText()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "Email Address"
        textfield.textField.keyboardType = .emailAddress
        textfield.textField.tag = 3
        return textfield
    }()
    
    private let headingLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "Enter your name &"
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont(name: "Roboto-Bold", size: 22)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subHeadingLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "email"
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont(name: "Roboto-Regular", size: 22)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nextButton: RookAnimatedLoadingButton = {
        let button = RookAnimatedLoadingButton()
        button.isAnimatable = false
        button.title = "Next"
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(headingLabel)
        view.addSubview(subHeadingLabel)
        view.addSubview(firstNameTextField)
        view.addSubview(lastNameTextField)
        view.addSubview(emailTextField)
        view.addSubview(nextButton)
        self.nextButton.addTarget(self, action: #selector(handleNext(_:)), for: .touchUpInside)
        
        configureConstraints()
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange(_:)), name: UITextField.textDidChangeNotification, object: nil)
        self.nextButton.isEnabled = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        NotificationCenter.default.removeObserver(self, name: UITextField.textDidChangeNotification, object: nil)
    }
    
    
    private func configureConstraints() {
        let height = UIScreen.main.bounds.height
        let width = UIScreen.main.bounds.width
        let screenRatio = UIScreen.main.bounds.height/UIScreen.main.bounds.width
        let distanceToTop: CGFloat = (screenRatio < 2.0 && self.sizeClass() != (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) ? 30 : 40
        let textFontSize: CGFloat = (self.sizeClass() == (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) ? 35 : 22
        
        let textFieldWIdth: CGFloat = (self.sizeClass() == (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) ? 400 : width-50
        
        let textOffset: CGFloat = width/3.3
        let headingOffset: CGFloat = distanceToTop + 19 + height/24 + (width/4.5)/4.14814815
        
        self.headingLabel.font = UIFont(name: "Roboto-Bold", size: textFontSize)
        self.headingLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: headingOffset).isActive = true
        self.headingLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: textOffset/4.8).isActive = true
        self.headingLabel.heightAnchor.constraint(equalToConstant: headingLabel.intrinsicContentSize.width/7.5).isActive = true
        
        self.subHeadingLabel.font = headingLabel.font
        self.subHeadingLabel.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: textFontSize/4).isActive = true
        self.subHeadingLabel.leftAnchor.constraint(equalTo: headingLabel.leftAnchor).isActive = true
        self.subHeadingLabel.rightAnchor.constraint(equalTo: headingLabel.rightAnchor).isActive = true
        
        self.firstNameTextField.topAnchor.constraint(equalTo: subHeadingLabel.bottomAnchor, constant: height/10).isActive = true
        self.firstNameTextField.widthAnchor.constraint(equalToConstant: textFieldWIdth/2.2).isActive = true
        self.firstNameTextField.heightAnchor.constraint(equalToConstant: textFieldWIdth/7.76).isActive = true
        self.firstNameTextField.leftAnchor.constraint(equalTo: emailTextField.leftAnchor).isActive = true
        
        self.lastNameTextField.centerYAnchor.constraint(equalTo: firstNameTextField.centerYAnchor).isActive = true
        self.lastNameTextField.widthAnchor.constraint(equalToConstant: textFieldWIdth/2.2).isActive = true
        self.lastNameTextField.heightAnchor.constraint(equalToConstant: textFieldWIdth/7.76).isActive = true
        self.lastNameTextField.rightAnchor.constraint(equalTo: emailTextField.rightAnchor).isActive = true
        
        self.emailTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: height/25).isActive = true
        self.emailTextField.widthAnchor.constraint(equalToConstant: textFieldWIdth).isActive = true
        self.emailTextField.heightAnchor.constraint(equalToConstant: textFieldWIdth/7.76).isActive = true
        self.emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        self.nextButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: height/25).isActive = true
        self.nextButton.rightAnchor.constraint(equalTo: emailTextField.rightAnchor).isActive = true
        self.nextButton.widthAnchor.constraint(equalToConstant: textFieldWIdth/4).isActive = true
        self.nextButton.heightAnchor.constraint(equalToConstant: textFieldWIdth/(4*2.3)).isActive = true
    }
    
    @objc func handleNext(_ sender: Any) {
        self.resignKeyboards()
        RookUser.shared.user.email = self.emailTextField.textField.text!
        RookUser.shared.user.firstName = self.firstNameTextField.textField.text!
        RookUser.shared.user.lastName = self.lastNameTextField.textField.text!
        let vc = self.parent?.parent as! SignUpPagesViewController
        vc.handleNext(sender)
    }
    
    @objc private func textDidChange (_ notification: Notification){
        self.validate()
    }
    
    private func validate(){
        var emailIsValid = false
        var fnameIsValid = false
        var lnameIsValid = false
        
        fnameIsValid = Validator.isASCII().apply(firstNameTextField.textField.text) && Validator.required().apply(firstNameTextField.textField.text)
        firstNameTextField.textField.errorMessage = (fnameIsValid) ? "" : "Invalid First Name"
        
        lnameIsValid = Validator.isASCII().apply(lastNameTextField.textField.text) && Validator.required().apply(lastNameTextField.textField.text)
        lastNameTextField.textField.errorMessage = (lnameIsValid) ? "" : "Invalid Last Name"
        
        emailIsValid = Validator.isEmail().apply(emailTextField.textField.text) && Validator.required().apply(emailTextField.textField.text)
        emailTextField.textField.errorMessage = (emailIsValid) ? "" : "Invalid Email"
        
        UIView.animate(withDuration: 0.25, animations: {
            self.nextButton.isEnabled = emailIsValid && fnameIsValid && lnameIsValid
        })
    }
    
    private func resignKeyboards() {
        self.firstNameTextField.textField.resignFirstResponder()
        self.lastNameTextField.textField.resignFirstResponder()
        self.emailTextField.textField.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.resignKeyboards()
    }
}

class SignUpPage2ViewController: UIViewController {
    
    private let headingLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "Choose your birthdate &"
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont(name: "Roboto-Bold", size: 22)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subHeadingLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "gender"
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont(name: "Roboto-Regular", size: 22)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nextButton: RookAnimatedLoadingButton = {
        let button = RookAnimatedLoadingButton()
        button.isAnimatable = false
        button.title = "Next"
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var birthdayString: String = "20 February 1997" {
        didSet {
            let textAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont(name: "Roboto-Regular", size: 13), NSAttributedString.Key.foregroundColor: UIColor.black]
            let attributedString = NSMutableAttributedString(string: birthdayString, attributes: textAttributes)
            birthdayButton.setAttributedTitle(attributedString, for: .normal)
            birthdayButton.marginLabel = 45
            self.isDateSet = true
            self.validate()
        }
    }
    
    private let birthdayButton : RookRoundButton = {
        let button = RookRoundButton()
        button.backgroundColor = UIColor.white
        button.isShadowOn = true
        button.marginLabel = 45
        let textAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont(name: "Roboto-Regular", size: 13), NSAttributedString.Key.foregroundColor: UIColor(hexString: "#B7B7B7")]
        let attributedString = NSMutableAttributedString(string: "20 February 1997", attributes: textAttributes)
        button.setAttributedTitle(attributedString, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let birthdayLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "When is your birthday?"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont(name: "Roboto-Medium", size: 14)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let genderLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "Choose your gender"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont(name: "Roboto-Medium", size: 14)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let maleCardButton: RookGenderButton = {
        let button = RookGenderButton()
        button.isActive = false
        button.clipsToBounds = false
        button.backgroundColor = UIColor.white
        button.imageName = .male
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let femaleCardButton: RookGenderButton = {
        let button = RookGenderButton()
        button.isActive = false
        button.clipsToBounds = false
        button.backgroundColor = UIColor.white
        button.imageName = .female
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var birthDate: String?
    private var isDateSet: Bool = false
    private var gender: RookGenderButton.Gender?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(headingLabel)
        view.addSubview(subHeadingLabel)
        view.addSubview(birthdayButton)
        self.birthdayButton.addTarget(self, action: #selector(showDatePicker(_:)), for: .touchUpInside)
        view.addSubview(birthdayLabel)
        view.addSubview(genderLabel)
        view.addSubview(nextButton)
        self.nextButton.addTarget(self, action: #selector(handleNext(_:)), for: .touchUpInside)
        view.addSubview(maleCardButton)
        self.maleCardButton.addTarget(self, action: #selector(handleGenderSelection(_:)), for: .touchUpInside)
        view.addSubview(femaleCardButton)
        self.femaleCardButton.addTarget(self, action: #selector(handleGenderSelection(_:)), for: .touchUpInside)
        
        configureConstraints()
        self.nextButton.isEnabled = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateBirthday(notification:)), name: NSNotification.Name("dateChosen"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("dateChosen"), object: nil)
    }
    
    private func configureConstraints() {
        let height = UIScreen.main.bounds.height
        let width = UIScreen.main.bounds.width
        let screenRatio = UIScreen.main.bounds.height/UIScreen.main.bounds.width
        let distanceToTop: CGFloat = (screenRatio < 2.0 && self.sizeClass() != (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) ? 30 : 40
        let textFontSize: CGFloat = (self.sizeClass() == (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) ? 35 : 22
        
        let textFieldWIdth: CGFloat = (self.sizeClass() == (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) ? 400 : width-50
        
        let textOffset: CGFloat = width/3.3
        let headingOffset: CGFloat = distanceToTop + 19 + height/24 + (width/4.5)/4.14814815
        
        self.headingLabel.font = UIFont(name: "Roboto-Bold", size: textFontSize)
        self.headingLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: headingOffset).isActive = true
        self.headingLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: textOffset/4.8).isActive = true
        self.headingLabel.heightAnchor.constraint(equalToConstant: headingLabel.intrinsicContentSize.width/7.5).isActive = true
        
        self.subHeadingLabel.font = headingLabel.font
        self.subHeadingLabel.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: textFontSize/4).isActive = true
        self.subHeadingLabel.leftAnchor.constraint(equalTo: headingLabel.leftAnchor).isActive = true
        self.subHeadingLabel.rightAnchor.constraint(equalTo: headingLabel.rightAnchor).isActive = true
        
        self.birthdayLabel.topAnchor.constraint(equalTo: subHeadingLabel.bottomAnchor, constant: height/18).isActive = true
        self.birthdayLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        self.birthdayLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        self.birthdayLabel.font = UIFont(name: "Roboto-Medium", size: textFontSize/1.5)
        
        self.birthdayButton.topAnchor.constraint(equalTo: birthdayLabel.bottomAnchor, constant: height/25).isActive = true
        self.birthdayButton.widthAnchor.constraint(equalToConstant: textFieldWIdth).isActive = true
        self.birthdayButton.heightAnchor.constraint(equalToConstant: textFieldWIdth/7.76).isActive = true
        self.birthdayButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        self.genderLabel.topAnchor.constraint(equalTo: birthdayButton.bottomAnchor, constant: height/20).isActive = true
        self.genderLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        self.genderLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        self.genderLabel.font = birthdayLabel.font
        
        let genderWidth: CGFloat = textFieldWIdth/3
        self.maleCardButton.widthAnchor.constraint(equalToConstant: genderWidth).isActive = true
        self.maleCardButton.heightAnchor.constraint(equalToConstant: 1.188*genderWidth).isActive = true
        self.maleCardButton.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: height/25).isActive = true
        self.maleCardButton.leftAnchor.constraint(equalTo: birthdayButton.leftAnchor, constant: genderWidth/4).isActive = true
        self.maleCardButton.setColor()
        
        self.femaleCardButton.widthAnchor.constraint(equalToConstant: genderWidth).isActive = true
        self.femaleCardButton.heightAnchor.constraint(equalToConstant: 1.188*genderWidth).isActive = true
        self.femaleCardButton.centerYAnchor.constraint(equalTo: maleCardButton.centerYAnchor).isActive = true
        self.femaleCardButton.rightAnchor.constraint(equalTo: birthdayButton.rightAnchor, constant: -genderWidth/4).isActive = true
        self.femaleCardButton.setColor()
        
        self.nextButton.topAnchor.constraint(equalTo: femaleCardButton.bottomAnchor, constant: height/25).isActive = true
        self.nextButton.rightAnchor.constraint(equalTo: birthdayButton.rightAnchor).isActive = true
        self.nextButton.widthAnchor.constraint(equalToConstant: textFieldWIdth/4).isActive = true
        self.nextButton.heightAnchor.constraint(equalToConstant: textFieldWIdth/(4*2.3)).isActive = true
    }
    
    @objc func handleNext(_ sender: Any) {
        RookUser.shared.user.gender = self.gender?.serializedString
        RookUser.shared.user.dateOfBirth = self.birthdayString
        let vc = self.parent?.parent as! SignUpPagesViewController
        vc.handleNext(sender)
    }
    
    
    @objc func handleGenderSelection(_ sender: RookGenderButton) {
        self.gender =  (sender.isActive) ? sender.imageName : nil
        if sender == maleCardButton {
            self.femaleCardButton.isActive = false
        }
        else {
            self.maleCardButton.isActive = false
        }
        self.validate()
    }
    
    @objc func showDatePicker(_ sender: Any) {
        RookBSController.shared().present(DatePickerViewController(startDate: self.birthdayString.rookDatefromLongString!), on: self)
    }
    
    @objc private func updateBirthday(notification: Notification) {
        if let info = notification.userInfo {
            let userInfo = info as! [String: Date]
            let chosenDate = userInfo["date"]!
            birthdayString = chosenDate.rookLongStringDate!
            RookBSController.shared().dismiss(from: self)
        }
    }
    
    private func validate() {
        UIView.animate(withDuration: 0.25, animations: {
            self.nextButton.isEnabled = self.gender != nil && self.isDateSet
        })
    }
}

class SignUpPage3ViewController: UIViewController {
    
    private let headingLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "Create Password"
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont(name: "Roboto-Bold", size: 22)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let passwordTextField: RookRoundText = {
        let textfield = RookRoundText()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "Enter a new password"
        textfield.isSecureEntry = true
        textfield.textFieldWithButton.keyboardType = UIKeyboardType.alphabet
        textfield.isLeft = false
        textfield.TFType = .button
        textfield.buttonText = "Show"
        textfield.textFieldWithButton.tag = 5
        return textfield
    }()
    
    private let nextButton: RookAnimatedLoadingButton = {
        let button = RookAnimatedLoadingButton()
        button.isAnimatable = false
        button.title = "Next"
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let passwordStrengthLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "Password Strength:"
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont(name: "Roboto-Medium", size: 12)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let strengthTypeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.red
        label.text = "Very Weak"
        label.numberOfLines = 1
        label.textAlignment = .right
        label.font = UIFont(name: "Roboto-Medium", size: 12)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let RookCheckMarks: [RookCheckMark] = {
        var marks: [RookCheckMark] = []
        for i in 1...3 {
            let mark = RookCheckMark()
            mark.translatesAutoresizingMaskIntoConstraints = false
            mark.isOn = false
            mark.tag = i
            marks.append(mark)
        }
        return marks
    }()
    
    private let validationLabels: [UILabel] = {
        var labels: [UILabel] = []
        let strings = ["Must have at least 8 characters","Must include a special character","Must include a capital letter"]
        for i in 0...2 {
            let label = UILabel()
            label.numberOfLines = 1
            label.text = strings[i]
            label.textColor = UIColor.white
            label.textAlignment = .left
            label.font = UIFont(name: "Roboto-Medium", size: 12)
            label.adjustsFontSizeToFitWidth = true
            label.minimumScaleFactor = 0.8
            label.translatesAutoresizingMaskIntoConstraints = false
            labels.append(label)
        }
        return labels
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(headingLabel)
        view.addSubview(passwordTextField)
        self.passwordTextField.textFieldWithButton.button.addTarget(self, action: #selector(togglePasswordVisible(_:)), for: .touchUpInside)
        view.addSubview(passwordStrengthLabel)
        view.addSubview(strengthTypeLabel)
        view.addSubview(nextButton)
        self.nextButton.addTarget(self, action: #selector(handleNext(_:)), for: .touchUpInside)
        
        for i in 0...2 {
            view.addSubview(self.RookCheckMarks[i])
            view.addSubview(self.validationLabels[i])
        }
        
        configureConstraints()
        self.nextButton.isEnabled = false
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange(_:)), name: UITextField.textDidChangeNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        NotificationCenter.default.removeObserver(self, name: UITextField.textDidChangeNotification, object: nil)
    }
    
    private func configureConstraints() {
        let height = UIScreen.main.bounds.height
        let width = UIScreen.main.bounds.width
        let screenRatio = UIScreen.main.bounds.height/UIScreen.main.bounds.width
        let distanceToTop: CGFloat = (screenRatio < 2.0 && self.sizeClass() != (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) ? 30 : 40
        let textFontSize: CGFloat = (self.sizeClass() == (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) ? 35 : 24
        
        let textFieldWIdth: CGFloat = (self.sizeClass() == (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) ? 400 : width-50
        
        let textOffset: CGFloat = width/3.3
        let headingOffset: CGFloat = distanceToTop + 19 + height/24 + (width/4.5)/4.14814815
        
        self.headingLabel.font = UIFont(name: "Roboto-Bold", size: textFontSize)
        self.headingLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: headingOffset).isActive = true
        self.headingLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: textOffset/4.8).isActive = true
        self.headingLabel.heightAnchor.constraint(equalToConstant: headingLabel.intrinsicContentSize.width/7.5).isActive = true
        
        self.passwordTextField.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: height/10).isActive = true
        self.passwordTextField.widthAnchor.constraint(equalToConstant: textFieldWIdth).isActive = true
        self.passwordTextField.heightAnchor.constraint(equalToConstant: textFieldWIdth/7.76).isActive = true
        self.passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        self.passwordStrengthLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: textFontSize/2).isActive = true
        self.passwordStrengthLabel.leftAnchor.constraint(equalTo: passwordTextField.leftAnchor, constant: textFieldWIdth/12).isActive = true
        self.passwordStrengthLabel.rightAnchor.constraint(equalTo: passwordStrengthLabel.rightAnchor).isActive = true
        self.passwordStrengthLabel.font = UIFont(name: "Roboto-Medium", size: textFontSize/2)
        
        self.strengthTypeLabel.centerYAnchor.constraint(equalTo: passwordStrengthLabel.centerYAnchor).isActive = true
        self.strengthTypeLabel.rightAnchor.constraint(equalTo: passwordTextField.rightAnchor, constant: -textFieldWIdth/12).isActive = true
        self.strengthTypeLabel.leftAnchor.constraint(equalTo: passwordStrengthLabel.leftAnchor).isActive = true
        self.strengthTypeLabel.font = passwordStrengthLabel.font
        
        let checkMarkSize: CGFloat = (self.sizeClass() == (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) ? 20 : 16
        for i in 0...2 {
            let bottomAnchor = (i == 0) ? self.passwordStrengthLabel.bottomAnchor  : self.RookCheckMarks[i-1].bottomAnchor
            let spacing: CGFloat = (i == 0) ? height/18: textFieldWIdth/25
            self.RookCheckMarks[i].topAnchor.constraint(equalTo: bottomAnchor, constant: spacing).isActive = true
            self.RookCheckMarks[i].leftAnchor.constraint(equalTo: passwordTextField.leftAnchor, constant: textFieldWIdth/16).isActive = true
            self.RookCheckMarks[i].widthAnchor.constraint(equalToConstant: checkMarkSize).isActive = true
            self.RookCheckMarks[i].heightAnchor.constraint(equalToConstant: checkMarkSize).isActive = true
            
            self.validationLabels[i].centerYAnchor.constraint(equalTo: RookCheckMarks[i].centerYAnchor).isActive = true
            self.validationLabels[i].leftAnchor.constraint(equalTo: RookCheckMarks[i].rightAnchor, constant: textFieldWIdth/20).isActive = true
            self.validationLabels[i].rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            self.validationLabels[i].font = passwordStrengthLabel.font
        }
        
        self.nextButton.topAnchor.constraint(equalTo: validationLabels[2].bottomAnchor, constant: height/25).isActive = true
        self.nextButton.rightAnchor.constraint(equalTo: passwordTextField.rightAnchor).isActive = true
        self.nextButton.widthAnchor.constraint(equalToConstant: textFieldWIdth/4).isActive = true
        self.nextButton.heightAnchor.constraint(equalToConstant: textFieldWIdth/(4*2.3)).isActive = true
    }
    
    @objc func handleNext(_ sender: Any) {
        self.resignKeyboards()
        RookUser.shared.user.tempPassword = self.passwordTextField.textFieldWithButton.text!
        let vc = self.parent?.parent as! SignUpPagesViewController
        vc.handleNext(sender)
    }
    
    @objc private func togglePasswordVisible(_ sender: Any) {
        self.passwordTextField.isSecureEntry = !self.passwordTextField.isSecureEntry
        if passwordTextField.isSecureEntry {
            self.passwordTextField.buttonText = "Show"
        } else {
            self.passwordTextField.buttonText = "Hide"
        }
    }
    
    @objc private func textDidChange (_ notification: Notification){
        let textfield = notification.object as! UITextField
        self.validate(textfield)
    }
    
    private func validate(_ textField: UITextField? = nil){
        guard let textField = textField else { return }
        
        if textField.tag == 5 {
            var passwordIsValid = false
            
            passwordIsValid = Validator.minLength(8).apply(passwordTextField.textFieldWithButton.text) && Validator.required().apply(passwordTextField.textFieldWithButton.text) && !Validator.isLowercase().apply(passwordTextField.textFieldWithButton.text) && Validator.hasSpecialCharacter().apply(passwordTextField.textFieldWithButton.text)
            RookCheckMarks[0].isOn = Validator.minLength(8).apply(passwordTextField.textFieldWithButton.text)
            RookCheckMarks[1].isOn = Validator.hasSpecialCharacter().apply(passwordTextField.textFieldWithButton.text)
            RookCheckMarks[2].isOn = !Validator.isLowercase().apply(passwordTextField.textFieldWithButton.text)
            
            let strength = Validator.strength(ofPassword: passwordTextField.textFieldWithButton.text)
            
            UIView.animate(withDuration: 0.25, animations: {
                self.strengthTypeLabel.text = strength.rawValue
                self.strengthTypeLabel.textColor = strength.color
                self.nextButton.isEnabled = passwordIsValid
            })
        }
    }
    
    private func resignKeyboards() {
        self.passwordTextField.textFieldWithButton.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.resignKeyboards()
    }
}


class SignUpPage4ViewController: UIViewController, UITextFieldDelegate {
    
    private let headingLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "Phone Number"
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont(name: "Roboto-Bold", size: 22)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var phoneCode: String = "+233" {
        didSet {
            phoneNumberTextField.buttonText = phoneCode
            self.validate()
        }
    }
    
    private let phoneNumberTextField: RookRoundText = {
        let textfield = RookRoundText()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "Enter your phone number"
        textfield.textFieldWithButton.keyboardType = UIKeyboardType.alphabet
        textfield.isLeft = true
        textfield.TFType = .button
        textfield.buttonText = "+233"
        textfield.textFieldWithButton.tag = 4
        return textfield
    }()
    
    private let nextButton: RookAnimatedLoadingButton = {
        let button = RookAnimatedLoadingButton()
        button.isAnimatable = false
        button.title = "Next"
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let phoneFormat = "(NNN) NNN NNNN"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(headingLabel)
        view.addSubview(phoneNumberTextField)
        self.phoneNumberTextField.textFieldWithButton.delegate = self
        self.phoneNumberTextField.textFieldWithButton.button.addTarget(self, action: #selector(selectPhoneCode(_:)), for: .touchUpInside)
        view.addSubview(nextButton)
        self.nextButton.addTarget(self, action: #selector(handleNext(_:)), for: .touchUpInside)
        
        configureConstraints()
        self.nextButton.isEnabled = false
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange(_:)), name: UITextField.textDidChangeNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updatePhoneCode(notification:)), name: NSNotification.Name("localeDoneChosen"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UITextField.textDidChangeNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("localeDoneChosen"), object: nil)
    }
    
    private func configureConstraints() {
        let height = UIScreen.main.bounds.height
        let width = UIScreen.main.bounds.width
        let screenRatio = UIScreen.main.bounds.height/UIScreen.main.bounds.width
        let distanceToTop: CGFloat = (screenRatio < 2.0 && self.sizeClass() != (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) ? 30 : 40
        let textFontSize: CGFloat = (self.sizeClass() == (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) ? 35 : 24
        
        let textFieldWIdth: CGFloat = (self.sizeClass() == (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) ? 400 : width-50
        
        let textOffset: CGFloat = width/3.3
        let headingOffset: CGFloat = distanceToTop + 19 + height/24 + (width/4.5)/4.14814815
        
        self.headingLabel.font = UIFont(name: "Roboto-Bold", size: textFontSize)
        self.headingLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: headingOffset).isActive = true
        self.headingLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: textOffset/4.8).isActive = true
        self.headingLabel.heightAnchor.constraint(equalToConstant: headingLabel.intrinsicContentSize.width/7.5).isActive = true
        
        self.phoneNumberTextField.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: height/10).isActive = true
        self.phoneNumberTextField.widthAnchor.constraint(equalToConstant: textFieldWIdth).isActive = true
        self.phoneNumberTextField.heightAnchor.constraint(equalToConstant: textFieldWIdth/7.76).isActive = true
        self.phoneNumberTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        self.nextButton.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: height/25).isActive = true
        self.nextButton.rightAnchor.constraint(equalTo: phoneNumberTextField.rightAnchor).isActive = true
        self.nextButton.widthAnchor.constraint(equalToConstant: textFieldWIdth/4).isActive = true
        self.nextButton.heightAnchor.constraint(equalToConstant: textFieldWIdth/(4*2.3)).isActive = true
    }
    
    @objc func handleNext(_ sender: Any) {
        self.resignKeyboards()
        let rawDigits = self.phoneNumberTextField.textFieldWithButton.text!
        let digits = rawDigits.unformat(string: rawDigits, with: phoneFormat).dropFirst().lowercased()
        RookUser.shared.user.phone = (self.phoneCode + digits).dropFirst().lowercased()
        RookUser.shared.user.firebaseToken = "Your App Code"
        do {
            let encodedUser = try RookUser.shared.user.asDisctionary()
            RookUser.shared.createUser(type: .email, parameters: encodedUser){ (success, data, error) in
                if success {
                    DispatchQueue.main.async {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "VerificationViewController") as! VerificationViewController
                        vc.phoneNumber = self.phoneNumberTextField.textFieldWithButton.text
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                } else {
                    guard let error = error else { return }
                    let statusMessage = (error as NSError).userInfo["message"] ?? "No message"
                    DispatchQueue.main.async {
                        let controller = VSAlertController(title: "SignUp Failed", message: statusMessage as? String, preferredStyle: VSAlertControllerStyle.alert)
                        controller?.shouldDismissOnBackgroundTap = true
                        controller?.animationStyle = .fall
                        let action = VSAlertAction(title: "Close", style: VSAlertActionStyle.cancel, action: nil)
                        controller?.add(action!)
                        self.present(controller!, animated: true, completion: nil)
                    }
                }
            }
        } catch {
            DispatchQueue.main.async {
                let controller = VSAlertController(title: "Incomplete SignUp Details", message: "Recheck that all information is provided", preferredStyle: VSAlertControllerStyle.alert)
                controller?.shouldDismissOnBackgroundTap = true
                controller?.animationStyle = .fall
                let action = VSAlertAction(title: "Close", style: VSAlertActionStyle.cancel, action: nil)
                controller?.add(action!)
                self.present(controller!, animated: true, completion: nil)
            }
        }
    }
    
    @objc private func updatePhoneCode(notification: Notification) {
        if let info = notification.userInfo {
            let userInfo = info as! [String: LocaleInfo]
            self.phoneCode = (userInfo["locale"]?.phoneCode)!
        }
        RookBSController.shared().dismiss(from: self)
    }
    
    @objc private func textDidChange (_ notification: Notification){
        let textfield = notification.object as! UITextField
        self.validate(textfield)
    }
    
    @objc private func selectPhoneCode(_ sender: Any) {
        RookBSController.shared().present(LocalePickerViewController(type: .phoneCode), on: self)
    }
    
    private func validate(_ textField: UITextField? = nil){
        guard let textField = textField else { return }
        
        if textField.tag == 4 {
            var phoneIsValid = false
            guard let text = phoneNumberTextField.textFieldWithButton.text else {return}
            let unformattedText = text.unformat(string: text, with: "(NNN) NNN NNNN")
            phoneIsValid = Validator.isPhone(.en_GH).apply(unformattedText) && Validator.required().apply(unformattedText)
            self.phoneNumberTextField.textFieldWithButton.errorMessage = (phoneIsValid) ? "" : "Invalid Phone Number"
            
            UIView.animate(withDuration: 0.25, animations: {
                self.nextButton.isEnabled = phoneIsValid
            })
        }
    }
    
    private func resignKeyboards() {
        self.phoneNumberTextField.textFieldWithButton.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.resignKeyboards()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let lastText = (text as NSString).replacingCharacters(in: range, with: string) as String
        textField.text = lastText.format(string: text, with: phoneFormat)
        let notification = Notification(name: UITextField.textDidChangeNotification, object: textField, userInfo: nil)
        self.textDidChange(notification)
        return false
    }
}


class VerificationViewController: UIViewController, RookKeypadVerificationViewDelegate {
    
    private let background: rectGradient = {
        let view = rectGradient()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let backButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Close.png"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let barrook: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "RookBar.png")
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let alreadyAccountLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "#232222")
        label.text = "Already have an account?"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont(name: "Roboto-BoldCondensed", size: 12)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        let textAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont(name: "Roboto-BoldCondensed", size: 12), NSAttributedString.Key.foregroundColor: UIColor(hexString: "#004AEF"), NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let attributedString = NSMutableAttributedString(string: "log in", attributes: textAttributes)
        button.setAttributedTitle(attributedString, for: .normal)
        let textPressedAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont(name: "Roboto-BoldCondensed", size: 12), NSAttributedString.Key.foregroundColor: UIColor.black]
        let attributePresseddString = NSMutableAttributedString(string: "log in", attributes: textPressedAttributes)
        button.setAttributedTitle(attributePresseddString, for: .highlighted)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var phoneNumber: String? {
        didSet {
            guard let phoneNumber = phoneNumber else { return }
            verificationLabel.text = "Enter the verification code sent to the number " + phoneNumber
        }
    }
    
    private let headingLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "Verification"
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont(name: "Roboto-Bold", size: 22)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let verificationLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "Enter the verification code sent to the number +233 *** *** *099"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont(name: "Roboto-Medium", size: 14)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let keyPadContainer: RookKeypadVerificationView = {
        let keypad = RookKeypadVerificationView()
        keypad.translatesAutoresizingMaskIntoConstraints = false
        return keypad
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(background)
        view.addSubview(barrook)
        view.addSubview(backButton)
        self.backButton.addTarget(self, action: #selector(goBack(_:)), for: .touchUpInside)
        view.addSubview(headingLabel)
        view.addSubview(verificationLabel)
        view.addSubview(keyPadContainer)
        self.loginButton.addTarget(self, action: #selector(goToLogin(_:)), for: .touchUpInside)
        keyPadContainer.delegate = self
        configureConstraints()
    }
    
    private func configureConstraints() {
        let height = UIScreen.main.bounds.height
        let width = UIScreen.main.bounds.width
        let screenRatio = UIScreen.main.bounds.height/UIScreen.main.bounds.width
        let distanceToTop: CGFloat = (screenRatio < 2.0 && self.sizeClass() != (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) ? 30 : 40
        let textFontSize: CGFloat = (self.sizeClass() == (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) ? 35 : 24
        
        let keypadWIdth: CGFloat = (self.sizeClass() == (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) ? 400 : width-30
        let textFieldWIdth: CGFloat = (self.sizeClass() == (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) ? 400 : width-50
        
        let textOffset: CGFloat = width/3.3
        let headingOffset: CGFloat = distanceToTop + 19 + height/24 + (width/4.5)/4.14814815
        
        self.background.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.background.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        self.background.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        self.background.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        self.backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: distanceToTop).isActive = true
        self.backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 17).isActive = true
        self.backButton.widthAnchor.constraint(equalToConstant: 12).isActive = true
        self.backButton.heightAnchor.constraint(equalToConstant: 19).isActive = true
        
        self.barrook.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        self.barrook.topAnchor.constraint(equalTo: backButton.topAnchor, constant: height/24).isActive = true
        let aspect = (barrook.image?.size.width)!/(barrook.image?.size.height)!
        self.barrook.widthAnchor.constraint(equalToConstant: width/4.5).isActive = true
        self.barrook.heightAnchor.constraint(equalToConstant: (width/4.5)/aspect).isActive = true
        
        let bottomView = UIView()
        bottomView.backgroundColor = .clear
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomView)
        bottomView.addSubview(loginButton)
        bottomView.addSubview(alreadyAccountLabel)
        
        self.alreadyAccountLabel.heightAnchor.constraint(equalToConstant: textFontSize/1.6).isActive = true
        self.alreadyAccountLabel.font = UIFont(name: "Roboto-BoldCondensed", size: textFontSize/1.4)
        self.alreadyAccountLabel.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor).isActive = true
        self.alreadyAccountLabel.leftAnchor.constraint(equalTo: bottomView.leftAnchor).isActive = true
        
        self.loginButton.centerYAnchor.constraint(equalTo: alreadyAccountLabel.centerYAnchor).isActive = true
        self.loginButton.leftAnchor.constraint(equalTo: alreadyAccountLabel.rightAnchor, constant: 5).isActive = true
        self.loginButton.heightAnchor.constraint(equalToConstant: textFontSize/1.6).isActive = true
        let attributedStrings = self.setFontForAttributedText(with: alreadyAccountLabel.font, color: UIColor(hexString: "#004AEF"), string: "log in")
        self.loginButton.setAttributedTitle(attributedStrings.normal, for: .normal)
        self.loginButton.setAttributedTitle(attributedStrings.highlighted, for: .highlighted)
        
        let distance: CGFloat = (screenRatio < 2.0 && self.sizeClass() != (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) ? -20 : -distanceToTop*1.2
        bottomView.heightAnchor.constraint(equalToConstant: textFontSize/1.6).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: distance).isActive = true
        bottomView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bottomView.widthAnchor.constraint(equalToConstant: alreadyAccountLabel.intrinsicContentSize.width + loginButton.intrinsicContentSize.width + 5).isActive = true
        
        self.headingLabel.font = UIFont(name: "Roboto-Bold", size: textFontSize)
        self.headingLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: headingOffset).isActive = true
        self.headingLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: textOffset/4.8).isActive = true
        self.headingLabel.heightAnchor.constraint(equalToConstant: headingLabel.intrinsicContentSize.width/6.5).isActive = true
        
        self.verificationLabel.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: height/24).isActive = true
        self.verificationLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: textFieldWIdth/20).isActive = true
        self.verificationLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -textFieldWIdth/20).isActive = true
        self.verificationLabel.font = UIFont(name: "Roboto-Medium", size: textFontSize/1.5)
        
        let labelOffset: CGFloat = (height < 570) ? 10 : height/24
        let bottomOffset: CGFloat = distanceToTop*1.2 + textFontSize/1.6 + 20
        self.keyPadContainer.topAnchor.constraint(equalTo: verificationLabel.bottomAnchor, constant: labelOffset).isActive = true
        self.keyPadContainer.widthAnchor.constraint(equalToConstant: keypadWIdth).isActive = true
        self.keyPadContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -bottomOffset).isActive = true
        self.keyPadContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func setFontForAttributedText(with font: UIFont, color: UIColor, string: String) -> (normal: NSMutableAttributedString, highlighted: NSMutableAttributedString) {
        let textAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let attributedString = NSMutableAttributedString(string: string, attributes: textAttributes)
        let textPressedAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.black]
        let attributePressedString = NSMutableAttributedString(string: string, attributes: textPressedAttributes)
        return (attributedString, attributePressedString)
    }
    
    @objc func goBack(_ sender: Any){
        let count = self.navigationController?.viewControllers.count
        if count != nil {
            let presignUpVC = self.navigationController?.viewControllers[count!-3]
            self.navigationController?.popToViewController(presignUpVC!, animated: true)
        }
    }
    
    @objc private func goToLogin(_ sender: Any) {
        let count = self.navigationController?.viewControllers.count
        if count != nil {
            let loginVC = self.navigationController?.viewControllers[count!-4]
            self.navigationController?.popToViewController(loginVC!, animated: true)
        }
    }
    
    func codeView(sender: RookKeypadVerificationView, didFinishInput code: String) {
        print(code)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeScreenViewController") as! WelcomeScreenViewController
        self.present(vc, animated: false, completion: nil)
    }
}

class SocialSignUpViewController: UIViewController, UITextFieldDelegate {
    
    private let background: rectGradient = {
        let view = rectGradient()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let backButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "BackButton.png"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let barrook: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "RookBar.png")
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let alreadyAccountLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "#232222")
        label.text = "Already have an account?"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont(name: "Roboto-BoldCondensed", size: 12)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        let textAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont(name: "Roboto-BoldCondensed", size: 12), NSAttributedString.Key.foregroundColor: UIColor(hexString: "#004AEF"), NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let attributedString = NSMutableAttributedString(string: "log in", attributes: textAttributes)
        button.setAttributedTitle(attributedString, for: .normal)
        let textPressedAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont(name: "Roboto-BoldCondensed", size: 12), NSAttributedString.Key.foregroundColor: UIColor.black]
        let attributePresseddString = NSMutableAttributedString(string: "log in", attributes: textPressedAttributes)
        button.setAttributedTitle(attributePresseddString, for: .highlighted)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let firstNameTextField: RookRoundText = {
        let textfield = RookRoundText()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "First Name"
        textfield.textField.keyboardType = UIKeyboardType.alphabet
        textfield.textField.tag = 1
        return textfield
    }()
    
    private let lastNameTextField: RookRoundText = {
        let textfield = RookRoundText()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "Last Name"
        textfield.textField.keyboardType = UIKeyboardType.alphabet
        textfield.textField.tag = 2
        return textfield
    }()
    
    
    private var phoneCode: String = "+233" {
        didSet {
            phoneNumberTextField.buttonText = phoneCode
            self.validate()
        }
    }
    
    private let phoneNumberTextField: RookRoundText = {
        let textfield = RookRoundText()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "Enter your phone number"
        textfield.textFieldWithButton.keyboardType = UIKeyboardType.alphabet
        textfield.isLeft = true
        textfield.TFType = .button
        textfield.buttonText = "+233"
        textfield.textFieldWithButton.tag = 4
        return textfield
    }()
    
    private let phoneFormat = "(NNN) NNN NNNN"
    
    private let headingLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "Enter your name &"
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont(name: "Roboto-Bold", size: 22)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subHeadingLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "phone"
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont(name: "Roboto-Regular", size: 22)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nextButton: RookAnimatedLoadingButton = {
        let button = RookAnimatedLoadingButton()
        button.isAnimatable = false
        button.title = "Next"
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(background)
        view.addSubview(barrook)
        view.addSubview(backButton)
        self.backButton.addTarget(self, action: #selector(goBack(_:)), for: .touchUpInside)
        view.addSubview(headingLabel)
        view.addSubview(subHeadingLabel)
        view.addSubview(firstNameTextField)
        view.addSubview(lastNameTextField)
        view.addSubview(phoneNumberTextField)
        self.phoneNumberTextField.textFieldWithButton.delegate = self
        self.phoneNumberTextField.textFieldWithButton.button.addTarget(self, action: #selector(selectPhoneCode(_:)), for: .touchUpInside)
        view.addSubview(nextButton)
        self.nextButton.addTarget(self, action: #selector(handleNext(_:)), for: .touchUpInside)
        
        self.loginButton.addTarget(self, action: #selector(goToLogin(_:)), for: .touchUpInside)
        
        configureConstraints()
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange(_:)), name: UITextField.textDidChangeNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updatePhoneCode(notification:)), name: NSNotification.Name("localeDoneChosen"), object: nil)
        self.nextButton.isEnabled = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        NotificationCenter.default.removeObserver(self, name: UITextField.textDidChangeNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("localeDoneChosen"), object: nil)
    }
    
    
    private func configureConstraints() {
        let height = UIScreen.main.bounds.height
        let width = UIScreen.main.bounds.width
        let screenRatio = UIScreen.main.bounds.height/UIScreen.main.bounds.width
        let distanceToTop: CGFloat = (screenRatio < 2.0 && self.sizeClass() != (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) ? 30 : 40
        let textFontSize: CGFloat = (self.sizeClass() == (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) ? 35 : 22
        
        let textFieldWIdth: CGFloat = (self.sizeClass() == (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) ? 400 : width-50
        
        let textOffset: CGFloat = width/3.3
        let headingOffset: CGFloat = distanceToTop + 19 + height/24 + (width/4.5)/4.14814815
        
        self.background.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.background.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        self.background.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        self.background.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        self.backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: distanceToTop).isActive = true
        self.backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 17).isActive = true
        self.backButton.widthAnchor.constraint(equalToConstant: 12).isActive = true
        self.backButton.heightAnchor.constraint(equalToConstant: 19).isActive = true
        
        self.barrook.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        self.barrook.topAnchor.constraint(equalTo: backButton.topAnchor, constant: height/24).isActive = true
        let aspect = (barrook.image?.size.width)!/(barrook.image?.size.height)!
        self.barrook.widthAnchor.constraint(equalToConstant: width/4.5).isActive = true
        self.barrook.heightAnchor.constraint(equalToConstant: (width/4.5)/aspect).isActive = true
        
        let bottomView = UIView()
        bottomView.backgroundColor = .clear
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomView)
        bottomView.addSubview(loginButton)
        bottomView.addSubview(alreadyAccountLabel)
        
        self.alreadyAccountLabel.heightAnchor.constraint(equalToConstant: textFontSize/1.6).isActive = true
        self.alreadyAccountLabel.font = UIFont(name: "Roboto-BoldCondensed", size: textFontSize/1.4)
        self.alreadyAccountLabel.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor).isActive = true
        self.alreadyAccountLabel.leftAnchor.constraint(equalTo: bottomView.leftAnchor).isActive = true
        
        self.loginButton.centerYAnchor.constraint(equalTo: alreadyAccountLabel.centerYAnchor).isActive = true
        self.loginButton.leftAnchor.constraint(equalTo: alreadyAccountLabel.rightAnchor, constant: 5).isActive = true
        self.loginButton.heightAnchor.constraint(equalToConstant: textFontSize/1.6).isActive = true
        let attributedStrings = self.setFontForAttributedText(with: alreadyAccountLabel.font, color: UIColor(hexString: "#004AEF"), string: "log in")
        self.loginButton.setAttributedTitle(attributedStrings.normal, for: .normal)
        self.loginButton.setAttributedTitle(attributedStrings.highlighted, for: .highlighted)
        
        let distance: CGFloat = (screenRatio < 2.0 && self.sizeClass() != (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) ? -20 : -distanceToTop*1.2
        bottomView.heightAnchor.constraint(equalToConstant: textFontSize/1.6).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: distance).isActive = true
        bottomView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bottomView.widthAnchor.constraint(equalToConstant: alreadyAccountLabel.intrinsicContentSize.width + loginButton.intrinsicContentSize.width + 5).isActive = true
        
        self.headingLabel.font = UIFont(name: "Roboto-Bold", size: textFontSize)
        self.headingLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: headingOffset).isActive = true
        self.headingLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: textOffset/4.8).isActive = true
        self.headingLabel.heightAnchor.constraint(equalToConstant: headingLabel.intrinsicContentSize.width/7.5).isActive = true
        
        self.subHeadingLabel.font = headingLabel.font
        self.subHeadingLabel.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: textFontSize/4).isActive = true
        self.subHeadingLabel.leftAnchor.constraint(equalTo: headingLabel.leftAnchor).isActive = true
        self.subHeadingLabel.rightAnchor.constraint(equalTo: headingLabel.rightAnchor).isActive = true
        
        self.firstNameTextField.topAnchor.constraint(equalTo: subHeadingLabel.bottomAnchor, constant: height/10).isActive = true
        self.firstNameTextField.widthAnchor.constraint(equalToConstant: textFieldWIdth/2.2).isActive = true
        self.firstNameTextField.heightAnchor.constraint(equalToConstant: textFieldWIdth/7.76).isActive = true
        self.firstNameTextField.leftAnchor.constraint(equalTo: phoneNumberTextField.leftAnchor).isActive = true
        
        self.lastNameTextField.centerYAnchor.constraint(equalTo: firstNameTextField.centerYAnchor).isActive = true
        self.lastNameTextField.widthAnchor.constraint(equalToConstant: textFieldWIdth/2.2).isActive = true
        self.lastNameTextField.heightAnchor.constraint(equalToConstant: textFieldWIdth/7.76).isActive = true
        self.lastNameTextField.rightAnchor.constraint(equalTo: phoneNumberTextField.rightAnchor).isActive = true
        
        self.phoneNumberTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: height/25).isActive = true
        self.phoneNumberTextField.widthAnchor.constraint(equalToConstant: textFieldWIdth).isActive = true
        self.phoneNumberTextField.heightAnchor.constraint(equalToConstant: textFieldWIdth/7.76).isActive = true
        self.phoneNumberTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        self.nextButton.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: height/25).isActive = true
        self.nextButton.rightAnchor.constraint(equalTo: phoneNumberTextField.rightAnchor).isActive = true
        self.nextButton.widthAnchor.constraint(equalToConstant: textFieldWIdth/4).isActive = true
        self.nextButton.heightAnchor.constraint(equalToConstant: textFieldWIdth/(4*2.3)).isActive = true
    }
    
    private func setFontForAttributedText(with font: UIFont, color: UIColor, string: String) -> (normal: NSMutableAttributedString, highlighted: NSMutableAttributedString) {
        let textAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let attributedString = NSMutableAttributedString(string: string, attributes: textAttributes)
        let textPressedAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.black]
        let attributePressedString = NSMutableAttributedString(string: string, attributes: textPressedAttributes)
        return (attributedString, attributePressedString)
    }
    
    @objc func goBack(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func handleNext(_ sender: Any) {
        self.resignKeyboards()
        RookUser.shared.user.firstName = self.firstNameTextField.textField.text!
        RookUser.shared.user.lastName = self.lastNameTextField.textField.text!
        let rawDigits = self.phoneNumberTextField.textFieldWithButton.text!
        let digits = rawDigits.unformat(string: rawDigits, with: phoneFormat).dropFirst().lowercased()
        RookUser.shared.user.phone = (self.phoneCode + digits).dropFirst().lowercased()
        RookUser.shared.user.firebaseToken = "Your App Code"
        do {
            let encodedUser = try RookUser.shared.user.asDisctionary()
            print(encodedUser)
            RookUser.shared.createUser(type: .social, parameters: encodedUser) { (success, data, error) in
                if success {
                    DispatchQueue.main.async {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "VerificationViewController") as! VerificationViewController
                        vc.phoneNumber = self.phoneNumberTextField.textFieldWithButton.text
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                } else {
                    guard let error = error else { return }
                    let statusMessage = (error as NSError).userInfo["message"] ?? "No message"
                    DispatchQueue.main.async {
                        let controller = VSAlertController(title: "SignUp Failed", message: statusMessage as? String, preferredStyle: VSAlertControllerStyle.alert)
                        controller?.shouldDismissOnBackgroundTap = true
                        controller?.animationStyle = .fall
                        let action = VSAlertAction(title: "Close", style: VSAlertActionStyle.cancel, action: nil)
                        controller?.add(action!)
                        self.present(controller!, animated: true, completion: nil)
                    }
                }
            }
        } catch {
            DispatchQueue.main.async {
                let controller = VSAlertController(title: "Sign Up Failed", message: "Try again later!", preferredStyle: VSAlertControllerStyle.alert)
                controller?.shouldDismissOnBackgroundTap = true
                controller?.animationStyle = .fall
                let action = VSAlertAction(title: "Close", style: VSAlertActionStyle.cancel, action: nil)
                controller?.add(action!)
                self.present(controller!, animated: true, completion: nil)
            }
        }
    }
    
    @objc private func goToLogin(_ sender: Any) {
        let count = self.navigationController?.viewControllers.count
        if count != nil {
            let loginVC = self.navigationController?.viewControllers[count!-3]
            self.navigationController?.popToViewController(loginVC!, animated: true)
        }
    }
    
    @objc private func updatePhoneCode(notification: Notification) {
        if let info = notification.userInfo {
            let userInfo = info as! [String: LocaleInfo]
            self.phoneCode = (userInfo["locale"]?.phoneCode)!
        }
        RookBSController.shared().dismiss(from: self)
    }
    
    @objc private func textDidChange (_ notification: Notification){
        let textfield = notification.object as! UITextField
        self.validate(textfield)
    }
    
    @objc private func selectPhoneCode(_ sender: Any) {
        RookBSController.shared().present(LocalePickerViewController(type: .phoneCode), on: self)
    }
    
    private func validate(_ textField: UITextField? = nil){
        var fnameIsValid = false
        var lnameIsValid = false
        var phoneIsValid = false
        
        fnameIsValid = Validator.isASCII().apply(firstNameTextField.textField.text) && Validator.required().apply(firstNameTextField.textField.text)
        firstNameTextField.textField.errorMessage = (fnameIsValid) ? "" : "Invalid First Name"
        
        lnameIsValid = Validator.isASCII().apply(lastNameTextField.textField.text) && Validator.required().apply(lastNameTextField.textField.text)
        lastNameTextField.textField.errorMessage = (lnameIsValid) ? "" : "Invalid Last Name"
        
        guard let text = phoneNumberTextField.textFieldWithButton.text else {return}
        let unformattedText = text.unformat(string: text, with: "(NNN) NNN NNNN")
        phoneIsValid = Validator.isPhone(.en_GH).apply(unformattedText) && Validator.required().apply(unformattedText)
        self.phoneNumberTextField.textFieldWithButton.errorMessage = (phoneIsValid) ? "" : "Invalid Phone Number"
            
        UIView.animate(withDuration: 0.25, animations: {
            self.nextButton.isEnabled = phoneIsValid && fnameIsValid && lnameIsValid
        })
        
    }
    
    private func resignKeyboards() {
        self.firstNameTextField.textField.resignFirstResponder()
        self.lastNameTextField.textField.resignFirstResponder()
        self.phoneNumberTextField.textFieldWithButton.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.resignKeyboards()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let lastText = (text as NSString).replacingCharacters(in: range, with: string) as String
        textField.text = lastText.format(string: text, with: phoneFormat)
        let notification = Notification(name: UITextField.textDidChangeNotification, object: textField, userInfo: nil)
        self.textDidChange(notification)
        return false
    }
}
