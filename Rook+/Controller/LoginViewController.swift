//
//  LoginViewController.swift
//  Rook+
//
//  Created by Delmwin Baeka on 1/25/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var spiral: spiralShape!
    @IBOutlet var usernameTextField: RookRoundText!
    @IBOutlet var passwordTextField: RookRoundText!
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var signInButton: RookAnimatedLoadingButton!
    
    @IBOutlet var hiddenItems: [UIView]!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.spiral.strokeStartAnimation.delegate = self
        
        self.usernameTextField.textField.placeholder = "Username"
        self.usernameTextField.textField.keyboardType = UIKeyboardType.emailAddress
        self.usernameTextField.textField.becomeFirstResponder()
        self.usernameTextField.textField.tag = 1

        
        self.passwordTextField.textField.placeholder = "Password"
        self.passwordTextField.textField.keyboardType = UIKeyboardType.alphabet
        self.passwordTextField.textField.isSecureTextEntry = true
        self.passwordTextField.textField.tag = 2
        
        let signUpAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: signUpButton.titleLabel?.font, NSAttributedString.Key.foregroundColor: signUpButton.titleLabel?.textColor, NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let signUpString = NSMutableAttributedString(string: signUpButton.titleLabel?.text ?? "Sign Up", attributes: signUpAttributes)
        signUpButton.setAttributedTitle(signUpString, for: .normal)
        
        for item in hiddenItems {
            item.alpha = 0.0
            item.frame.origin.y += 10
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.spiral.startAnimation()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.usernameTextField.textField.resignFirstResponder()
        self.passwordTextField.textField.resignFirstResponder()
        self.signInButton.stopAnimating()
    }

}


extension LoginViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        UIView.animate(withDuration: 0.7, delay: 0.0, options: .curveEaseInOut, animations: {
            for item in self.hiddenItems {
                item.alpha = 1.0
                item.frame.origin.y -= 10
            }
            }) { (finished) in
                
        }
       
    }
}
