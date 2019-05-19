//
//  ForYou.swift
//  Rook+
//
//  Created by Delmwin Baeka on 2/14/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

class forYou: UICollectionViewCell {
    
    var forYouItemStore: ForYouItemStore!
    
    let headingLabel: UILabel = {
        let label = UILabel()
        label.text = "For You"
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.font = UIFont(name: "Roboto-Medium", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let moreButton: RookRoundButton = {
        let button = RookRoundButton()
        guard let font = UIFont(name: "Roboto-Regular", size: 13) else {return RookRoundButton()}
        let labelAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.white]
        let labelString = NSMutableAttributedString(string: "More", attributes: labelAttributes)
        button.setAttributedTitle(labelString, for: .normal)
        button.backgroundColor = UIColor(hexString: "#004AEF")
        button.isShadowOn = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let forYouCellID = "forYouCellID"
    
    lazy var forYouCollectionView: UICollectionView = {
        let flowLayout     = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing  = 10
        flowLayout.minimumLineSpacing       = 15
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
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
        self.forYouItemStore = ForYouItemStore()
        addItem()
    }
    
    func addItem() {
        guard let url = Bundle.main.url(forResource: "ForYou", withExtension: "json") else {
            return
        }
        guard let data = try? Data(contentsOf: url) else {
            return
        }
        let decoder = JSONDecoder()
        do {
            let response = try decoder.decode([ForYouItem].self, from: data)
            for item in response {
                forYouItemStore.allItems.append(item)
            }
        } catch {
            print(error)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension forYou {
    
    private func configureCollectionView() {
        addSubview(headingLabel)
        addSubview(forYouCollectionView)
        addSubview(moreButton)
        
        headingLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        headingLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        headingLabel.topAnchor.constraint(equalTo: topAnchor, constant: -10).isActive = true
        headingLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        moreButton.centerYAnchor.constraint(equalTo: headingLabel.centerYAnchor).isActive = true
        moreButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        moreButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        moreButton.widthAnchor.constraint(equalToConstant: (self.moreButton.titleLabel?.intrinsicContentSize.width)! + 20).isActive = true
        
        forYouCollectionView.register(forYouCell.self, forCellWithReuseIdentifier: forYouCellID)
        forYouCollectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        forYouCollectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        forYouCollectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        forYouCollectionView.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 10).isActive = true
        forYouCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        self.moreButton.layoutIfNeeded()
    }
}

extension forYou: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let forYouCell: forYouCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.forYouCellID, for: indexPath) as! forYouCell
        let item = forYouItemStore.allItems[indexPath.row]
        forYouCell.views = item.views
        forYouCell.title = item.title
        forYouCell.headerText = "• " + item.category
        forYouCell.timepost = item.timepost
        return forYouCell
        
    }
}

extension forYou: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 40, height: forYouCellHeight)
    }
}

extension forYou: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let item = forYouItemStore.allItems[indexPath.row]
        let forYouCell = cell as! forYouCell
        forYouCell.logo = UIImage(named: item.logo)
    }
}
