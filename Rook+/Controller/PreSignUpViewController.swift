//
//  PreSignUpViewController.swift
//  RookPlus
//
//  Created by Delmwin Baeka on 3/5/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import TwitterKit
import LinkedinSwift

class PreSignUpViewController: UIViewController {
    
    private let linkedinHelper = LinkedinSwiftHelper(configuration: LinkedinSwiftConfiguration(clientId: "813got1qgr4n0g", clientSecret: "Rrs0hRXL1cbmdgr2", state: "DLKDJF46ikMMZADfdfds", permissions: ["r_basicprofile", "r_emailaddress"], redirectUrl: "https://myrookery.com"))
    
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
    
    private let emailButton : RookRoundButton = {
        let button = RookRoundButton()
        let textAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont(name: "Roboto-Bold", size: 13), NSAttributedString.Key.foregroundColor: UIColor(hexString: "#393939")]
        let attributedString = NSMutableAttributedString(string: "Register with your email", attributes: textAttributes)
        button.setAttributedTitle(attributedString, for: .normal)
        button.backgroundColor = UIColor.white
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let facebookButton : RookRoundButton = {
        let button = RookRoundButton()
        let textAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont(name: "Roboto-Medium", size: 13), NSAttributedString.Key.foregroundColor: UIColor.white]
        let attributedString = NSMutableAttributedString(string: "Register with your Facebook", attributes: textAttributes)
        button.setAttributedTitle(attributedString, for: .normal)
        button.backgroundColor = UIColor(hexString: "#3B5998")
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let linkedInButton : RookRoundButton = {
        let button = RookRoundButton()
        let textAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont(name: "Roboto-Medium", size: 13), NSAttributedString.Key.foregroundColor: UIColor.white]
        let attributedString = NSMutableAttributedString(string: "Register with your Google+", attributes: textAttributes)
        button.setAttributedTitle(attributedString, for: .normal)
        button.backgroundColor = UIColor(hexString: "#DC4E41")
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let twitterButton : RookRoundButton = {
        let button = RookRoundButton()
        let textAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont(name: "Roboto-Medium", size: 13), NSAttributedString.Key.foregroundColor: UIColor.white]
        let attributedString = NSMutableAttributedString(string: "Register with your Twitter", attributes: textAttributes)
        button.setAttributedTitle(attributedString, for: .normal)
        button.backgroundColor = UIColor(hexString: "#00AEEF")
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let termsButton: UIButton = {
        let button = UIButton()
        let textAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont(name: "Roboto-BoldCondensed", size: 12), NSAttributedString.Key.foregroundColor: UIColor(hexString: "#004AEF"), NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let attributedString = NSMutableAttributedString(string: "terms and conditions", attributes: textAttributes)
        button.setAttributedTitle(attributedString, for: .normal)
        let textPressedAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont(name: "Roboto-BoldCondensed", size: 12), NSAttributedString.Key.foregroundColor: UIColor.black]
        let attributePresseddString = NSMutableAttributedString(string: "terms and conditions", attributes: textPressedAttributes)
        button.setAttributedTitle(attributePresseddString, for: .highlighted)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let orLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
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
        label.text = "Take the next steps"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont(name: "Roboto-Bold", size: 40)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subHeadingLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "to Join Us"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont(name: "Roboto-Bold", size: 40)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let byRegisteringLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "#232222")
        label.text = "By registering with us, you are"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont(name: "Roboto-BoldCondensed", size: 12)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let acceptingLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "#232222")
        label.text = "accepting our"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont(name: "Roboto-BoldCondensed", size: 12)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(background)
        view.addSubview(backButton)
        self.backButton.addTarget(self, action: #selector(goBack(_:)), for: .touchUpInside)
        view.addSubview(emailButton)
        self.emailButton.addTarget(self, action: #selector(goToRegistration(_:)), for: .touchUpInside)
        view.addSubview(orLabel)
        view.addSubview(headingLabel)
        view.addSubview(subHeadingLabel)
        view.addSubview(linkedInButton)
        self.linkedInButton.addTarget(self, action: #selector(handleLinkedIn), for: .touchUpInside)
        view.addSubview(facebookButton)
        self.facebookButton.addTarget(self, action: #selector(socialMediaRegister(_:)), for: .touchUpInside)
        view.addSubview(twitterButton)
        self.twitterButton.addTarget(self, action: #selector(twitterConnect), for: .touchUpInside)
        
        configureConstraints()
    }
    
    @objc func goBack(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    private func configureConstraints() {
        let height = UIScreen.main.bounds.height
        let width = UIScreen.main.bounds.width
        let screenRatio = UIScreen.main.bounds.height/UIScreen.main.bounds.width
        let distanceToTop: CGFloat = (screenRatio < 2.0 && self.sizeClass() != (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) ? 30 : 40
        
        self.background.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.background.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        self.background.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        self.background.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        let textFieldWIdth: CGFloat = (self.sizeClass() == (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) ? 400 : width-50
        let textFontSize: CGFloat = (self.sizeClass() == (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) ? 40 : 20
        self.headingLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: height/8).isActive = true
        self.headingLabel.font = UIFont(name: "Roboto-Bold", size: textFontSize)
        self.headingLabel.heightAnchor.constraint(equalToConstant: headingLabel.intrinsicContentSize.width/8).isActive = true
        self.headingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        self.subHeadingLabel.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: textFontSize/4).isActive = true
        self.subHeadingLabel.font = self.headingLabel.font
        self.subHeadingLabel.heightAnchor.constraint(equalToConstant: headingLabel.intrinsicContentSize.width/8).isActive = true
        self.subHeadingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    
        self.backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: distanceToTop).isActive = true
        self.backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 17).isActive = true
        self.backButton.widthAnchor.constraint(equalToConstant: 12).isActive = true
        self.backButton.heightAnchor.constraint(equalToConstant: 19).isActive = true
        
        self.emailButton.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: height/8).isActive = true
        self.emailButton.widthAnchor.constraint(equalToConstant: textFieldWIdth).isActive = true
        self.emailButton.heightAnchor.constraint(equalToConstant: textFieldWIdth/8.28).isActive = true
        self.emailButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        self.orLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.orLabel.topAnchor.constraint(equalTo: emailButton.bottomAnchor, constant: height/14).isActive = true
        self.orLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
        
        self.linkedInButton.leftAnchor.constraint(equalTo: emailButton.leftAnchor).isActive = true
        self.linkedInButton.rightAnchor.constraint(equalTo: emailButton.rightAnchor).isActive = true
        self.linkedInButton.heightAnchor.constraint(equalToConstant: textFieldWIdth/8.28).isActive = true
        self.linkedInButton.topAnchor.constraint(equalTo: facebookButton.bottomAnchor, constant: textFontSize/2).isActive = true
        
        self.facebookButton.leftAnchor.constraint(equalTo: emailButton.leftAnchor).isActive = true
        self.facebookButton.rightAnchor.constraint(equalTo: emailButton.rightAnchor).isActive = true
        self.facebookButton.heightAnchor.constraint(equalToConstant: textFieldWIdth/8.28).isActive = true
        self.facebookButton.topAnchor.constraint(equalTo: orLabel.bottomAnchor, constant: height/14).isActive = true
        
        self.twitterButton.leftAnchor.constraint(equalTo: emailButton.leftAnchor).isActive = true
        self.twitterButton.rightAnchor.constraint(equalTo: emailButton.rightAnchor).isActive = true
        self.twitterButton.heightAnchor.constraint(equalToConstant: textFieldWIdth/8.28).isActive = true
        self.twitterButton.topAnchor.constraint(equalTo: linkedInButton.bottomAnchor, constant: textFontSize/2).isActive = true
        
        let bottomView = UIView()
        bottomView.backgroundColor = .clear
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomView)
        bottomView.addSubview(termsButton)
        
        self.byRegisteringLabel.heightAnchor.constraint(equalToConstant: textFontSize/1.6).isActive = true
        self.termsButton.heightAnchor.constraint(equalToConstant: textFontSize/1.6).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: textFontSize/1.6).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -distanceToTop*1.2).isActive = true
        bottomView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        if (self.sizeClass() == (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) {
            bottomView.addSubview(byRegisteringLabel)

            self.byRegisteringLabel.text = "By registering with us, you are accepting our"
            self.byRegisteringLabel.font = UIFont(name: "Roboto-BoldCondensed", size: textFontSize/1.6)
            self.byRegisteringLabel.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor).isActive = true
        
            self.termsButton.centerYAnchor.constraint(equalTo: byRegisteringLabel.centerYAnchor).isActive = true
            self.termsButton.leftAnchor.constraint(equalTo: byRegisteringLabel.rightAnchor, constant: 5).isActive = true
            let attributedStrings = self.setFontForAttributedText(with: byRegisteringLabel.font, color: UIColor(hexString: "#004AEF"), string: "terms and conditions")
            self.termsButton.setAttributedTitle(attributedStrings.normal, for: .normal)
            self.termsButton.setAttributedTitle(attributedStrings.highlighted, for: .highlighted)

            bottomView.widthAnchor.constraint(equalToConstant: byRegisteringLabel.intrinsicContentSize.width + termsButton.intrinsicContentSize.width + 5).isActive = true
        } else {
            view.addSubview(byRegisteringLabel)
            bottomView.addSubview(acceptingLabel)
            self.acceptingLabel.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor).isActive = true
            self.acceptingLabel.leftAnchor.constraint(equalTo: bottomView.leftAnchor).isActive = true
    
            self.byRegisteringLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            
            self.termsButton.centerYAnchor.constraint(equalTo: acceptingLabel.centerYAnchor).isActive = true
            self.termsButton.leftAnchor.constraint(equalTo: acceptingLabel.rightAnchor, constant: 5).isActive = true
            
            bottomView.topAnchor.constraint(equalTo: byRegisteringLabel.bottomAnchor, constant: 4).isActive = true
            bottomView.widthAnchor.constraint(equalToConstant: acceptingLabel.intrinsicContentSize.width + termsButton.intrinsicContentSize.width + 5).isActive = true
        }
        
        for i in 0..<2 {
            let lineView = UIView()
            lineView.translatesAutoresizingMaskIntoConstraints = false
            lineView.backgroundColor = UIColor.white
            self.view.addSubview(lineView)
            lineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
            lineView.centerYAnchor.constraint(equalTo: orLabel.centerYAnchor).isActive = true
            
            if (i == 0) {
                lineView.leftAnchor.constraint(equalTo: emailButton.leftAnchor, constant: 20).isActive = true
                lineView.rightAnchor.constraint(equalTo: orLabel.leftAnchor, constant: -5).isActive = true
            } else {
                lineView.rightAnchor.constraint(equalTo: emailButton.rightAnchor, constant: -20).isActive = true
                lineView.leftAnchor.constraint(equalTo: orLabel.rightAnchor, constant: 5).isActive = true
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
            print(session.userName)
            let client = TWTRAPIClient.withCurrentUser()
            let request = client.urlRequest(withMethod: "GET", urlString: "https://api.twitter.com/1.1/account/verify_credentials.json", parameters: ["include_email": "true", "skip_status": "true"], error: nil)
            client.sendTwitterRequest(request) { (response, data, connectionError) in
                if connectionError != nil {
                    print("Error: \(connectionError)")
                }
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: [.allowFragments])
                    print("json: \(json)")
                } catch let jsonError as NSError {
                    print("json error: \(jsonError.localizedDescription)")
                }
            }
            client.loadUser(withID: session.userID, completion: { (user, error) in
                print(user?.name ?? "")
            })
            client.requestEmail { email, error in
                guard let email = email else {
                    print("error: \(String(describing: error?.localizedDescription))")
                    return
                }
                print("signed in as \(String(describing: session.userName))")
                let recivedEmailID = email
                print(recivedEmailID)
            
            }
        }
    }
    
    @objc func handleLinkedIn() {
        linkedinHelper.authorizeSuccess({ (lsToken) -> Void in
            //Login success lsToken
            self.linkedinHelper.requestURL("https://api.linkedin.com/v1/people/~:(id,first-name,last-name,email-address,picture-url,picture-urls::(original),positions,date-of-birth,phone-numbers,location)?format=json", requestType: LinkedinSwiftRequestGet, success: { (response) -> Void in
                print(response)
                //parse this response which is in the JSON format
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
                    print(result)
                }
            })
        }
    }
    
    @objc func goToRegistration(_ sender: Any) {
        let register = self.storyboard?.instantiateViewController(withIdentifier: "register")
        guard let vc = register else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setFontForAttributedText(with font: UIFont, color: UIColor, string: String) -> (normal: NSMutableAttributedString, highlighted: NSMutableAttributedString) {
        let textAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let attributedString = NSMutableAttributedString(string: string, attributes: textAttributes)
        let textPressedAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.black]
        let attributePressedString = NSMutableAttributedString(string: string, attributes: textPressedAttributes)
        return (attributedString, attributePressedString)
    }
}
