//
//  Companies.swift
//  RookPlus
//
//  Created by Delmwin Baeka on 2/27/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

class companiesCell: UICollectionViewCell {
    
    var title: String? {
        didSet {
            self.headingLabel.text = title
        }
    }
    
    var logo: UIImage? {
        didSet{
            guard let logo = logo else { return }
            self.headerImageView.image = logo
            self.headerImageView.backgroundColor = UIColor.clear
        }
    }
    
    var bio: String? {
        didSet {
            self.bioLabel.text = bio
        }
    }
    
    var subheading: String? {
        didSet {
            self.subheadingLabel.text = subheading
        }
    }
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 0.1
        view.layer.cornerRadius = 4.0
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private let headerImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = UIColor(red: 178.0/255.0, green: 178.0/255.0, blue: 178.0/255.0, alpha: 1.0)
        imageView.layer.cornerRadius = 14.0
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let dotsButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "moreDots.png"), for: .normal)
        button.setImage(UIImage(named: "moreDotsPressed.png"), for: .highlighted)
        button.imageView?.contentMode = .scaleAspectFit
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let headingLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.font = UIFont(name: "Roboto-Medium", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subheadingLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "#393939")
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Light", size: 10)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "#393939")
        label.numberOfLines = 3
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.85
        label.font = UIFont(name: "Roboto-Medium", size: 10.5)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private func configureViews() {
        backgroundColor = .white
        
        addSubview(backView)
        addSubview(headerImageView)
        addSubview(dotsButton)
        addSubview(subheadingLabel)
        addSubview(headingLabel)
        addSubview(bioLabel)
    }
    
    private func setupConstraints() {
        
        self.backView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        self.backView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        self.backView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        self.backView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        self.headerImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        self.headerImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        self.headerImageView.widthAnchor.constraint(equalToConstant: 124).isActive = true
        self.headerImageView.heightAnchor.constraint(equalToConstant: 124).isActive = true
        
        self.dotsButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        self.dotsButton.topAnchor.constraint(equalTo: backView.topAnchor, constant: 5).isActive = true
        self.dotsButton.widthAnchor.constraint(equalToConstant: 5).isActive = true
        self.dotsButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.headingLabel.leftAnchor.constraint(equalTo: self.headerImageView.rightAnchor, constant: 10).isActive = true
        self.headingLabel.topAnchor.constraint(equalTo: self.backView.topAnchor, constant: 5).isActive = true
        self.headingLabel.rightAnchor.constraint(equalTo: dotsButton.leftAnchor, constant: -20).isActive = true
        self.headingLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        self.subheadingLabel.leadingAnchor.constraint(equalTo: headingLabel.leadingAnchor).isActive = true
        self.subheadingLabel.trailingAnchor.constraint(equalTo: headingLabel.trailingAnchor).isActive = true
        self.subheadingLabel.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 5).isActive = true
        self.subheadingLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
        self.bioLabel.leftAnchor.constraint(equalTo: self.headingLabel.leftAnchor).isActive = true
        self.bioLabel.topAnchor.constraint(equalTo: self.subheadingLabel.bottomAnchor, constant: 10).isActive = true
        self.bioLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        self.bioLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
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
