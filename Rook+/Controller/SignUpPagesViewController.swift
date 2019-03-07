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
    private let scrollViewController: ScrollViewController = {
        let controller = ScrollViewController()
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        controller.scrollView.isScrollEnabled = false
        controller.scrollView.bounces = true
        return controller
    }()
    
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
   
    
    // MARK: - IBActions
    func handleNext(_ sender: Any) {
        for (index, vc) in viewControllers.enumerated() {
            if scrollViewController.isControllerVisible(vc), index < viewControllers.count - 1  {
                scrollViewController.setController(to: viewControllers[index+1]!, animated: true)
                break
            }
        }
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(background)
        view.addSubview(barrook)
        
        addChild(self.scrollViewController)
        view.addSubview(scrollViewController.view)
        scrollViewController.viewControllers = [SignUpPage1, SignUpPage2, SignUpPage3, SignUpPage4, SignUpPage5]
        scrollViewController.delegate = self
        
        view.addSubview(backButton)
        self.backButton.addTarget(self, action: #selector(goBack(_:)), for: .touchUpInside)
        
        configureConstraints()
    }
    
    private func configureConstraints() {
        let height = UIScreen.main.bounds.height
        let width = UIScreen.main.bounds.width
        let screenRatio = UIScreen.main.bounds.height/UIScreen.main.bounds.width
        let distanceToTop: CGFloat = (screenRatio < 2.0 && self.sizeClass() != (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) ? 30 : 40
        let textFontSize: CGFloat = (self.sizeClass() == (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) ? 40 : 20
        
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
        self.alreadyAccountLabel.font = UIFont(name: "Roboto-BoldCondensed", size: textFontSize/1.6)
        self.alreadyAccountLabel.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor).isActive = true
            
        self.loginButton.centerYAnchor.constraint(equalTo: alreadyAccountLabel.centerYAnchor).isActive = true
        self.loginButton.leftAnchor.constraint(equalTo: alreadyAccountLabel.rightAnchor, constant: 5).isActive = true
        self.loginButton.heightAnchor.constraint(equalToConstant: textFontSize/1.6).isActive = true
        let attributedStrings = self.setFontForAttributedText(with: alreadyAccountLabel.font, color: UIColor(hexString: "#004AEF"), string: "log in")
        self.loginButton.setAttributedTitle(attributedStrings.normal, for: .normal)
        self.loginButton.setAttributedTitle(attributedStrings.highlighted, for: .highlighted)
        
        bottomView.heightAnchor.constraint(equalToConstant: textFontSize/1.6).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -distanceToTop*1.2).isActive = true
        bottomView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bottomView.widthAnchor.constraint(equalToConstant: alreadyAccountLabel.intrinsicContentSize.width + loginButton.intrinsicContentSize.width + 5).isActive = true
        
        self.scrollViewController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.scrollViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.scrollViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        self.scrollViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    private func setFontForAttributedText(with font: UIFont, color: UIColor, string: String) -> (normal: NSMutableAttributedString, highlighted: NSMutableAttributedString) {
        let textAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let attributedString = NSMutableAttributedString(string: string, attributes: textAttributes)
        let textPressedAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.black]
        let attributePressedString = NSMutableAttributedString(string: string, attributes: textPressedAttributes)
        return (attributedString, attributePressedString)
    }
    
    @objc func goBack(_ sender: Any){
        for (index, vc) in viewControllers.enumerated() {
            if scrollViewController.isControllerVisible(vc), index < viewControllers.count {
                if index == 0 {
                    self.navigationController?.popViewController(animated: true)
                } else {
                    scrollViewController.setController(to: viewControllers[index-1]!, animated: true)
                    break
                }
            }
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

