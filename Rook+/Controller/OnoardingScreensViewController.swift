//
//  CVOnboardViewController.swift
//  Rook+
//
//  Created by Delmwin Baeka on 1/25/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

// MARK: - 1st Screen
class CVOnboardViewController: UIViewController {
    // MARK: - Properties
    var controllerColor: UIColor = UIColor(hexString: "#004AEF")
    var circleColor: UIColor = UIColor(hexString: "#043CBB")
    var pageNumber: Int = 0
    
    private let circleImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "CVOnboard.png")
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "With fully established CV, get recommended to companies for internships"
        label.numberOfLines = 2
        label.textAlignment = .left
        label.font = UIFont(name: "Roboto-Regular", size: 17)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        view.addSubview(circleImage)
        view.addSubview(textLabel)
        configureConstraints()
        
        view.isUserInteractionEnabled = false
    }
    
    private func configureConstraints() {
        let width = (self.sizeClass() == (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) ? UIScreen.main.bounds.width/2 : UIScreen.main.bounds.width
        let controlCircleOffset: CGFloat = UIScreen.main.bounds.height/18 + 20
        self.circleImage.topAnchor.constraint(equalTo: view.topAnchor, constant: UIScreen.main.bounds.height/38 + controlCircleOffset).isActive = true
        self.circleImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.circleImage.widthAnchor.constraint(equalToConstant: width*1.1).isActive = true
        self.circleImage.heightAnchor.constraint(equalToConstant: width*1.1).isActive = true
        self.circleImage.layer.cornerRadius = (1.1*width)/2
    
        let barRookOffset: CGFloat = UIScreen.main.bounds.height/38 + (width/3.3)/4.14814815
        let textOffset: CGFloat = width/3.3
        self.textLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: textOffset/3.6).isActive = true
        self.textLabel.rightAnchor.constraint(equalTo: view.rightAnchor , constant: -textOffset/3.6).isActive = true
        self.textLabel.topAnchor.constraint(equalTo: self.circleImage.bottomAnchor, constant: barRookOffset+(UIScreen.main.bounds.height/56)).isActive = true
        
        if (self.sizeClass() == (UIUserInterfaceSizeClass.regular,UIUserInterfaceSizeClass.regular)) {
            self.textLabel.font = UIFont(name: "Roboto-Regular", size: 24)
        }
    }
}

extension CVOnboardViewController: OnboardView {}

// MARK: - 2nd Screen
class ExperienceOnboardViewController: UIViewController {
    
    // MARK: - Properties
    var controllerColor: UIColor = UIColor(red: 0, green: 210/255, blue: 232/255, alpha: 1)
    var circleColor: UIColor = UIColor(red: 2/255, green: 189/255, blue: 198/255, alpha: 1)
    var pageNumber: Int = 1
    
    private let circleImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "XPOnboard.png")
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "Gain work experience virtually at your own time and comfort"
        label.numberOfLines = 2
        label.textAlignment = .left
        label.font = UIFont(name: "Roboto-Regular", size: 17)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        view.addSubview(circleImage)
        view.addSubview(textLabel)
        configureConstraints()
        
        view.isUserInteractionEnabled = false
    }
    
    private func configureConstraints() {
        let width = (self.sizeClass() == (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) ? UIScreen.main.bounds.width/2 : UIScreen.main.bounds.width
        let controlCircleOffset: CGFloat = UIScreen.main.bounds.height/18 + 20
        self.circleImage.topAnchor.constraint(equalTo: view.topAnchor, constant: UIScreen.main.bounds.height/38 + controlCircleOffset).isActive = true
        self.circleImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.circleImage.widthAnchor.constraint(equalToConstant: width*1.1).isActive = true
        self.circleImage.heightAnchor.constraint(equalToConstant: width*1.1).isActive = true
        self.circleImage.layer.cornerRadius = (1.1*width)/2
        
        let barRookOffset: CGFloat = UIScreen.main.bounds.height/38 + (width/3.3)/4.14814815
        let textOffset: CGFloat = width/3.3
        self.textLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: textOffset/3.6).isActive = true
        self.textLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -textOffset/3.6).isActive = true
        self.textLabel.topAnchor.constraint(equalTo: self.circleImage.bottomAnchor, constant: barRookOffset+(UIScreen.main.bounds.height/56)).isActive = true
        
        if (self.sizeClass() == (UIUserInterfaceSizeClass.regular,UIUserInterfaceSizeClass.regular)) {
            self.textLabel.font = UIFont(name: "Roboto-Regular", size: 24)
        }
    }
}

extension ExperienceOnboardViewController: OnboardView {}


// MARK: - 3rd Screen
class JobReadyOnboardViewController: UIViewController {
    
    // MARK: - Properties
    var controllerColor: UIColor = UIColor(red: 0, green: 210/255, blue: 232/255, alpha: 1)
    var circleColor: UIColor = UIColor(red: 2/255, green: 189/255, blue: 198/255, alpha: 1)
    var pageNumber: Int = 2
    
    private let circleImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "JobOnboard.png")
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "Become job ready by learning from experience"
        label.numberOfLines = 2
        label.textAlignment = .left
        label.font = UIFont(name: "Roboto-Regular", size: 17)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        view.addSubview(circleImage)
        view.addSubview(textLabel)
        configureConstraints()
        
        view.isUserInteractionEnabled = false
    }
    
    private func configureConstraints() {
        let width = (self.sizeClass() == (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) ? UIScreen.main.bounds.width/2 : UIScreen.main.bounds.width
        let controlCircleOffset: CGFloat = UIScreen.main.bounds.height/18 + 20
        self.circleImage.topAnchor.constraint(equalTo: view.topAnchor, constant: UIScreen.main.bounds.height/38 + controlCircleOffset).isActive = true
        self.circleImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.circleImage.widthAnchor.constraint(equalToConstant: width*1.1).isActive = true
        self.circleImage.heightAnchor.constraint(equalToConstant: width*1.1).isActive = true
        self.circleImage.layer.cornerRadius = (1.1*width)/2
        
        let barRookOffset: CGFloat = UIScreen.main.bounds.height/38 + (width/3.3)/4.14814815
        let textOffset: CGFloat = width/3.3
        self.textLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: textOffset/3.6).isActive = true
        self.textLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -textOffset/3.6).isActive = true
        self.textLabel.topAnchor.constraint(equalTo: self.circleImage.bottomAnchor, constant: barRookOffset+(UIScreen.main.bounds.height/56)).isActive = true
        
        if (self.sizeClass() == (UIUserInterfaceSizeClass.regular,UIUserInterfaceSizeClass.regular)) {
            self.textLabel.font = UIFont(name: "Roboto-Regular", size: 24)
        }
    }
}

extension JobReadyOnboardViewController: OnboardView {}

