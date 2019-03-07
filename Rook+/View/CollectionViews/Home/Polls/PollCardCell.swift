//
//  PollCardCell.swift
//  Rook+
//
//  Created by Delmwin Baeka on 2/14/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

class pollCardCell: UICollectionViewCell {
    
    var title: String? {
        didSet{
            self.textLabel.text = title
        }
    }
    
    var timePost: String? {
        didSet{
            guard let timePost = timePost else { return }
            self.timeLabel.text = timePost + " ago"
        }
    }
    
    var fill: CGFloat = 0.5 {
        didSet{
            self.barView.fill = fill
        }
    }
    
    var logo: UIImage? {
        didSet{
            guard let logo = logo else { return }
            self.logoImageView.image = logo
            self.logoImageView.backgroundColor = UIColor.clear
            if logo.size.width/logo.size.height != 1.0 {
                self.logoSize?.height.constant = 12
                self.logoSize?.width.constant = (self.logoSize?.height.constant)!*(logo.size.width/logo.size.height)
                self.layoutIfNeeded()
            }
            
        }
    }
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#FFFFFF")
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let barView: RookPollBar = {
        let view = RookPollBar()
        let random = arc4random()
        switch random % 2 {
        case 1:
            view.topColor = UIColor(hexString: "#FF6D00")
            view.bottomColor = UIColor(hexString: "#D60000")
        default:
            view.topColor = UIColor(hexString: "#00C107")
            view.bottomColor = UIColor(hexString: "#0294DA")
        }
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
    
    private let yesLabel: UILabel = {
        let label = UILabel()
        label.text = "Yes"
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Regular", size: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let noLabel: UILabel = {
        let label = UILabel()
        label.text = "No"
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Regular", size: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "#262626")
        label.numberOfLines = 4
        label.font = UIFont(name: "Roboto-Medium", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "#545454")
        label.font = UIFont(name: "Roboto-Regular", size: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var logoSize: (width: NSLayoutConstraint,height: NSLayoutConstraint)?
    
    private func configureViews() {
        self.layer.backgroundColor = UIColor.clear.cgColor
        containerView.layer.borderColor = UIColor.black.cgColor
        containerView.layer.borderWidth = 0.1
        containerView.addSubview(textLabel)
        containerView.addSubview(logoImageView)
        containerView.addSubview(barView)
        containerView.addSubview(timeLabel)
        containerView.addSubview(yesLabel)
        containerView.addSubview(noLabel)
        addSubview(containerView)
    }
    
    private func setupConstraints() {
        self.textLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8).isActive = true
        self.textLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8).isActive = true
        self.textLabel.widthAnchor.constraint(equalToConstant: self.frame.width/2).isActive = true
        self.textLabel.bottomAnchor.constraint(equalTo: self.logoImageView.topAnchor, constant: -15).isActive = true
        
        self.logoImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8).isActive = true
        self.logoImageView.leftAnchor.constraint(equalTo: self.textLabel.leftAnchor).isActive = true
        self.logoSize = (self.logoImageView.widthAnchor.constraint(equalToConstant: 17), self.logoImageView.heightAnchor.constraint(equalToConstant: 17))
        self.logoSize?.height.isActive = true
        self.logoSize?.width.isActive = true
        
        self.barView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -8).isActive = true
        self.barView.topAnchor.constraint(equalTo: self.yesLabel.bottomAnchor, constant: 3).isActive = true
        self.barView.bottomAnchor.constraint(equalTo: self.noLabel.topAnchor, constant: -3).isActive = true
        self.barView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.timeLabel.centerYAnchor.constraint(equalTo: logoImageView.centerYAnchor).isActive = true
        self.timeLabel.leftAnchor.constraint(equalTo: self.logoImageView.rightAnchor, constant: 5).isActive = true
                
        self.containerView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        self.containerView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        self.containerView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        self.containerView.heightAnchor.constraint(equalToConstant: self.frame.height-3).isActive = true
        
        self.noLabel.centerXAnchor.constraint(equalTo: self.barView.centerXAnchor).isActive = true
        self.noLabel.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -5).isActive = true
        self.noLabel.heightAnchor.constraint(equalToConstant: self.noLabel.intrinsicContentSize.height).isActive = true
        
        self.yesLabel.centerXAnchor.constraint(equalTo: self.barView.centerXAnchor).isActive = true
        self.yesLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 5).isActive = true
        self.yesLabel.heightAnchor.constraint(equalToConstant: self.yesLabel.intrinsicContentSize.height).isActive = true
        
        self.barView.layoutIfNeeded()
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
