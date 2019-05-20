//
//  EventsCell.swift
//  Rook+
//
//  Created by Delmwin Baeka on 2/14/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

class eventsCell: UICollectionViewCell {
    
    var title: String? {
        didSet {
            self.headingLabel.text = title
        }
    }
    
    var logo: UIImage? {
        didSet{
            guard let logo = logo else { return }
            self.logoImageView.image = logo
            self.logoImageView.backgroundColor = UIColor.clear
        }
    }
    
    var featureImage: UIImage? {
        didSet{
            guard let featureImage = featureImage else { return }
            self.headerImageView.image = featureImage
            self.headerImageView.backgroundColor = UIColor.clear
        }
    }
    
    var price: Int = 0 {
        didSet {
            self.priceLabel.text = "Free"
            if price != 0 {
                self.priceLabel.text = "GHc" + String(price)
            }
            self.priceLabelWidth?.constant = self.priceLabel.intrinsicContentSize.width
        }
    }
    
    var footerText: String? {
        didSet {
            self.footerLabel.text = footerText
        }
    }
    
    var location: String? {
        didSet {
            self.locationLabel.text = location
        }
    }
    
    var date: String? {
        didSet {
            self.dateLabel.text = date
        }
    }
    
    var detail: String? {
        didSet {
            self.detailLabel.text = detail
        }
    }
    
    
    private let headerImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = UIColor(red: 178.0/255.0, green: 178.0/255.0, blue: 178.0/255.0, alpha: 1.0)
        imageView.layer.cornerRadius = 4.0
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
    
    private let calendarImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "date.png")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let locationImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "location.png")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    
    private let logoImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor(red: 178.0/255.0, green: 178.0/255.0, blue: 178.0/255.0, alpha: 1.0)
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let headingLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.font = UIFont(name: "Roboto-Medium", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let detailLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(displayP3Red: 118/255, green: 118/255, blue: 118/255, alpha: 1.0)
        label.numberOfLines = 2
        label.font = UIFont(name: "Roboto-Regular", size: 12)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let footerLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(displayP3Red: 118/255, green: 118/255, blue: 118/255, alpha: 1.0)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.font = UIFont(name: "Roboto-Regular", size: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Regular", size: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.85
        label.font = UIFont(name: "Roboto-Regular", size: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(displayP3Red: 0, green: 34/255, blue: 138/255, alpha: 1.0)
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Bold", size: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var priceLabelWidth: NSLayoutConstraint?
    
    private func configureViews() {
        backgroundColor = .white
        
        addSubview(headerImageView)
        addSubview(dotsButton)
        addSubview(detailLabel)
        addSubview(headingLabel)
        addSubview(calendarImageView)
        addSubview(dateLabel)
        addSubview(locationImageView)
        addSubview(locationLabel)
        addSubview(logoImageView)
        addSubview(priceLabel)
        addSubview(footerLabel)
    }
    
    private func setupConstraints() {
        
        self.headerImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        self.headerImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        self.headerImageView.widthAnchor.constraint(equalToConstant: 116).isActive = true
        self.headerImageView.heightAnchor.constraint(equalToConstant: 116).isActive = true
        
        self.dotsButton.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        self.dotsButton.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        self.dotsButton.widthAnchor.constraint(equalToConstant: 5).isActive = true
        self.dotsButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.headingLabel.leftAnchor.constraint(equalTo: self.headerImageView.rightAnchor, constant: 20).isActive = true
        self.headingLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        self.headingLabel.rightAnchor.constraint(equalTo: dotsButton.leftAnchor, constant: -20).isActive = true
        self.headingLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        self.detailLabel.leadingAnchor.constraint(equalTo: headingLabel.leadingAnchor).isActive = true
        self.detailLabel.trailingAnchor.constraint(equalTo: headingLabel.trailingAnchor).isActive = true
        self.detailLabel.topAnchor.constraint(equalTo: headingLabel.bottomAnchor).isActive = true
        self.detailLabel.heightAnchor.constraint(equalToConstant: self.detailLabel.intrinsicContentSize.height)
        
        self.calendarImageView.leadingAnchor.constraint(equalTo: self.headingLabel.leadingAnchor).isActive = true
        self.calendarImageView.topAnchor.constraint(equalTo: self.detailLabel.bottomAnchor, constant: 5).isActive = true
        self.calendarImageView.widthAnchor.constraint(equalToConstant: 15).isActive = true
        self.calendarImageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        self.dateLabel.leftAnchor.constraint(equalTo: self.calendarImageView.rightAnchor, constant: 5).isActive = true
        self.dateLabel.centerYAnchor.constraint(equalTo: self.calendarImageView.centerYAnchor).isActive = true
        self.dateLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        self.dateLabel.heightAnchor.constraint(equalToConstant: 11).isActive = true
        
        self.locationImageView.leadingAnchor.constraint(equalTo: self.headingLabel.leadingAnchor).isActive = true
        self.locationImageView.topAnchor.constraint(equalTo: self.calendarImageView.bottomAnchor, constant: 5).isActive = true
        self.locationImageView.widthAnchor.constraint(equalToConstant: 13).isActive = true
        self.locationImageView.heightAnchor.constraint(equalToConstant: 13).isActive = true
        
        self.logoImageView.leadingAnchor.constraint(equalTo: self.headingLabel.leadingAnchor).isActive = true
        self.logoImageView.topAnchor.constraint(equalTo: self.locationImageView.bottomAnchor, constant: 5).isActive = true
        self.logoImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        self.logoImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.locationLabel.leftAnchor.constraint(equalTo: self.locationImageView.rightAnchor, constant: 5).isActive = true
        self.locationLabel.centerYAnchor.constraint(equalTo: self.locationImageView.centerYAnchor).isActive = true
        self.locationLabel.rightAnchor.constraint(equalTo: self.priceLabel.leftAnchor, constant: -10).isActive = true
        self.locationLabel.heightAnchor.constraint(equalToConstant: 11).isActive = true
        
        self.priceLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        self.priceLabel.centerYAnchor.constraint(equalTo: self.locationImageView.centerYAnchor).isActive = true
        self.priceLabelWidth = self.priceLabel.widthAnchor.constraint(equalToConstant: self.priceLabel.intrinsicContentSize.width)
        self.priceLabelWidth?.isActive = true
        self.priceLabel.heightAnchor.constraint(equalToConstant: 13).isActive = true
        
        self.footerLabel.leftAnchor.constraint(equalTo: self.logoImageView.rightAnchor, constant: 5).isActive = true
        self.footerLabel.centerYAnchor.constraint(equalTo: self.logoImageView.centerYAnchor).isActive = true
        self.footerLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        self.footerLabel.heightAnchor.constraint(equalToConstant: 11).isActive = true
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

