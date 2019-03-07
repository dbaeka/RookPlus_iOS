//
//  AptitudeTestCell.swift
//  RookPlus
//
//  Created by Delmwin Baeka on 3/2/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

class AptitudeTestCell: UICollectionViewCell {
    
    var testsTaken: Int = 0 {
        didSet {
            self.testsTakenLabel.text = "0"
            if testsTaken != 0 {
                if testsTaken < 1000 {
                    self.testsTakenLabel.text = String(testsTaken)
                } else if testsTaken < 1000000 {
                    self.testsTakenLabel.text = String(testsTaken/1000) + "k"
                } else if testsTaken < 1000000000 {
                    self.testsTakenLabel.text = String(testsTaken/1000000) + "m"
                }
            }
        }
    }
    
    var highestScore: Int = 0 {
        didSet {
            self.highestScoreLabel.text = String(highestScore)
        }
    }
    
    var averageScore: Int = 0 {
        didSet {
            self.averageScoreLabel.text = String(averageScore)
        }
    }
    
    var percentile: Int = 0 {
        didSet {
            var cardinal = "th"
            if (percentile % 10 == 1) {
                cardinal = "st"
            } else if (percentile % 10 == 2) {
                cardinal = "nd"
            } else if (percentile % 10 == 3) {
                cardinal = "rd"
            }
            self.percentieLabel.text = String(percentile)+cardinal
        }
    }
    
    private let headerImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "Aptitude.png")
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let headingLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "Aptitude Test"
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Medium", size: 13)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let testsTakenTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "#5F5F5F")
        label.text = "Tests Taken"
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Medium", size: 11)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let highestScoeTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "#5F5F5F")
        label.text = "Highest Score"
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Medium", size: 11)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let averageScoreTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "#5F5F5F")
        label.text = "Average Score"
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Medium", size: 11)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let percentileTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "#5F5F5F")
        label.text = "Percentile"
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Medium", size: 11)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let testsTakenLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Medium", size: 23)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let highestScoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Medium", size: 23)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let averageScoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Medium", size: 23)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let percentieLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Medium", size: 23)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let takeTestButton : UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "buttonBorder.png"), for: .normal)
        let textAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont(name: "Roboto-Regular", size: 13), NSAttributedString.Key.foregroundColor: UIColor.black]
        let attributedString = NSMutableAttributedString(string: "Take Test", attributes: textAttributes)
        button.setAttributedTitle(attributedString, for: .normal)
        let textPressedAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont(name: "Roboto-Regular", size: 13), NSAttributedString.Key.foregroundColor: UIColor.gray]
        let attributePresseddString = NSMutableAttributedString(string: "Take Test", attributes: textPressedAttributes)
        button.setAttributedTitle(attributePresseddString, for: .highlighted)
        button.imageView?.contentMode = .scaleAspectFit
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private func configureViews() {
        backgroundColor = UIColor.white
        
        addSubview(headerImageView)
        addSubview(headingLabel)
        addSubview(testsTakenLabel)
        addSubview(testsTakenTitleLabel)
        addSubview(highestScoreLabel)
        addSubview(highestScoeTitleLabel)
        addSubview(averageScoreLabel)
        addSubview(averageScoreTitleLabel)
        addSubview(percentieLabel)
        addSubview(percentileTitleLabel)
        addSubview(takeTestButton)
    }
    
    private func setupConstraints() {
        widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 20).isActive = true
        self.layoutIfNeeded()
        layer.borderWidth = 0.2
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        self.headerImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        self.headerImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        self.headerImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        self.headerImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.headingLabel.leftAnchor.constraint(equalTo: headerImageView.rightAnchor, constant: 5).isActive = true
        self.headingLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
        self.headingLabel.centerYAnchor.constraint(equalTo: headerImageView.centerYAnchor).isActive = true
        self.headingLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
        self.testsTakenLabel.centerXAnchor.constraint(equalTo: testsTakenTitleLabel.centerXAnchor).isActive = true
        self.testsTakenLabel.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 15).isActive = true
        self.testsTakenLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        self.testsTakenTitleLabel.topAnchor.constraint(equalTo: testsTakenLabel.bottomAnchor, constant: 3).isActive = true
        self.testsTakenTitleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 25).isActive = true
        self.testsTakenTitleLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
        self.highestScoreLabel.centerYAnchor.constraint(equalTo: testsTakenLabel.centerYAnchor).isActive = true
        self.highestScoreLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        self.highestScoreLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        self.highestScoeTitleLabel.topAnchor.constraint(equalTo: highestScoreLabel.bottomAnchor, constant: 3).isActive = true
        self.highestScoeTitleLabel.centerXAnchor.constraint(equalTo: highestScoreLabel.centerXAnchor).isActive = true
        self.highestScoeTitleLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
        self.averageScoreLabel.centerXAnchor.constraint(equalTo: testsTakenLabel.centerXAnchor).isActive = true
        self.averageScoreLabel.topAnchor.constraint(equalTo: testsTakenTitleLabel.bottomAnchor, constant: 15).isActive = true
        self.averageScoreLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        self.averageScoreTitleLabel.topAnchor.constraint(equalTo: averageScoreLabel.bottomAnchor, constant: 3).isActive = true
        self.averageScoreTitleLabel.centerXAnchor.constraint(equalTo: averageScoreLabel.centerXAnchor).isActive = true
        self.averageScoreTitleLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
        self.percentieLabel.centerXAnchor.constraint(equalTo: highestScoreLabel.centerXAnchor).isActive = true
        self.percentieLabel.topAnchor.constraint(equalTo: highestScoeTitleLabel.bottomAnchor, constant: 15).isActive = true
        self.percentieLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        self.percentileTitleLabel.topAnchor.constraint(equalTo: percentieLabel.bottomAnchor, constant: 3).isActive = true
        self.percentileTitleLabel.centerXAnchor.constraint(equalTo: percentieLabel.centerXAnchor).isActive = true
        self.percentileTitleLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
        self.takeTestButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: frame.width/3).isActive = true
        self.takeTestButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        self.takeTestButton.heightAnchor.constraint(equalToConstant: 23).isActive = true
        self.takeTestButton.widthAnchor.constraint(equalToConstant: 72).isActive = true
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
