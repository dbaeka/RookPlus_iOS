//
//  SkillsCell.swift
//  RookPlus
//
//  Created by Delmwin Baeka on 3/2/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

class SkillsCell: UICollectionViewCell {
    
    var skills: [String]?  {
        didSet {
        }
    }
    
    private let headerImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "Skills.png")
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let headingLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "Skills"
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
    
    
    private func configureViews() {
        backgroundColor = UIColor.white
        
        addSubview(headerImageView)
        addSubview(headingLabel)
        addSubview(updateButton)
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
