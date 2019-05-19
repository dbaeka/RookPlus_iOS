//
//  WelcomeScreens.swift
//  RookPlus
//
//  Created by Delmwin Baeka on 3/13/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

class WelcomeScreen1ViewController: UIViewController {
    // MARK: - Properties
    private let background: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let skipButton : UIButton = {
        let button = UIButton()
        let textAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont(name: "Roboto-Regular", size: 15), NSAttributedString.Key.foregroundColor: UIColor.white]
        let attributedString = NSMutableAttributedString(string: "Skip", attributes: textAttributes)
        button.setAttributedTitle(attributedString, for: .normal)
        let textPressedAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont(name: "Roboto-Regular", size: 15), NSAttributedString.Key.foregroundColor: UIColor.gray]
        let attributePresseddString = NSMutableAttributedString(string: "Skip", attributes: textPressedAttributes)
        button.setAttributedTitle(attributePresseddString, for: .highlighted)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let upButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "upButton"), for: .normal)
        button.setImage(UIImage(named: "upButton"), for: .highlighted)
        button.imageView?.contentMode = .scaleAspectFit
        button.isUserInteractionEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let swipeUpLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "swipe up"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont(name: "Roboto-Regular", size: 13)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        view.addSubview(background)
        view.addSubview(swipeUpLabel)
        view.addSubview(upButton)
        view.addSubview(skipButton)
 
        configureConstraints()
        
        view.isUserInteractionEnabled = false
        let screenRatio = UIScreen.main.bounds.height/UIScreen.main.bounds.width
        self.background.image = (screenRatio < 2.0) ? UIImage(named: "Welcome1_4_3") : UIImage(named: "Welcome1_19_6")
    }
    
    private func configureConstraints() {
        let screenRatio = UIScreen.main.bounds.height/UIScreen.main.bounds.width
        let distanceToTop: CGFloat = (screenRatio < 2.0 && self.sizeClass() != (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) ? 20 : 30
        let textFontSize: CGFloat = (self.sizeClass() == (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) ? 40 : 20
        
        let offset: CGFloat = (screenRatio < 2.0 && self.sizeClass() != (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) ? -20 : -44
        self.background.topAnchor.constraint(equalTo: view.topAnchor, constant: offset).isActive = true
        self.background.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        self.background.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        self.background.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height).isActive = true
        
        self.skipButton.topAnchor.constraint(equalTo: view.topAnchor, constant: distanceToTop).isActive = true
        self.skipButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -17).isActive = true
        self.skipButton.heightAnchor.constraint(equalToConstant: 19).isActive = true
        
        let distance: CGFloat = (screenRatio < 2.0 && self.sizeClass() != (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) ? -20 : -distanceToTop*1.2
        self.swipeUpLabel.heightAnchor.constraint(equalToConstant: textFontSize/1.3).isActive = true
        self.swipeUpLabel.font = UIFont(name: "Roboto-Regular", size: textFontSize/1.4)
        self.swipeUpLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.swipeUpLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: distance + offset).isActive = true
        
        self.upButton.centerXAnchor.constraint(equalTo: swipeUpLabel.centerXAnchor).isActive = true
        self.upButton.bottomAnchor.constraint(equalTo: swipeUpLabel.topAnchor, constant: -2).isActive = true
        self.upButton.widthAnchor.constraint(equalToConstant: 27).isActive = true
        self.upButton.heightAnchor.constraint(equalToConstant: 11).isActive = true
    }
}

class WelcomeScreen2ViewController: UIViewController {
    // MARK: - Properties
    private let background: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let skipButton : UIButton = {
        let button = UIButton()
        let textAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont(name: "Roboto-Regular", size: 15), NSAttributedString.Key.foregroundColor: UIColor.white]
        let attributedString = NSMutableAttributedString(string: "Skip", attributes: textAttributes)
        button.setAttributedTitle(attributedString, for: .normal)
        let textPressedAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont(name: "Roboto-Regular", size: 15), NSAttributedString.Key.foregroundColor: UIColor.gray]
        let attributePresseddString = NSMutableAttributedString(string: "Skip", attributes: textPressedAttributes)
        button.setAttributedTitle(attributePresseddString, for: .highlighted)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let upButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "upButton"), for: .normal)
        button.setImage(UIImage(named: "upButton"), for: .highlighted)
        button.imageView?.contentMode = .scaleAspectFit
        button.isUserInteractionEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let swipeUpLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "swipe up"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont(name: "Roboto-Regular", size: 13)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        view.addSubview(background)
        view.addSubview(swipeUpLabel)
        view.addSubview(upButton)
        view.addSubview(skipButton)
        
        configureConstraints()
        
        view.isUserInteractionEnabled = false
        let screenRatio = UIScreen.main.bounds.height/UIScreen.main.bounds.width
        self.background.image = (screenRatio < 2.0) ? UIImage(named: "Welcome2_4_3") : UIImage(named: "Welcome2_19_6")
    }
    
    private func configureConstraints() {
        self.background.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.background.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        self.background.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        self.background.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        let screenRatio = UIScreen.main.bounds.height/UIScreen.main.bounds.width
        let distanceToTop: CGFloat = (screenRatio < 2.0 && self.sizeClass() != (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) ? 20 : 30
        let textFontSize: CGFloat = (self.sizeClass() == (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) ? 40 : 20
        
        self.skipButton.topAnchor.constraint(equalTo: view.topAnchor, constant: distanceToTop).isActive = true
        self.skipButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -17).isActive = true
        self.skipButton.heightAnchor.constraint(equalToConstant: 19).isActive = true
        
        let distance: CGFloat = (screenRatio < 2.0 && self.sizeClass() != (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) ? -20 : -distanceToTop*1.2
        self.swipeUpLabel.heightAnchor.constraint(equalToConstant: textFontSize/1.3).isActive = true
        self.swipeUpLabel.font = UIFont(name: "Roboto-Regular", size: textFontSize/1.4)
        self.swipeUpLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.swipeUpLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: distance).isActive = true
        
        self.upButton.centerXAnchor.constraint(equalTo: swipeUpLabel.centerXAnchor).isActive = true
        self.upButton.bottomAnchor.constraint(equalTo: swipeUpLabel.topAnchor, constant: -2).isActive = true
        self.upButton.widthAnchor.constraint(equalToConstant: 27).isActive = true
        self.upButton.heightAnchor.constraint(equalToConstant: 11).isActive = true
    }
}

class WelcomeScreen3ViewController: UIViewController {
    // MARK: - Properties
    private let background: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let skipButton : UIButton = {
        let button = UIButton()
        let textAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont(name: "Roboto-Regular", size: 15), NSAttributedString.Key.foregroundColor: UIColor.white]
        let attributedString = NSMutableAttributedString(string: "Skip", attributes: textAttributes)
        button.setAttributedTitle(attributedString, for: .normal)
        let textPressedAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont(name: "Roboto-Regular", size: 15), NSAttributedString.Key.foregroundColor: UIColor.gray]
        let attributePresseddString = NSMutableAttributedString(string: "Skip", attributes: textPressedAttributes)
        button.setAttributedTitle(attributePresseddString, for: .highlighted)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let upButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "upButton"), for: .normal)
        button.setImage(UIImage(named: "upButton"), for: .highlighted)
        button.imageView?.contentMode = .scaleAspectFit
        button.isUserInteractionEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let swipeUpLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "swipe up"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont(name: "Roboto-Regular", size: 13)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        view.addSubview(background)
        view.addSubview(swipeUpLabel)
        view.addSubview(upButton)
        view.addSubview(skipButton)
        
        configureConstraints()
        
        view.isUserInteractionEnabled = false
        let screenRatio = UIScreen.main.bounds.height/UIScreen.main.bounds.width
        self.background.image = (screenRatio < 2.0) ? UIImage(named: "Welcome3_4_3") : UIImage(named: "Welcome3_19_6")
    }
    
    private func configureConstraints() {
        self.background.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.background.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        self.background.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        self.background.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        let screenRatio = UIScreen.main.bounds.height/UIScreen.main.bounds.width
        let distanceToTop: CGFloat = (screenRatio < 2.0 && self.sizeClass() != (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) ? 20 : 30
        let textFontSize: CGFloat = (self.sizeClass() == (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) ? 40 : 20
        
        self.skipButton.topAnchor.constraint(equalTo: view.topAnchor, constant: distanceToTop).isActive = true
        self.skipButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -17).isActive = true
        self.skipButton.heightAnchor.constraint(equalToConstant: 19).isActive = true
        
        let distance: CGFloat = (screenRatio < 2.0 && self.sizeClass() != (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) ? -20 : -distanceToTop*1.2
        self.swipeUpLabel.heightAnchor.constraint(equalToConstant: textFontSize/1.3).isActive = true
        self.swipeUpLabel.font = UIFont(name: "Roboto-Regular", size: textFontSize/1.4)
        self.swipeUpLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.swipeUpLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: distance).isActive = true
        
        self.upButton.centerXAnchor.constraint(equalTo: swipeUpLabel.centerXAnchor).isActive = true
        self.upButton.bottomAnchor.constraint(equalTo: swipeUpLabel.topAnchor, constant: -2).isActive = true
        self.upButton.widthAnchor.constraint(equalToConstant: 27).isActive = true
        self.upButton.heightAnchor.constraint(equalToConstant: 11).isActive = true
    }
}

class WelcomeScreen4ViewController: UIViewController {
    // MARK: - Properties
    private let background: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let skipButton : UIButton = {
        let button = UIButton()
        let textAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont(name: "Roboto-Regular", size: 15), NSAttributedString.Key.foregroundColor: UIColor.white]
        let attributedString = NSMutableAttributedString(string: "Skip", attributes: textAttributes)
        button.setAttributedTitle(attributedString, for: .normal)
        let textPressedAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont(name: "Roboto-Regular", size: 15), NSAttributedString.Key.foregroundColor: UIColor.gray]
        let attributePresseddString = NSMutableAttributedString(string: "Skip", attributes: textPressedAttributes)
        button.setAttributedTitle(attributePresseddString, for: .highlighted)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let upButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "upButton"), for: .normal)
        button.setImage(UIImage(named: "upButton"), for: .highlighted)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = false
        return button
    }()
    
    private let swipeUpLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "swipe up"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont(name: "Roboto-Regular", size: 13)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        view.addSubview(background)
        view.addSubview(swipeUpLabel)
        view.addSubview(upButton)
        view.addSubview(skipButton)
        
        configureConstraints()
        
        view.isUserInteractionEnabled = false
        let screenRatio = UIScreen.main.bounds.height/UIScreen.main.bounds.width
        self.background.image = (screenRatio < 2.0) ? UIImage(named: "Welcome4_4_3") : UIImage(named: "Welcome4_19_6")
    }
    
    private func configureConstraints() {
        self.background.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.background.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        self.background.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        self.background.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        let screenRatio = UIScreen.main.bounds.height/UIScreen.main.bounds.width
        let distanceToTop: CGFloat = (screenRatio < 2.0 && self.sizeClass() != (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) ? 20 : 30
        let textFontSize: CGFloat = (self.sizeClass() == (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) ? 40 : 20
        
        self.skipButton.topAnchor.constraint(equalTo: view.topAnchor, constant: distanceToTop).isActive = true
        self.skipButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -17).isActive = true
        self.skipButton.heightAnchor.constraint(equalToConstant: 19).isActive = true
        
        let distance: CGFloat = (screenRatio < 2.0 && self.sizeClass() != (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) ? -20 : -distanceToTop*1.2
        self.swipeUpLabel.heightAnchor.constraint(equalToConstant: textFontSize/1.3).isActive = true
        self.swipeUpLabel.font = UIFont(name: "Roboto-Regular", size: textFontSize/1.4)
        self.swipeUpLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.swipeUpLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: distance).isActive = true
        
        self.upButton.centerXAnchor.constraint(equalTo: swipeUpLabel.centerXAnchor).isActive = true
        self.upButton.bottomAnchor.constraint(equalTo: swipeUpLabel.topAnchor, constant: -2).isActive = true
        self.upButton.widthAnchor.constraint(equalToConstant: 27).isActive = true
        self.upButton.heightAnchor.constraint(equalToConstant: 11).isActive = true
    }
}

class WelcomeScreen5ViewController: UIViewController {
    // MARK: - Properties
    private let background: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let upButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "upButton"), for: .normal)
        button.setImage(UIImage(named: "upButton"), for: .highlighted)
        button.imageView?.contentMode = .scaleAspectFit
        button.isUserInteractionEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let swipeUpLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "swipe up"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont(name: "Roboto-Regular", size: 13)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        view.addSubview(background)
        view.addSubview(swipeUpLabel)
        view.addSubview(upButton)
        
        configureConstraints()
        
        view.isUserInteractionEnabled = false
        let screenRatio = UIScreen.main.bounds.height/UIScreen.main.bounds.width
        self.background.image = (screenRatio < 2.0) ? UIImage(named: "Welcome5_4_3") : UIImage(named: "Welcome5_19_6")
    }
    
    private func configureConstraints() {
        self.background.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.background.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        self.background.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        self.background.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        let screenRatio = UIScreen.main.bounds.height/UIScreen.main.bounds.width
        let distanceToTop: CGFloat = (screenRatio < 2.0 && self.sizeClass() != (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) ? 20 : 30
        let textFontSize: CGFloat = (self.sizeClass() == (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) ? 40 : 20
        
        let distance: CGFloat = (screenRatio < 2.0 && self.sizeClass() != (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) ? -20 : -distanceToTop*1.2
        self.swipeUpLabel.heightAnchor.constraint(equalToConstant: textFontSize/1.3).isActive = true
        self.swipeUpLabel.font = UIFont(name: "Roboto-Regular", size: textFontSize/1.4)
        self.swipeUpLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.swipeUpLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: distance).isActive = true
        
        self.upButton.centerXAnchor.constraint(equalTo: swipeUpLabel.centerXAnchor).isActive = true
        self.upButton.bottomAnchor.constraint(equalTo: swipeUpLabel.topAnchor, constant: -2).isActive = true
        self.upButton.widthAnchor.constraint(equalToConstant: 27).isActive = true
        self.upButton.heightAnchor.constraint(equalToConstant: 11).isActive = true
    }
}

