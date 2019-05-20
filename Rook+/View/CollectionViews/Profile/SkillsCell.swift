//
//  SkillsCell.swift
//  RookPlus
//
//  Created by Delmwin Baeka on 3/2/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

protocol UpdatableCollectionCardDelegate {
    func updateContent(using: UIViewController)
}

class SkillsCell: UICollectionViewCell {
    
    var delegate: ResizableCollectionViewDelegate?
    
    var navDelegate: UpdatableCollectionCardDelegate?
    
    var skills: [(id: String, title: String)]? = RookUser.shared.user.skills?.map({($0.id, $0.title)})
    
    private let headerImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "Skills.png")
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let headingLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "Skills"
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
    
    private lazy var SkillsCollectionView: UICollectionView = {
        let tagCellLayout = TagCellLayout(alignment: .center, delegate: self)
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: tagCellLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.tag = 7
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
  //      collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        collectionView.allowsSelection = true
        return collectionView
    }()
    
    private let tagsCollectionViewID = "tagsCollectionViewID"
    
    private var oneLineHeight: CGFloat {
        return 16
    }
    
    var longTagIndex: Int {
        return 1
    }

    
    private func configureViews() {
        backgroundColor = UIColor.white
        
        addSubview(headerImageView)
        addSubview(headingLabel)
        addSubview(SkillsCollectionView)
        addSubview(updateButton)
        self.updateButton.addTarget(self, action: #selector(updateContent(_:)), for: .touchUpInside)
    }
    
    private func setupConstraints() {
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
        
        SkillsCollectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: tagsCollectionViewID)
        SkillsCollectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        SkillsCollectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        SkillsCollectionView.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 15).isActive = true
        SkillsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30).isActive = true
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureViews()
        self.setupConstraints()
        
        SkillsCollectionView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.old, context: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let observedObject = object as? UICollectionView, observedObject == self.SkillsCollectionView {
            let size = self.SkillsCollectionView.collectionViewLayout.collectionViewContentSize
            delegate?.resizeParent(with: CGSize(width: size.width, height: size.height+45+40), for: self.SkillsCollectionView)
        }
    }
    
    @objc private func updateContent(_ sender: Any){
        let vc = TagEditViewController()
        navDelegate?.updateContent(using: vc)
    }
    
}

extension SkillsCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: - UICollectionView Delegate/Datasource Methods
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tagsCollectionViewID, for: indexPath) as! TagCollectionViewCell
        let item = skills?[indexPath.row]
        cell.configure(with: (item?.title)!)
        cell.normalBorderColor = UIColor.black
        cell.normalTextColor = UIColor.gray
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.skills?.count ?? 0
    }
}


extension SkillsCell: TagCellLayoutDelegate {
    func tagCellLayoutTagSize(layout: TagCellLayout, atIndex index: Int) -> CGSize {
        if (skills?[index].title.count ?? 0) <= 7 {
            let width: CGFloat = ((skills?[index].title.count ?? 0) < 3) ? 60 : 100
            return CGSize(width: width, height: oneLineHeight)
        } else {
            var s = textSize(text: skills?[index].title ?? "", font: UIFont(name: "Roboto-Medium", size: 17)!, collectionView: SkillsCollectionView)
            s.height += 8.0
            return s
        }
    }
    
    func textSize(text: String, font: UIFont, collectionView: UICollectionView) -> CGSize {
        var f = collectionView.bounds
        f.size.height = 9999.0
        let label = UILabel()
        label.numberOfLines = 0
        label.text = text
        label.font = font
        var s = label.sizeThatFits(f.size)
        s.height = max(oneLineHeight, s.height)
        return s
    }
    
}
