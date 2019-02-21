//
//  DiscoverCardCell.swift
//  Rook+
//
//  Created by Delmwin Baeka on 2/14/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

class discoverCardCell: UICollectionViewCell {
    
    var image: UIImage? {
        didSet{
            guard let image = image else { return }
            self.imageImageView.image = image
        }
    }
    
    private let imageImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let containerView = UIView()
    
    var cardSize: CGFloat {
        return UIScreen.main.bounds.width/1.6
    }
    
    func configureViews() {
        self.layer.backgroundColor = UIColor.clear.cgColor
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 7
        setup()
        addSubview(containerView)
        containerView.addSubview(imageImageView)
    }
    
    private func setup() {
        containerView.backgroundColor = UIColor.blue
        containerView.layer.cornerRadius = cardSize/25
        containerView.layer.masksToBounds = true
        containerView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        self.containerView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        self.containerView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        self.containerView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        self.containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        self.imageImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        self.imageImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        self.imageImageView.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        self.imageImageView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
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
