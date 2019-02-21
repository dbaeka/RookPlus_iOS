//
//  NewsCell.swift
//  Rook+
//
//  Created by Delmwin Baeka on 2/14/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

class newsCell: UICollectionViewCell {
    
    var logo: UIImage? {
        didSet{
            guard let logo = logo else { return }
            self.headerImageView.image = logo
            self.headerImageView.backgroundColor = UIColor.clear
        }
    }
    
    var title: String? {
        didSet {
            self.detailLabel.text = title
        }
    }
    
    var companyName: String? {
        didSet {
            self.headingLabel.text = companyName
        }
    }
    
    var timepost: String? {
        didSet {
            guard let timepost = timepost else { return }
            self.timeLabel.text = timepost + " ago"
        }
    }
    
    var sourceImage: UIImage? {
        didSet{
            guard let sourceImage = sourceImage else { return }
            self.sourceImageView.image = sourceImage
            self.sourceImageView.backgroundColor = UIColor.clear
        }
    }
    
    private let headerImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor(red: 178.0/255.0, green: 178.0/255.0, blue: 178.0/255.0, alpha: 1.0)
        imageView.layer.cornerRadius = 4.0
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    
    private let sourceImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor(red: 178.0/255.0, green: 178.0/255.0, blue: 178.0/255.0, alpha: 1.0)
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    
    private let shareButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "share"), for: .normal)
        button.setImage(UIImage(named: "sharePressed.png"), for: .highlighted)
        button.imageView?.contentMode = .scaleAspectFit
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let headingLabel: UILabel = {
        let label = UILabel()
        label.text = "Vodafone Ghana"
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Medium", size: 15)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let detailLabel: UILabel = {
        let label = UILabel()
        label.text = "Drop a comment on what you feel about having a bundle that lasts for months instead of days"
        label.textColor = UIColor(displayP3Red: 118/255, green: 118/255, blue: 118/255, alpha: 1.0)
        label.numberOfLines = 2
        label.font = UIFont(name: "Roboto-Regular", size: 13)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "6h ago"
        label.textColor = UIColor(displayP3Red: 118/255, green: 118/255, blue: 118/255, alpha: 1.0)
        label.font = UIFont(name: "Roboto-Regular", size: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private func configureViews() {
        self.layer.cornerRadius = 4.0
        self.layer.masksToBounds = true
        backgroundColor = .white
        
        addSubview(headerImageView)
        addSubview(detailLabel)
        addSubview(headingLabel)
        addSubview(timeLabel)
        addSubview(shareButton)
        addSubview(sourceImageView)
    }
    
    private func setupConstraints() {
        
        self.headerImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        self.headerImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        self.headerImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        self.headerImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.headingLabel.leftAnchor.constraint(equalTo: self.headerImageView.rightAnchor, constant: 5).isActive = true
        self.headingLabel.centerYAnchor.constraint(equalTo: headerImageView.centerYAnchor).isActive = true
        self.headingLabel.rightAnchor.constraint(equalTo: sourceImageView.leftAnchor, constant: -10).isActive = true
        self.headingLabel.heightAnchor.constraint(equalToConstant: 13).isActive = true
        
        self.detailLabel.leadingAnchor.constraint(equalTo: headerImageView.leadingAnchor).isActive = true
        self.detailLabel.trailingAnchor.constraint(equalTo: self.shareButton.leadingAnchor, constant: -5).isActive = true
        self.detailLabel.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: 5).isActive = true
        self.detailLabel.heightAnchor.constraint(equalToConstant: self.detailLabel.intrinsicContentSize.height)
        
        self.sourceImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        self.sourceImageView.centerYAnchor.constraint(equalTo: self.headerImageView.centerYAnchor).isActive = true
        self.sourceImageView.heightAnchor.constraint(equalToConstant: 12).isActive = true
        self.sourceImageView.widthAnchor.constraint(equalToConstant: 12).isActive = true
        
        self.shareButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        self.shareButton.centerYAnchor.constraint(equalTo: self.timeLabel.centerYAnchor).isActive = true
        self.shareButton.widthAnchor.constraint(equalToConstant: 15).isActive = true
        self.shareButton.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        self.timeLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        self.timeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        self.timeLabel.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        self.timeLabel.heightAnchor.constraint(equalToConstant: timeLabel.intrinsicContentSize.height).isActive = true
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
