//
//  SignUpPage1ViewController.swift
//  Rook+
//
//  Created by Delmwin Baeka on 1/29/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

class SignUpPage1ViewController: UIViewController {

    @IBAction func handleNext(_ sender: Any) {
        let vc = self.parent?.parent as! SignUpPagesViewController
        vc.handleNext(sender)
    }
}


class SignUpPage2ViewController: UIViewController {
    
    @IBOutlet var maleCardButton: RookGenderButton!
    @IBOutlet var femaleCardButton: RookGenderButton!
    
    @IBAction func handleNext(_ sender: Any) {
        let vc = self.parent?.parent as! SignUpPagesViewController
        vc.handleNext(sender)
    }
    
    @IBAction func handleGenderSelection(_ sender: RookGenderButton) {
        if sender == maleCardButton {
            self.femaleCardButton.isActive = false
        }
        else {
            self.maleCardButton.isActive = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

class SignUpPage3ViewController: UIViewController {
    
    @IBAction func handleNext(_ sender: Any) {
        let vc = self.parent?.parent as! SignUpPagesViewController
        vc.handleNext(sender)
    }
}


class SignUpPage4ViewController: UIViewController {
    
    @IBAction func handleNext(_ sender: Any) {
        let vc = self.parent?.parent as! SignUpPagesViewController
        vc.handleNext(sender)
    }
}


class SignUpPage5ViewController: UIViewController, RookKeypadVerificationViewDelegate {
    
    func codeView(sender: RookKeypadVerificationView, didFinishInput code: String) {
        print(code)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RookTabBarViewController") as! RookTabBarViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBOutlet var keyPadContainer: RookKeypadVerificationView!
    
    override func viewDidLoad() {
        keyPadContainer.delegate = self
    }
}
