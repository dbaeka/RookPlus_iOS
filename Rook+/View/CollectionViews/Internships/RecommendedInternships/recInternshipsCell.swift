//
//  recInternshipsCell.swift
//  RookPlus
//
//  Created by Delmwin Baeka on 3/1/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

class recInternshipsCell: UICollectionViewCell {
    
    var title: String? {
        didSet{
            self.titleLabel.text = title
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
        button.setImage(UIImage(named: "apply.png"), for: .normal)
        let textAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont(name: "Roboto-Medium", size: 13), NSAttributedString.Key.foregroundColor: UIColor.white]
        let attributedString = NSMutableAttributedString(string: " Apply Now", attributes: textAttributes)
        button.setAttributedTitle(attributedString, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.backgroundColor = UIColor(hexString: "#004AEF")
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#FFFFFF")
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        label.font = UIFont(name: "Roboto-Regular", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let companyNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Regular", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.numberOfLines = 3
        label.font = UIFont(name: "Roboto-Medium", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func configureViews() {
        self.layer.backgroundColor = UIColor.clear.cgColor
        containerView.layer.borderColor = UIColor.black.cgColor
        containerView.layer.borderWidth = 0.1
        containerView.addSubview(titleLabel)
        containerView.addSubview(logoImageView)
        containerView.addSubview(locationLabel)
        containerView.addSubview(companyNameLabel)
        containerView.addSubview(applyButton)
        addSubview(containerView)
    }
    
    private func setupConstraints() {
        self.titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        self.titleLabel.leftAnchor.constraint(equalTo: logoImageView.rightAnchor, constant: 8).isActive = true
        self.titleLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
      //  self.titleLabel.heightAnchor.constraint(equalToConstant: 34).isActive = true
        
        self.logoImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        self.logoImageView.topAnchor.constraint(equalTo: titleLabel.topAnchor).isActive = true
        self.logoImageView.heightAnchor.constraint(equalToConstant: 23).isActive = true
        self.logoImageView.widthAnchor.constraint(equalToConstant: 23).isActive = true
        
        self.containerView.rightAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 8).isActive = true
        self.containerView.leftAnchor.constraint(equalTo: logoImageView.leftAnchor, constant: -8).isActive = true
        self.containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        self.containerView.heightAnchor.constraint(equalToConstant: self.frame.height-3).isActive = true
        
        self.locationLabel.leftAnchor.constraint(equalTo: self.titleLabel.leftAnchor).isActive = true
        self.locationLabel.rightAnchor.constraint(equalTo: self.titleLabel.rightAnchor, constant: -5).isActive = true
        self.locationLabel.topAnchor.constraint(equalTo: self.companyNameLabel.bottomAnchor, constant: 4).isActive = true
        self.locationLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
        
        self.companyNameLabel.leftAnchor.constraint(equalTo: self.titleLabel.leftAnchor).isActive = true
        self.companyNameLabel.rightAnchor.constraint(equalTo: self.titleLabel.rightAnchor, constant: -5).isActive = true
        self.companyNameLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 4).isActive = true
        self.companyNameLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
        
        self.applyButton.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        self.applyButton.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        self.applyButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        self.applyButton.heightAnchor.constraint(equalToConstant: 31).isActive = true
        
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
