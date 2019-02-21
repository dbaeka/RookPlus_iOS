//
//  VideosCell.swift
//  Rook+
//
//  Created by Delmwin Baeka on 2/14/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

class videosCell: UICollectionViewCell {
    
    var logo: UIImage? {
        didSet{
            guard let logo = logo else { return }
            self.headerImageView.image = logo
            self.headerImageView.backgroundColor = UIColor.clear
            self.logoSize?.height.constant = 15
            self.logoSize?.width.constant = (self.logoSize?.height.constant)!*(logo.size.width/logo.size.height)
            self.layoutIfNeeded()
        }
    }
    
    var title: String? {
        didSet {
            self.detailLabel.text = title
        }
    }
    
    var headerText: String? {
        didSet {
            self.headingLabel.text = headerText
        }
    }
    
    var views: Int = 0 {
        didSet {
            self.viewsLabel.text = "0"
            if views != 0 {
                if views < 1000 {
                    self.viewsLabel.text = String(views)
                } else if views < 1000000 {
                    self.viewsLabel.text = String(views/1000) + "k"
                } else if views < 1000000000 {
                    self.viewsLabel.text = String(views/1000000) + "m"
                }
            }
            self.viewsLabelWidth?.constant = self.viewsLabel.intrinsicContentSize.width
        }
    }
    
    var timepost: String? {
        didSet {
            guard let timepost = timepost else { return }
            self.timeLabel.text = timepost + " ago"
        }
    }
    
    var videoImage: UIImage? {
        didSet{
            guard let videoImage = videoImage else { return }
            self.videoImageView.image = videoImage
            self.videoImageView.backgroundColor = UIColor.clear
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
    
    private let videoImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = UIColor(red: 178.0/255.0, green: 178.0/255.0, blue: 178.0/255.0, alpha: 1.0)
        imageView.layer.cornerRadius = 4.0
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let viewsImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "viewed.png")
        imageView.contentMode = .scaleAspectFit
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
    
    private let playButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "play.png"), for: .normal)
        button.setImage(UIImage(named: "playPressed.png"), for: .highlighted)
        button.imageView?.contentMode = .scaleAspectFit
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let headingLabel: UILabel = {
        let label = UILabel()
        label.text = "• Business"
        label.textColor = UIColor(displayP3Red: 118/255, green: 118/255, blue: 118/255, alpha: 1.0)
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Regular", size: 13)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let detailLabel: UILabel = {
        let label = UILabel()
        label.text = "Developing a game plan for your company."
        label.textColor = UIColor.black
        label.numberOfLines = 2
        label.font = UIFont(name: "Roboto-Medium", size: 15)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let viewsLabel: UILabel = {
        let label = UILabel()
        label.text = "1k"
        label.textColor = UIColor(displayP3Red: 118/255, green: 118/255, blue: 118/255, alpha: 1.0)
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Regular", size: 11)
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
    
    private var logoSize: (width: NSLayoutConstraint,height: NSLayoutConstraint)?
    
    private var viewsLabelWidth: NSLayoutConstraint?
    
    private func configureViews() {
        self.layer.cornerRadius = 4.0
        self.layer.masksToBounds = true
        backgroundColor = .white
        
        addSubview(headerImageView)
        addSubview(detailLabel)
        addSubview(headingLabel)
        addSubview(timeLabel)
        addSubview(viewsImageView)
        addSubview(viewsLabel)
        addSubview(shareButton)
        addSubview(videoImageView)
        addSubview(playButton)
    }
    
    private func setupConstraints() {
        
        self.headerImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        self.headerImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        self.logoSize = (self.headerImageView.widthAnchor.constraint(equalToConstant: 42), self.headerImageView.heightAnchor.constraint(equalToConstant: 15))
        self.logoSize?.height.isActive = true
        self.logoSize?.width.isActive = true
        
        
        self.headingLabel.leftAnchor.constraint(equalTo: self.headerImageView.rightAnchor, constant: 5).isActive = true
        self.headingLabel.centerYAnchor.constraint(equalTo: headerImageView.centerYAnchor).isActive = true
        self.headingLabel.trailingAnchor.constraint(equalTo: self.videoImageView.leadingAnchor, constant: -10).isActive = true
        self.headingLabel.heightAnchor.constraint(equalToConstant: 13).isActive = true
        
        self.videoImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -5).isActive = true
        self.videoImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        self.videoImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        self.videoImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/3).isActive = true
        
        self.playButton.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/10).isActive = true
        self.playButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/10).isActive = true
        self.playButton.centerXAnchor.constraint(equalTo: self.videoImageView.centerXAnchor).isActive = true
        self.playButton.centerYAnchor.constraint(equalTo: self.videoImageView.centerYAnchor).isActive = true
        
        self.detailLabel.leadingAnchor.constraint(equalTo: headerImageView.leadingAnchor).isActive = true
        self.detailLabel.trailingAnchor.constraint(equalTo: self.videoImageView.leadingAnchor, constant: -10).isActive = true
        self.detailLabel.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: 5).isActive = true
        self.detailLabel.heightAnchor.constraint(equalToConstant: self.detailLabel.intrinsicContentSize.height)
        
        self.viewsImageView.trailingAnchor.constraint(equalTo: self.viewsLabel.leadingAnchor, constant: -5).isActive = true
        self.viewsImageView.centerYAnchor.constraint(equalTo: self.shareButton.centerYAnchor).isActive = true
        self.viewsImageView.widthAnchor.constraint(equalToConstant: 15).isActive = true
        self.viewsImageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        self.viewsLabel.rightAnchor.constraint(equalTo: self.shareButton.leftAnchor, constant: -20).isActive = true
        self.viewsLabel.centerYAnchor.constraint(equalTo: self.shareButton.centerYAnchor).isActive = true
        self.viewsLabelWidth = self.viewsLabel.widthAnchor.constraint(equalToConstant: self.viewsLabel.intrinsicContentSize.width)
        self.viewsLabelWidth?.isActive = true
        self.viewsLabel.heightAnchor.constraint(equalToConstant: self.viewsLabel.intrinsicContentSize.height).isActive = true
        
        self.shareButton.trailingAnchor.constraint(equalTo: self.videoImageView.leadingAnchor, constant: -10).isActive = true
        self.shareButton.centerYAnchor.constraint(equalTo: self.timeLabel.centerYAnchor).isActive = true
        self.shareButton.widthAnchor.constraint(equalToConstant: 15).isActive = true
        self.shareButton.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        self.timeLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        self.timeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        self.timeLabel.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
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
