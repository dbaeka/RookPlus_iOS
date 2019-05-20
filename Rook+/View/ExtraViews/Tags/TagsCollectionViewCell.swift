//
//  TagsView.swift
//  RookPlus
//
//  Created by Delmwin Baeka on 3/14/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//


import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    
    var selectedBackgroundColor: UIColor = UIColor(hexString: "FF5500") {
        didSet {
            tagView.backgroundColor = selectedBackgroundColor
        }
    }
    
    var normalTextColor: UIColor = UIColor.white {
        didSet {
            tagView.textColor = normalTextColor
        }
    }
    
    var normalBorderColor: UIColor = UIColor.white {
        didSet {
            tagView.layer.borderColor = normalBorderColor.cgColor
        }
    }
    
    var tagSelected: Bool = false {
        didSet {
            if tagSelected {
                tagView.backgroundColor = UIColor(hexString: "#FF5500")
                tagView.layer.borderWidth = 0.0
            } else {
                tagView.backgroundColor = UIColor.clear
                tagView.layer.borderWidth = 1.0
            }
        }
    }
    
    private var tagView: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tags"
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "Roboto-Medium", size: 15)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.layer.borderColor = UIColor.white.cgColor
        label.layer.borderWidth = 1.0
        label.clipsToBounds = true
        return label
    }()

    private func configureViews() {
        tagView.layer.cornerRadius = tagView.frame.size.height/2 - 2
       
        addSubview(tagView)
    }
    
    private func setupConstraints() {
        
        self.tagView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        self.tagView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        self.tagView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        self.tagView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureViews()
        self.setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tagView.layer.cornerRadius = tagView.frame.size.height/2 - 2
    }
    
    func configure(with text: String) {
        tagView.text = text
    }
}
