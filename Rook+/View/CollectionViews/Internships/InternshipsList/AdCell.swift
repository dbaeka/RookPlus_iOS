//
//  AdCell.swift
//  RookPlus
//
//  Created by Delmwin Baeka on 3/1/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

class adCell: UICollectionViewCell {
    
    var imageHeight: CGFloat = UIScreen.main.bounds.width/2.4-15 {
        didSet {
            self.imageHeightConstraint?.constant = imageHeight
            self.layoutIfNeeded()
        }
    }
    
    var featureImage: UIImage? {
        didSet{
            guard let featureImage = featureImage else { return }
            self.featureImageView.image = featureImage
            self.featureImageView.backgroundColor = UIColor.clear
        }
    }
 
    private let featureImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor.red
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private func configureViews() {
        self.layer.backgroundColor = UIColor.clear.cgColor
        addSubview(featureImageView)
    }
    
    private var imageHeightConstraint: NSLayoutConstraint?
    
    private func setupConstraints() {       
        let width = UIScreen.main.bounds.size.width - UIScreen.main.bounds.width/6
        self.featureImageView.widthAnchor.constraint(equalToConstant: width).isActive = true
        self.imageHeightConstraint = self.featureImageView.heightAnchor.constraint(equalToConstant:imageHeight)
        imageHeightConstraint?.isActive = true
        self.featureImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
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

