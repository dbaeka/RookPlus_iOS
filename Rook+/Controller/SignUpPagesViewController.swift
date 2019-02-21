//
//  SignUpPagesViewController.swift
//  Rook+
//
//  Created by Delmwin Baeka on 1/29/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

class SignUpPagesViewController: UIViewController {

    //MARK: - Properties
    var scrollViewController: ScrollViewController!
    
    lazy var SignUpPage1: UIViewController! = {
        return self.storyboard?.instantiateViewController(withIdentifier: "SignUpPage1")
    }()
    
    lazy var SignUpPage2: UIViewController! = {
        return self.storyboard?.instantiateViewController(withIdentifier: "SignUpPage2")
    }()
    
    lazy var SignUpPage3: UIViewController! = {
        return self.storyboard?.instantiateViewController(withIdentifier: "SignUpPage3")
    }()
    
    lazy var SignUpPage4: UIViewController! = {
        return self.storyboard?.instantiateViewController(withIdentifier: "SignUpPage4")
    }()
    
    lazy var SignUpPage5: UIViewController! = {
        return self.storyboard?.instantiateViewController(withIdentifier: "SignUpPage5")
    }()
   
  
    
    // MARK: - IBOutlets
    
    
    // MARK: - IBActions
    func handleNext(_ sender: Any) {
        for (index, vc) in viewControllers.enumerated() {
            if scrollViewController.isControllerVisible(vc), index < viewControllers.count - 1  {
                scrollViewController.setController(to: viewControllers[index+1]!, animated: true)
                break
            }
            else if index == viewControllers.count - 1 {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollViewController.scrollView.isScrollEnabled = false
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? ScrollViewController {
            scrollViewController = controller
            scrollViewController.delegate = self
        }
    }
}

// MARK: ScrollViewControllerDelegate
extension SignUpPagesViewController: ScrollViewControllerDelegate {
      
    var viewControllers: [UIViewController?] {
        return [SignUpPage1, SignUpPage2, SignUpPage3, SignUpPage4, SignUpPage5]
    }
    
    var initialViewController: UIViewController {
        return SignUpPage1
    }
}

