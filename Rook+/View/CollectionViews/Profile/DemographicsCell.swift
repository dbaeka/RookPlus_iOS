//
//  DemographicsCell.swift
//  RookPlus
//
//  Created by Delmwin Baeka on 3/2/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

class DemographicsCell: UICollectionViewCell {
    
    var gender: String?  {
        didSet {
            self.genderLabel.text = gender
        }
    }
    
    var age: String?  {
        didSet {
            self.ageLabel.text = age
        }
    }
    
    var nationality: String?  {
        didSet {
            self.nationalityLabel.text = nationality
        }
    }
    
    var employmentStatus: String?  {
        didSet {
            self.employmentLabel.text = employmentStatus
        }
    }
    
    var city: String?  {
        didSet {
            self.cityLabel.text = city
        }
    }
    
    var maritalStatus: String?  {
        didSet {
            self.maritalLabel.text = maritalStatus
        }
    }
    
    private let headerImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "Demographics.png")
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let headingLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "Demographics"
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Medium", size: 13)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let updateButton : UIButton = {
        let button = UIButton()
        let textAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont(name: "Roboto-Medium", size: 10), NSAttributedString.Key.foregroundColor: UIColor(hexString: "#5F5F5F")]
        let attributedString = NSMutableAttributedString(string: "update >", attributes: textAttributes)
        button.setAttributedTitle(attributedString, for: .normal)
        let textPressedAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont(name: "Roboto-Medium", size: 10), NSAttributedString.Key.foregroundColor: UIColor(hexString: "#B8B8B8")]
        let attributePresseddString = NSMutableAttributedString(string: "uodate >", attributes: textPressedAttributes)
        button.setAttributedTitle(attributePresseddString, for: .highlighted)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let genderLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont(name: "Roboto-Medium", size: 12)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let genderTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "#5F5F5F")
        label.text = "Gender"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont(name: "Roboto-Medium", size: 11)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ageLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont(name: "Roboto-Medium", size: 12)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ageTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "#5F5F5F")
        label.text = "Age"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont(name: "Roboto-Medium", size: 11)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nationalityLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont(name: "Roboto-Medium", size: 12)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nationalityTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "#5F5F5F")
        label.text = "Nationality"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont(name: "Roboto-Medium", size: 11)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont(name: "Roboto-Medium", size: 12)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cityTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "#5F5F5F")
        label.text = "City"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont(name: "Roboto-Medium", size: 11)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let employmentLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont(name: "Roboto-Medium", size: 12)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let employmentTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "#5F5F5F")
        label.text = "Employment Status"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont(name: "Roboto-Medium", size: 11)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let maritalLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont(name: "Roboto-Medium", size: 12)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let maritalTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "#5F5F5F")
        label.text = "Marital Status"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont(name: "Roboto-Medium", size: 11)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func configureViews() {
        backgroundColor = UIColor.white
        
        addSubview(headerImageView)
        addSubview(genderLabel)
        addSubview(headingLabel)
        addSubview(updateButton)
        addSubview(genderTitleLabel)
        addSubview(ageLabel)
        addSubview(ageTitleLabel)
        addSubview(nationalityLabel)
        addSubview(nationalityTitleLabel)
        addSubview(employmentLabel)
        addSubview(employmentTitleLabel)
        addSubview(cityLabel)
        addSubview(cityTitleLabel)
        addSubview(maritalLabel)
        addSubview(maritalTitleLabel)
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
        
        self.updateButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -13).isActive = true
        self.updateButton.centerYAnchor.constraint(equalTo: headingLabel.centerYAnchor).isActive = true
        self.updateButton.heightAnchor.constraint(equalToConstant: 11).isActive = true
        
        self.genderLabel.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 15).isActive = true
        self.genderLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 25).isActive = true
        self.genderLabel.heightAnchor.constraint(equalToConstant: 13).isActive = true
        
        self.genderTitleLabel.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 3).isActive = true
        self.genderTitleLabel.leftAnchor.constraint(equalTo: genderLabel.leftAnchor).isActive = true
        self.genderTitleLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
        self.ageLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        self.ageLabel.centerYAnchor.constraint(equalTo: genderLabel.centerYAnchor).isActive = true
        self.ageLabel.heightAnchor.constraint(equalToConstant: 13).isActive = true
        
        self.ageTitleLabel.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: 3).isActive = true
        self.ageTitleLabel.leftAnchor.constraint(equalTo: ageLabel.leftAnchor).isActive = true
        self.ageTitleLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
        self.nationalityTitleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -25).isActive = true
        self.nationalityTitleLabel.centerYAnchor.constraint(equalTo: genderTitleLabel.centerYAnchor).isActive = true
        self.nationalityTitleLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
        self.nationalityLabel.bottomAnchor.constraint(equalTo: nationalityTitleLabel.topAnchor, constant: -3).isActive = true
        self.nationalityLabel.leftAnchor.constraint(equalTo: nationalityTitleLabel.leftAnchor).isActive = true
        self.nationalityLabel.heightAnchor.constraint(equalToConstant: 13).isActive = true
        
        self.employmentLabel.leftAnchor.constraint(equalTo: genderLabel.leftAnchor).isActive = true
        self.employmentLabel.topAnchor.constraint(equalTo: genderTitleLabel.bottomAnchor, constant: 20).isActive = true
        self.employmentLabel.heightAnchor.constraint(equalToConstant: 13).isActive = true
        
        self.employmentTitleLabel.topAnchor.constraint(equalTo: employmentLabel.bottomAnchor, constant: 3).isActive = true
        self.employmentTitleLabel.leftAnchor.constraint(equalTo: employmentLabel.leftAnchor).isActive = true
        self.employmentTitleLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
        self.cityLabel.leftAnchor.constraint(equalTo: ageLabel.leftAnchor).isActive = true
        self.cityLabel.topAnchor.constraint(equalTo: ageTitleLabel.bottomAnchor, constant: 20).isActive = true
        self.cityLabel.heightAnchor.constraint(equalToConstant: 13).isActive = true
        
        self.cityTitleLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 3).isActive = true
        self.cityTitleLabel.leftAnchor.constraint(equalTo: cityLabel.leftAnchor).isActive = true
        self.cityTitleLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
        self.maritalLabel.leftAnchor.constraint(equalTo: nationalityLabel.leftAnchor).isActive = true
        self.maritalLabel.topAnchor.constraint(equalTo: nationalityTitleLabel.bottomAnchor, constant: 20).isActive = true
        self.maritalLabel.heightAnchor.constraint(equalToConstant: 13).isActive = true
        
        self.maritalTitleLabel.topAnchor.constraint(equalTo: maritalLabel.bottomAnchor, constant: 3).isActive = true
        self.maritalTitleLabel.leftAnchor.constraint(equalTo: maritalLabel.leftAnchor).isActive = true
        self.maritalTitleLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
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
