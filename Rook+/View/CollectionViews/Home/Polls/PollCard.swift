//
//  PollCard.swift
//  Rook+
//
//  Created by Delmwin Baeka on 2/14/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

class pollCard: UICollectionViewCell {
    
    var pollsItemStore: PollsItemStore!
    
    let headingLabel: UILabel = {
        let label = UILabel()
        label.text = "Trending Polls"
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
        let labelString = NSMutableAttributedString(string: "More polls", attributes: labelAttributes)
        button.setAttributedTitle(labelString, for: .normal)
        button.backgroundColor = UIColor(hexString: "#004AEF")
        button.isShadowOn = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let pollCardCellID = "pollCardCellID"
    
    lazy var pollCardCollectionView: UICollectionView = {
        let flowLayout     = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing  = 14
        flowLayout.minimumLineSpacing       = 14
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 0.0)
        collectionView.alwaysBounceVertical = false
        collectionView.alwaysBounceHorizontal = false
        collectionView.allowsSelection = true
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureCollectionView()
        self.pollsItemStore = PollsItemStore()
        addItem()
    }
    
    func addItem() {
        guard let url = Bundle.main.url(forResource: "Polls", withExtension: "json") else {
            return
        }
        guard let data = try? Data(contentsOf: url) else {
            return
        }
        let decoder = JSONDecoder()
        do {
            let response = try decoder.decode([PollsItem].self, from: data)
            for item in response {
                pollsItemStore.allItems.append(item)
            }
        } catch {
            print(error)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



private extension pollCard {
    
    private func configureCollectionView() {
        addSubview(headingLabel)
        addSubview(pollCardCollectionView)
        addSubview(moreButton)
        
        headingLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        headingLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        headingLabel.topAnchor.constraint(equalTo: topAnchor, constant: -10).isActive = true
        headingLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        moreButton.centerYAnchor.constraint(equalTo: headingLabel.centerYAnchor).isActive = true
        moreButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        moreButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        moreButton.widthAnchor.constraint(equalToConstant: (self.moreButton.titleLabel?.intrinsicContentSize.width)! + 20).isActive = true
        
        
        pollCardCollectionView.register(pollCardCell.self, forCellWithReuseIdentifier: pollCardCellID)
        pollCardCollectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        pollCardCollectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        pollCardCollectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        pollCardCollectionView.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 5).isActive = true
        pollCardCollectionView.heightAnchor.constraint(equalToConstant: pollCardCellHeight-5).isActive = true
        
        self.moreButton.layoutIfNeeded()
    }
}

extension pollCard: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pollsItemStore.allItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let pollCell: pollCardCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.pollCardCellID, for: indexPath) as! pollCardCell
        let item = pollsItemStore.allItems[indexPath.row]
        pollCell.fill = CGFloat(item.yes)/CGFloat(item.yes+item.no)
        pollCell.title = item.title
        pollCell.timePost = item.timepost
        pollCell.logo = UIImage(named: item.logo)
        return pollCell
        
    }
}

extension pollCard: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 179, height: 128)
    }
}

extension pollCard: UICollectionViewDelegate {
    
}
