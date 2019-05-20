//
//  PortfolioCell.swift
//  RookPlus
//
//  Created by Delmwin Baeka on 3/2/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

class PortfolioCell: UICollectionViewCell {
    
    var projectTitle: String? {
        didSet {
            self.projectTitleLabel.text = projectTitle
        }
    }
    
    var projectDescription: String? {
        didSet {
            self.descriptionLabel.text = projectDescription
        }
    }
    
    var duration: String? {
        didSet {
            self.durationLabel.text = duration
        }
    }
    
    var linkItem: (id: String, title: String, url: String)? = nil {
        didSet {
            guard let linkItem = linkItem else {
                self.linkHeight?.constant = 0
                return
            }
            self.linkLabel.setTitle(linkItem.title, for: .normal)
        }
    }
    
    private let projectTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Medium", size: 12)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "#5F5F5F")
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Medium", size: 11)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let durationLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Regular", size: 11)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let linkLabel: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.blue, for: .normal)
        button.backgroundColor = UIColor.lightGray
        button.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 11)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 0.8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var imagesView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        //      collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        collectionView.allowsSelection = true
        return collectionView
    }()
    
    
    private func configureViews() {
        backgroundColor = .white
        
        addSubview(projectTitleLabel)
        addSubview(descriptionLabel)
        addSubview(durationLabel)
        addSubview(linkLabel)
        addSubview(imagesView)
    }
    
    private var linkHeight: NSLayoutConstraint?
    
    private func setupConstraints() {
        self.projectTitleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        self.projectTitleLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 50).isActive = true
        self.projectTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        self.descriptionLabel.leftAnchor.constraint(equalTo: projectTitleLabel.leftAnchor).isActive = true
        self.projectTitleLabel.rightAnchor.constraint(equalTo: projectTitleLabel.rightAnchor).isActive = true
        self.descriptionLabel.topAnchor.constraint(equalTo: projectTitleLabel.bottomAnchor, constant: 1).isActive = true
        
        self.durationLabel.leftAnchor.constraint(equalTo: projectTitleLabel.leftAnchor).isActive = true
        self.durationLabel.rightAnchor.constraint(equalTo: projectTitleLabel.rightAnchor).isActive = true
        self.durationLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 1).isActive = true
        
        self.linkLabel.leftAnchor.constraint(equalTo: projectTitleLabel.leftAnchor).isActive = true
        self.linkHeight = self.linkLabel.heightAnchor.constraint(equalToConstant: 13)
        self.linkHeight?.isActive = true
        self.linkLabel.widthAnchor.constraint(equalToConstant: self.linkLabel.intrinsicContentSize.width + 15).isActive = true
        self.linkLabel.topAnchor.constraint(equalTo: durationLabel.bottomAnchor, constant: 4).isActive = true
        
//        self.exampleView.leftAnchor.constraint(equalTo: projectTitleLabel.leftAnchor).isActive = true
//        self.exampleView.rightAnchor.constraint(equalTo: projectTitleLabel.rightAnchor).isActive = true
//        self.exampleView.topAnchor.constraint(equalTo: durationLabel.bottomAnchor, constant: 1).isActive = true
//        self.exampleView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
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


extension PortfolioCell:  UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    
}
