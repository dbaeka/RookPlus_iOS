//
//  LoginViewController.swift
//  Rook+
//
//  Created by Delmwin Baeka on 1/25/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import TwitterKit
import LinkedinSwift
import VSAlert
import SwiftyJSON

class LoginViewController: UIViewController {
    
    private let linkedinHelper = LinkedinSwiftHelper(configuration: LinkedinSwiftConfiguration(clientId: "813got1qgr4n0g", clientSecret: "Rrs0hRXL1cbmdgr2", state: "DLKDJF46ikMMZADfdfds", permissions: ["r_basicprofile", "r_emailaddress"], redirectUrl: "https://myrookery.com"))

    private let spiral: spiralShape = {
        let spiral = spiralShape()
        spiral.backgroundColor = .clear
        spiral.translatesAutoresizingMaskIntoConstraints = false
        return spiral
    }()
    
    private let logingradient: loginGradient = {
        let gradient = loginGradient()
        gradient.backgroundColor = .clear
        gradient.translatesAutoresizingMaskIntoConstraints = false
        return gradient
    }()
    
    private let barrook: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "RookBar.png")
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let backButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "BackButton.png"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let blueCircle: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#3B8BFF")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let orangeCircle: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#FF5500")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let emailTextField: RookRoundText = {
        let textfield = RookRoundText()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "Email Address"
        textfield.textField.keyboardType = .emailAddress
        textfield.textField.tag = 1
        return textfield
    }()
    
    private let passwordTextField: RookRoundText = {
        let textfield = RookRoundText()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "Password"
        textfield.isSecureEntry = true
        textfield.textFieldWithButton.keyboardType = UIKeyboardType.alphabet
        textfield.isLeft = false
        textfield.TFType = .button
        textfield.buttonText = "Show"
        textfield.textFieldWithButton.tag = 2
        return textfield
    }()
    
    private let forgotPasswordButton : UIButton = {
        let button = UIButton()
        let textAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont(name: "Roboto-Regular", size: 12), NSAttributedString.Key.foregroundColor: UIColor(hexString: "#9B9B9B")]
        let attributedString = NSMutableAttributedString(string: "Forgot password?", attributes: textAttributes)
        button.setAttributedTitle(attributedString, for: .normal)
        let textPressedAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont(name: "Roboto-Regular", size: 12), NSAttributedString.Key.foregroundColor: UIColor(hexString: "#CCCCCC")]
        let attributePresseddString = NSMutableAttributedString(string: "Forgot password?", attributes: textPressedAttributes)
        button.setAttributedTitle(attributePresseddString, for: .highlighted)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let noAccountLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "#9B9B9B")
        label.text = "Dont't have an account?"
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont(name: "Roboto-Regular", size: 12)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let signInButton: RookAnimatedLoadingButton = {
        let button = RookAnimatedLoadingButton()
        button.isAnimatable = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        let textAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont(name: "Roboto-Medium", size: 12), NSAttributedString.Key.foregroundColor: UIColor(hexString: "#004AEF"), NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let attributedString = NSMutableAttributedString(string: "Sign Up", attributes: textAttributes)
        button.setAttributedTitle(attributedString, for: .normal)
        let textPressedAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont(name: "Roboto-Regular", size: 12), NSAttributedString.Key.foregroundColor: UIColor(hexString: "#CCCCCC")]
        let attributePresseddString = NSMutableAttributedString(string: "Sign Up", attributes: textPressedAttributes)
        button.setAttributedTitle(attributePresseddString, for: .highlighted)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let orLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "#9B9B9B")
        label.text = "OR"
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont(name: "Roboto-Regular", size: 13)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let headingLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "Join the community"
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont(name: "Roboto-Bold", size: 40)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subHeadingLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "of growing intellects"
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont(name: "Roboto-Regular", size: 30)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let linkedInButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "G+"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let facebookButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Facebook"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let twitterButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Twitter"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var hiddenItems: [UIView]?
    
    private var yConstraints: [NSLayoutConstraint]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.spiral.strokeStartAnimation.delegate = self
        
        view.addSubview(logingradient)
        view.addSubview(barrook)
        view.addSubview(backButton)
        self.backButton.addTarget(self, action: #selector(goBack(_:)), for: .touchUpInside)
        view.addSubview(spiral)
        view.addSubview(blueCircle)
        view.addSubview(orangeCircle)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
         self.passwordTextField.textFieldWithButton.button.addTarget(self, action: #selector(togglePasswordVisible(_:)), for: .touchUpInside)
        view.addSubview(forgotPasswordButton)
        view.addSubview(noAccountLabel)
        view.addSubview(signInButton)
        self.signInButton.addTarget(self, action: #selector(signInUser(_:)), for: .touchUpInside)
        view.addSubview(signUpButton)
        signUpButton.addTarget(self, action: #selector(goToSignUp(_:)), for: .touchUpInside)
        view.addSubview(orLabel)
        view.addSubview(headingLabel)
        view.addSubview(subHeadingLabel)
        view.addSubview(linkedInButton)
         self.linkedInButton.addTarget(self, action: #selector(handleLinkedIn), for: .touchUpInside)
        view.addSubview(facebookButton)
         self.facebookButton.addTarget(self, action: #selector(socialMediaRegister(_:)), for: .touchUpInside)
        view.addSubview(twitterButton)
         self.twitterButton.addTarget(self, action: #selector(twitterConnect), for: .touchUpInside)
        
        self.hiddenItems = [blueCircle, orangeCircle, emailTextField, passwordTextField, forgotPasswordButton, noAccountLabel, signInButton, signUpButton, orLabel, linkedInButton, facebookButton, twitterButton]

        self.yConstraints = []
        
        configureConstraints()
        self.signInButton.isEnabled = false
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange(_:)), name: UITextField.textDidChangeNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        for item in hiddenItems! {
            item.alpha = 0.0
        }
        for item in yConstraints! {
            item.constant += 10
        }
        self.view.layoutIfNeeded()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        NotificationCenter.default.removeObserver(self, name: UITextField.textDidChangeNotification, object: nil)
    }
    
    @objc func goBack(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func togglePasswordVisible(_ sender: Any) {
        self.passwordTextField.isSecureEntry = !self.passwordTextField.isSecureEntry
        if passwordTextField.isSecureEntry {
            self.passwordTextField.buttonText = "Show"
        } else {
            self.passwordTextField.buttonText = "Hide"
        }
    }
    
    private func configureConstraints() {
        let height = UIScreen.main.bounds.height
        let width = UIScreen.main.bounds.width
        self.logingradient.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.logingradient.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        self.logingradient.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        self.logingradient.heightAnchor.constraint(equalToConstant: height/2).isActive = true
        
        let screenRatio = UIScreen.main.bounds.height/UIScreen.main.bounds.width
        let distanceToTop: CGFloat = (screenRatio < 2.0 && self.sizeClass() != (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) ? 30 : 40
        self.backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: distanceToTop).isActive = true
        self.backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 17).isActive = true
        self.backButton.widthAnchor.constraint(equalToConstant: 12).isActive = true
        self.backButton.heightAnchor.constraint(equalToConstant: 19).isActive = true
        
        self.barrook.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        self.barrook.topAnchor.constraint(equalTo: backButton.topAnchor, constant: height/24).isActive = true
        let aspect = (barrook.image?.size.width)!/(barrook.image?.size.height)!
        self.barrook.widthAnchor.constraint(equalToConstant: width/4.5).isActive = true
        self.barrook.heightAnchor.constraint(equalToConstant: (width/4.5)/aspect).isActive = true
        
        self.spiral.bottomAnchor.constraint(equalTo: logingradient.bottomAnchor).isActive = true
        self.spiral.leftAnchor.constraint(equalTo: logingradient.leftAnchor).isActive = true
        self.spiral.heightAnchor.constraint(equalToConstant: height/(2*1.44)).isActive = true
        self.spiral.widthAnchor.constraint(equalToConstant: width/1.113).isActive = true
        
        self.blueCircle.widthAnchor.constraint(equalToConstant: width/22).isActive = true
        self.blueCircle.heightAnchor.constraint(equalToConstant: width/22).isActive = true
        self.blueCircle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: width/3.68).isActive = true
        let blueCircleTopAnchor = self.blueCircle.topAnchor.constraint(equalTo: view.topAnchor, constant: height/3.62)
        blueCircleTopAnchor.isActive = true
        self.yConstraints?.append(blueCircleTopAnchor)
        self.blueCircle.layer.cornerRadius = width/44
        
        self.orangeCircle.widthAnchor.constraint(equalToConstant: width/20).isActive = true
        self.orangeCircle.heightAnchor.constraint(equalToConstant: width/20).isActive = true
        self.orangeCircle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: width/2.9).isActive = true
        let orangeCircleTopAnchor = self.orangeCircle.topAnchor.constraint(equalTo: view.topAnchor, constant: height/3.0)
        orangeCircleTopAnchor.isActive = true
        self.yConstraints?.append(orangeCircleTopAnchor)
        self.orangeCircle.layer.cornerRadius = width/40
        
        let textFieldWIdth: CGFloat = (self.sizeClass() == (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) ? 400 : width-50
        let usernameTFBottomAnchor = self.emailTextField.bottomAnchor.constraint(equalTo: logingradient.bottomAnchor, constant: -30)
        usernameTFBottomAnchor.isActive = true
        self.yConstraints?.append(usernameTFBottomAnchor)
        self.emailTextField.widthAnchor.constraint(equalToConstant: textFieldWIdth).isActive = true
        self.emailTextField.heightAnchor.constraint(equalToConstant: textFieldWIdth/7.76).isActive = true
        self.emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        let passwordTFTopAnchor = self.passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20)
        passwordTFTopAnchor.isActive = true
        self.yConstraints?.append(passwordTFTopAnchor)
        self.passwordTextField.widthAnchor.constraint(equalToConstant: textFieldWIdth).isActive = true
        self.passwordTextField.heightAnchor.constraint(equalToConstant: textFieldWIdth/7.76).isActive = true
        self.passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    
        let forgotPasswordTopAnchor = self.forgotPasswordButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 12)
        forgotPasswordTopAnchor.isActive = true
        self.yConstraints?.append(forgotPasswordTopAnchor)
        self.forgotPasswordButton.rightAnchor.constraint(equalTo: passwordTextField.rightAnchor).isActive = true
        self.forgotPasswordButton.heightAnchor.constraint(equalToConstant: 14).isActive = true
        
        let signInButtonTopAnchor = self.signInButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 8)
        signInButtonTopAnchor.isActive = true
        self.yConstraints?.append(signInButtonTopAnchor)
        self.signInButton.rightAnchor.constraint(equalTo: passwordTextField.rightAnchor).isActive = true
        self.signInButton.widthAnchor.constraint(equalToConstant: textFieldWIdth/5).isActive = true
        self.signInButton.heightAnchor.constraint(equalToConstant: textFieldWIdth/(5*2.3)).isActive = true
        
        self.noAccountLabel.leftAnchor.constraint(equalTo: emailTextField.leftAnchor, constant: 8).isActive = true
        self.noAccountLabel.centerYAnchor.constraint(equalTo: signInButton.centerYAnchor).isActive = true
        self.noAccountLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
        
        self.signUpButton.centerYAnchor.constraint(equalTo: noAccountLabel.centerYAnchor).isActive = true
        self.signUpButton.leftAnchor.constraint(equalTo: noAccountLabel.rightAnchor).isActive = true
        self.signUpButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.signUpButton.widthAnchor.constraint(equalToConstant: 47).isActive = true
        
        self.orLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.orLabel.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 30).isActive = true
        self.orLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
    
        let textOffset: CGFloat = width/3.3
        let labelOffset: CGFloat = (height < 570) ? -12 : 0
        self.headingLabel.topAnchor.constraint(equalTo: barrook.bottomAnchor, constant: distanceToTop/6).isActive = true
        self.headingLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: textOffset/4.8).isActive = true
        self.headingLabel.rightAnchor.constraint(equalTo: spiral.rightAnchor, constant: -40).isActive = true
        self.headingLabel.heightAnchor.constraint(equalToConstant: headingLabel.intrinsicContentSize.width/8).isActive = true
        
        self.subHeadingLabel.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: labelOffset).isActive = true
        self.subHeadingLabel.leftAnchor.constraint(equalTo: headingLabel.leftAnchor).isActive = true
        self.subHeadingLabel.rightAnchor.constraint(equalTo: headingLabel.rightAnchor, constant: -headingLabel.intrinsicContentSize.width/5).isActive = true
        self.subHeadingLabel.heightAnchor.constraint(equalToConstant: subHeadingLabel.intrinsicContentSize.width/8).isActive = true
        
        let imageWidth: CGFloat = textFieldWIdth/7
        self.linkedInButton.widthAnchor.constraint(equalToConstant: imageWidth).isActive = true
        self.linkedInButton.heightAnchor.constraint(equalToConstant: imageWidth).isActive = true
        self.linkedInButton.centerYAnchor.constraint(equalTo: facebookButton.centerYAnchor).isActive = true
        self.linkedInButton.rightAnchor.constraint(equalTo: facebookButton.leftAnchor, constant: -textFieldWIdth/10).isActive = true
        
        self.facebookButton.widthAnchor.constraint(equalToConstant: imageWidth).isActive = true
        self.facebookButton.heightAnchor.constraint(equalToConstant: imageWidth).isActive = true
        self.facebookButton.topAnchor.constraint(equalTo: orLabel.bottomAnchor, constant: height/30).isActive = true
        self.facebookButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        self.twitterButton.widthAnchor.constraint(equalToConstant: imageWidth).isActive = true
        self.twitterButton.heightAnchor.constraint(equalToConstant: imageWidth).isActive = true
        self.twitterButton.centerYAnchor.constraint(equalTo: facebookButton.centerYAnchor).isActive = true
        self.twitterButton.leftAnchor.constraint(equalTo: facebookButton.rightAnchor, constant: textFieldWIdth/10).isActive = true
        
        for i in 0..<2 {
            let lineView = UIView()
            self.hiddenItems?.append(lineView)
            lineView.translatesAutoresizingMaskIntoConstraints = false
            lineView.backgroundColor = UIColor(hexString: "#E5E5E5")
            self.view.addSubview(lineView)
            lineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
            lineView.centerYAnchor.constraint(equalTo: orLabel.centerYAnchor).isActive = true
            
            if (i == 0) {
                lineView.leftAnchor.constraint(equalTo: emailTextField.leftAnchor, constant: 20).isActive = true
                lineView.rightAnchor.constraint(equalTo: orLabel.leftAnchor, constant: -5).isActive = true
            } else {
                lineView.rightAnchor.constraint(equalTo: emailTextField.rightAnchor, constant: -20).isActive = true
                lineView.leftAnchor.constraint(equalTo: orLabel.rightAnchor, constant: 5).isActive = true
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.spiral.startAnimation()
    }
    
    @objc private func textDidChange (_ notification: Notification){
        self.validate()
    }
    
    private func validate(_ textField: UITextField? = nil){
        var passwordIsValid = false
        var emailIsValid = false
        
        emailIsValid = Validator.isEmail().apply(emailTextField.textField.text) && Validator.required().apply(emailTextField.textField.text)
        emailTextField.textField.errorMessage = (emailIsValid) ? "" : "Invalid Email"
        
        passwordIsValid = Validator.required().apply(passwordTextField.textFieldWithButton.text)
        
        UIView.animate(withDuration: 0.25, animations: {
            self.signInButton.isEnabled = passwordIsValid
        })
    }
    
    private func resignKeyboards() {
        self.emailTextField.textField.resignFirstResponder()
        self.passwordTextField.textFieldWithButton.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.resignKeyboards()
        self.signInButton.stopAnimating()
    }

    @objc func goToSignUp(_ sender: Any) {
        let signup = self.storyboard?.instantiateViewController(withIdentifier: "signUp")
        guard let vc = signup else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func signInUser(_ sender: Any) {
        RookUser.shared.login(email: self.emailTextField.textField.text!, password: self.passwordTextField.textFieldWithButton.text!) { (success, data, error) in
            if (success) {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0, execute: {
                    RookUser.shared.user.refresh(completion: { (success, data, error) in
                        if (success){
                            DispatchQueue.main.async {
                                guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainNavigationController") else {return}
                                self.present(vc, animated: true, completion: nil)
                            }
                        }
                    })
                    })
                
            } else {
                self.signInButton.stopAnimating()
                guard let error = error else { return }
                let statusMessage = (error as NSError).userInfo["message"] ?? "No message"
                DispatchQueue.main.async {
                    let controller = VSAlertController(title: "Incorrect Login Credential", message: statusMessage as? String, preferredStyle: VSAlertControllerStyle.alert)
                    controller?.shouldDismissOnBackgroundTap = true
                    controller?.animationStyle = .fall
                    let action = VSAlertAction(title: "Close", style: VSAlertActionStyle.cancel, action: nil)
                    controller?.add(action!)
                    self.present(controller!, animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc func socialMediaRegister(_ sender: Any) {
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) -> Void in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                // if user cancel the login
                if (result?.isCancelled)!{
                    return
                }
                if(fbloginresult.grantedPermissions.contains("email"))
                {
                    self.getFBUserData()
                }
            }
        }
    }
    
    @objc func twitterConnect() {
        TWTRTwitter.sharedInstance().logIn { (session, error) in
            guard let session = session else {
                print("error: \(String(describing: error?.localizedDescription))")
                return
            }
            let client = TWTRAPIClient.withCurrentUser()
            let request = client.urlRequest(withMethod: "GET", urlString: "https://api.twitter.com/1.1/account/verify_credentials.json", parameters: ["include_email": "true", "skip_status": "true"], error: nil)
            client.sendTwitterRequest(request) { (response, data, connectionError) in
                if connectionError != nil {
                    print("Error: \(connectionError)")
                }
                do {
                    guard let data = data else { return }
                    let json = try JSON(data: data)
                    let email = json["email"].string
                    let id = json["id_str"].string
                    let avatar = json["default_profile_image"].boolValue ? "" : json["profile_image_url_https"].string
                    let location = json["location"].string
                    print("json: \(email! + id! + avatar!)")
                } catch let jsonError {
                    print("json error: \(jsonError.localizedDescription)")
                }
            }
        }
    }
    
    @objc func handleLinkedIn() {
        linkedinHelper.authorizeSuccess({ (lsToken) -> Void in
            //Login success lsToken
            self.linkedinHelper.requestURL("https://api.linkedin.com/v1/people/~:(id,first-name,last-name,email-address,industry,picture-url,picture-urls::(original),positions,date-of-birth,phone-numbers,location)?format=json", requestType: LinkedinSwiftRequestGet, success: { (response) -> Void in
                let json = JSON(response.jsonObject)
                print(json)
                let email = json["emailAddress"].string
                let id = json["id"].string
                let avatar = json["pictureUrl"].boolValue ? "" : json["pictureUrl"].string
                let location = json["location"]["name"].string
                let fname = json["firstName"].string
                let lname = json["lastName"].string
                let positions = json["positions"]
                let industry = json["industry"].string
            }) {(error) -> Void in
                
                print(error.localizedDescription)
                //handle the error
            }
        }, error: { (error) -> Void in
            //Encounter error: error.localizedDescription
        }, cancel: { () -> Void in
            //User Cancelled!
        })
    }
    
    private func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    //everything works print the user data
                    guard let result = result else { return }
                    let json = JSON(result)
                    let email = json["email"].string
                    let id = json["id"].string
                    let avatar = json["picture"].exists() ?  json["picture"]["data"]["url"].string : ""
                    let fname = json["first_name"].string
                    let lname = json["last_name"].string
                    print(email!+id!+avatar!+fname!+lname!)
                }
            })
        }
    }
    
}


extension LoginViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        UIView.animate(withDuration: 0.7, delay: 0.0, options: .curveEaseInOut, animations: {
            for item in self.hiddenItems! {
                item.alpha = 1.0
            }
            
            for item in self.yConstraints! {
                item.constant -= 10
            }
            self.view.layoutIfNeeded()
            }) { (finished) in
                //Completion
        }
       
    }
}
