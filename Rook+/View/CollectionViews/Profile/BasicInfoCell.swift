//
//  BasicInfoCell.swift
//  RookPlus
//
//  Created by Delmwin Baeka on 3/2/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

class BasicInfoCell: UICollectionViewCell {
    
    var profilePic: UIImage? {
        didSet{
            guard let profilePic = profilePic else { return }
            self.headerImageView.image = profilePic
            self.headerImageView.backgroundColor = UIColor.clear
        }
    }
    
    var fullName: String? {
        didSet {
            self.fullNameLabel.text = fullName
        }
    }
    
    var completion: Double = 0 {
        didSet {
            self.completionView.percentFill = completion
            self.completionLabel.text =  String(completion*100) + "% complete"
        }
    }
    
    var points: Int = 0 {
        didSet {
            self.pointsLabel.text = String(points) + " pts"
            self.pointsLabel.text = "0 pts"
            if points != 0 {
                if points < 1000 {
                    self.pointsLabel.text = String(points) + " pts"
                } else if points < 1000000 {
                    self.pointsLabel.text = String(points/1000) + "k" + " pts"
                } else if points < 1000000000 {
                    self.pointsLabel.text = String(points/1000000) + "m" + " pts"
                }
            }
        }
    }
    
    var subscriptionLevel: String? {
        didSet {
            guard let subscriptionLevel = subscriptionLevel else {return}
            self.subscriptionLevelButton.setImage(UIImage(named: subscriptionLevel), for: .normal)
        }
    }
    
    private let headerImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = imageView.frame.width/2
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 1
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let subscriptionLevelButton : UIButton = {
        let button = UIButton()
        button.imageView?.contentMode = .scaleAspectFit
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let settingsButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Settings.png"), for: .normal)
        button.setImage(UIImage(named: "SettingsPressed.png"), for: .highlighted)
        button.imageView?.contentMode = .scaleAspectFit
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let completionView : RookProgressBar = {
        let view = RookProgressBar()
        view.gaugeColor = UIColor(hexString: "FF5500")
        view.tubeColor = UIColor.white
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let cvButton : RookRoundButton = {
        let button = RookRoundButton()
        guard let font = UIFont(name: "Roboto-Regular", size: 12) else {return RookRoundButton()}
        let labelAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor(hexString: "#004AEF")]
        let labelString = NSMutableAttributedString(string: "CV", attributes: labelAttributes)
        button.setAttributedTitle(labelString, for: .normal)
        button.backgroundColor = UIColor.white
        button.isShadowOn = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let pointsLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Medium", size: 11)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let completionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Medium", size: 11)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .right
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Medium", size: 15)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    private func configureViews() {
        backgroundColor = .clear
        addSubview(headerImageView)
        addSubview(subscriptionLevelButton)
        addSubview(settingsButton)
        addSubview(completionView)
        addSubview(cvButton)
        addSubview(pointsLabel)
        addSubview(fullNameLabel)
        addSubview(completionLabel)
    }
    
    private func setupConstraints() {
        self.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        self.layoutIfNeeded()
        
        self.headerImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        self.headerImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        self.headerImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        self.headerImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.headerImageView.layoutIfNeeded()
        self.headerImageView.layer.cornerRadius = self.headerImageView.frame.width/2
        
        self.fullNameLabel.leftAnchor.constraint(equalTo: headerImageView.rightAnchor, constant: 10).isActive = true
        self.fullNameLabel.topAnchor.constraint(equalTo: headerImageView.topAnchor).isActive = true
        self.fullNameLabel.rightAnchor.constraint(equalTo: settingsButton.leftAnchor, constant: 20).isActive = true
        
        self.subscriptionLevelButton.rightAnchor.constraint(equalTo: headerImageView.rightAnchor, constant: 5).isActive = true
        self.subscriptionLevelButton.widthAnchor.constraint(equalToConstant: 18).isActive = true
        self.subscriptionLevelButton.bottomAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: 3).isActive = true
        self.subscriptionLevelButton.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        
        self.settingsButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -17).isActive = true
        self.settingsButton.centerYAnchor.constraint(equalTo: self.fullNameLabel.centerYAnchor).isActive = true
        self.settingsButton.widthAnchor.constraint(equalToConstant: 23).isActive = true
        self.settingsButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.cvButton.leftAnchor.constraint(equalTo: fullNameLabel.leftAnchor).isActive = true
        self.cvButton.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 5).isActive = true
        self.cvButton.widthAnchor.constraint(equalToConstant: 56).isActive = true
        self.cvButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.pointsLabel.centerYAnchor.constraint(equalTo: cvButton.centerYAnchor).isActive = true
        self.pointsLabel.leftAnchor.constraint(equalTo: cvButton.rightAnchor, constant: 10).isActive = true
        
        self.completionView.topAnchor.constraint(equalTo: completionLabel.bottomAnchor, constant: 5).isActive = true
        self.completionView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 70).isActive = true
        self.completionView.heightAnchor.constraint(equalToConstant: 8).isActive = true
        self.completionView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        self.completionLabel.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: 10).isActive = true
        self.completionLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 70).isActive = true
        self.completionLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
        self.completionLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
      
        
        self.cvButton.layoutIfNeeded()
      
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureViews()
        self.setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

