//
//  Education.swift
//  RookPlus
//
//  Created by Delmwin Baeka on 3/2/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

class Education: UICollectionViewCell {
    
    var delegate: ResizableCollectionViewDelegate?
    
    private let headerImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "Education.png")
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let headingLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "Education"
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Medium", size: 13)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let updateButton : UIButton = {
        let button = UIButton()
        let textAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont(name: "Roboto-Medium", size: 10), NSAttributedString.Key.foregroundColor: UIColor(hexString: "#5F5F5F")]
        let attributedString = NSMutableAttributedString(string: "update >", attributes: textAttributes)
        button.setAttributedTitle(attributedString, for: .normal)
        let textPressedAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont(name: "Roboto-Medium", size: 10), NSAttributedString.Key.foregroundColor: UIColor(hexString: "#B8B8B8")]
        let attributePresseddString = NSMutableAttributedString(string: "uodate >", attributes: textPressedAttributes)
        button.setAttributedTitle(attributePresseddString, for: .highlighted)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let educationCellID = "educationCellID"
    
    lazy var educationCollectionView: UICollectionView = {
        let flowLayout     = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing  = 5
        flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        flowLayout.minimumLineSpacing       = 10
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.tag = 5
        collectionView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        collectionView.alwaysBounceVertical = false
        collectionView.alwaysBounceHorizontal = false
        collectionView.allowsSelection = true
        collectionView.isScrollEnabled = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureCollectionView()
        
        educationCollectionView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.old, context: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let observedObject = object as? UICollectionView, observedObject == self.educationCollectionView {
            let size = self.educationCollectionView.collectionViewLayout.collectionViewContentSize
            delegate?.resizeParent(with: CGSize(width: size.width, height: size.height+45), for: self.educationCollectionView)
        }
    }
}

private extension Education {
    
    private func configureCollectionView() {
        addSubview(headingLabel)
        addSubview(educationCollectionView)
        addSubview(headerImageView)
        addSubview(updateButton)
        
        widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 20).isActive = true
        self.layoutIfNeeded()
        layer.borderWidth = 0.2
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        self.headerImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        self.headerImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        self.headerImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        self.headerImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.headingLabel.leftAnchor.constraint(equalTo: headerImageView.rightAnchor, constant: 5).isActive = true
        self.headingLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
        self.headingLabel.centerYAnchor.constraint(equalTo: headerImageView.centerYAnchor).isActive = true
        self.headingLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
        self.updateButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -13).isActive = true
        self.updateButton.centerYAnchor.constraint(equalTo: headingLabel.centerYAnchor).isActive = true
        self.updateButton.heightAnchor.constraint(equalToConstant: 11).isActive = true
        
        educationCollectionView.register(EducationCell.self, forCellWithReuseIdentifier: educationCellID)
        educationCollectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        educationCollectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        educationCollectionView.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 15).isActive = true
        educationCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
    }
}

extension Education: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let educationCell: EducationCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.educationCellID, for: indexPath) as! EducationCell
        educationCell.schoolName = "University of Michigan"
        educationCell.course = "BSc. Electrical and Computer Engineering"
        educationCell.completionYear = 2020
        educationCell.gradeLevel = "Sophomore"
        return educationCell
        
    }
}

extension Education: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 20, height: 60)
    }
}

