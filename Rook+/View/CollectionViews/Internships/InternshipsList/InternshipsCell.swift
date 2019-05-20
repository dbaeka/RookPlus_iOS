//
//  InternshipsCell.swift
//  RookPlus
//
//  Created by Delmwin Baeka on 3/1/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

class internshipsCell: UICollectionViewCell {
    
    var title: String? {
        didSet{
            self.titleLabel.text = title
        }
    }
    
    var deadline: String? {
        didSet{
            self.deadlineLabel.text = deadline
        }
    }
    
    var type: String? {
        didSet{
            self.typeLabel.text = type
        }
    }

    var deadlineColor: UIColor? {
        didSet {
            self.deadlineLabel.textColor = deadlineColor
        }
    }

    var locaiton: String? {
        didSet{
            self.locationLabel.text = locaiton
        }
    }
    
    var companyName: String? {
        didSet{
            self.companyNameLabel.text = companyName
        }
    }
    
    var logo: UIImage? {
        didSet{
            guard let logo = logo else { return }
            self.logoImageView.image = logo
            self.logoImageView.backgroundColor = UIColor.clear
        }
    }
    
    private let applyButton : UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "buttonBorder.png"), for: .normal)
        let textAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont(name: "Roboto-Medium", size: 11), NSAttributedString.Key.foregroundColor: UIColor.black]
        let attributedString = NSMutableAttributedString(string: "Apply", attributes: textAttributes)
        button.setAttributedTitle(attributedString, for: .normal)
        let textPressedAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont(name: "Roboto-Medium", size: 11), NSAttributedString.Key.foregroundColor: UIColor.gray]
        let attributePresseddString = NSMutableAttributedString(string: "Apply", attributes: textPressedAttributes)
        button.setAttributedTitle(attributePresseddString, for: .highlighted)
        button.imageView?.contentMode = .scaleAspectFit
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let logoImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor(red: 178.0/255.0, green: 178.0/255.0, blue: 178.0/255.0, alpha: 1.0)
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "#707070")
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Regular", size: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-BoldCondensed", size: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let companyNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Regular", size: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let deadlineLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Light", size: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "#004AEF")
        label.numberOfLines = 3
        label.font = UIFont(name: "Roboto-Medium", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#FFFFFF")
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func configureViews() {
        self.layer.backgroundColor = UIColor.clear.cgColor
        containerView.addSubview(titleLabel)
        containerView.addSubview(logoImageView)
        containerView.addSubview(locationLabel)
        containerView.addSubview(companyNameLabel)
        containerView.addSubview(applyButton)
        containerView.addSubview(deadlineLabel)
        containerView.addSubview(typeLabel)
        addSubview(containerView)
    }
    
    private func setupConstraints() {
        self.titleLabel.topAnchor.constraint(equalTo: logoImageView.topAnchor).isActive = true
        self.titleLabel.leftAnchor.constraint(equalTo: logoImageView.rightAnchor, constant: 8).isActive = true
        self.titleLabel.rightAnchor.constraint(equalTo: applyButton.leftAnchor, constant: -10).isActive = true
        self.titleLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width-144).isActive = true
        
        self.logoImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        self.logoImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5).isActive = true
        self.logoImageView.heightAnchor.constraint(equalToConstant: 23).isActive = true
        self.logoImageView.widthAnchor.constraint(equalToConstant: 23).isActive = true
        
        self.locationLabel.leftAnchor.constraint(equalTo: self.titleLabel.leftAnchor).isActive = true
        self.locationLabel.rightAnchor.constraint(equalTo: self.typeLabel.rightAnchor, constant: -5).isActive = true
        self.locationLabel.topAnchor.constraint(equalTo: self.companyNameLabel.bottomAnchor, constant: 4).isActive = true
        
        self.typeLabel.centerYAnchor.constraint(equalTo: self.locationLabel.centerYAnchor).isActive = true
        self.typeLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        self.typeLabel.widthAnchor.constraint(equalToConstant: 26).isActive = true
        self.typeLabel.heightAnchor.constraint(equalToConstant: 13).isActive = true
        
        self.companyNameLabel.leftAnchor.constraint(equalTo: self.titleLabel.leftAnchor).isActive = true
        self.companyNameLabel.rightAnchor.constraint(equalTo: self.titleLabel.rightAnchor).isActive = true
        self.companyNameLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 4).isActive = true
        
        self.deadlineLabel.leftAnchor.constraint(equalTo: self.titleLabel.leftAnchor).isActive = true
        self.deadlineLabel.rightAnchor.constraint(equalTo: self.titleLabel.rightAnchor).isActive = true
        self.deadlineLabel.topAnchor.constraint(equalTo: self.locationLabel.bottomAnchor, constant: 4).isActive = true
        
        self.applyButton.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        self.applyButton.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor).isActive = true
        self.applyButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.containerView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width-40).isActive = true
        self.containerView.heightAnchor.constraint(equalToConstant: 95).isActive = true
        self.containerView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
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
