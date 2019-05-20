//
//  Events.swift
//  Rook+
//
//  Created by Delmwin Baeka on 2/14/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

class events: UICollectionViewCell  {
    
    var eventsItemStore: EventsItemStore!
    
    let headingLabel: UILabel = {
        let label = UILabel()
        label.text = "Events"
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
        let labelString = NSMutableAttributedString(string: "More events", attributes: labelAttributes)
        button.setAttributedTitle(labelString, for: .normal)
        button.backgroundColor = UIColor(hexString: "#004AEF")
        button.isShadowOn = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let eventsCellID = "eventsCellID"
    
    lazy var eventsCollectionView: UICollectionView = {
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
        self.eventsItemStore = EventsItemStore()
        addItem()
    }
    
    func addItem() {
        guard let url = Bundle.main.url(forResource: "Events", withExtension: "json") else {
            return
        }
        guard let data = try? Data(contentsOf: url) else {
            return
        }
        let decoder = JSONDecoder()
        do {
            let response = try decoder.decode([EventsItem].self, from: data)
            for item in response {
                eventsItemStore.allItems.append(item)
            }
        } catch {
            print(error)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension events {
    
    private func configureCollectionView() {
        addSubview(headingLabel)
        addSubview(eventsCollectionView)
        addSubview(moreButton)
        
        headingLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        headingLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        headingLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        headingLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        moreButton.centerYAnchor.constraint(equalTo: headingLabel.centerYAnchor).isActive = true
        moreButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        moreButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        moreButton.widthAnchor.constraint(equalToConstant: (self.moreButton.titleLabel?.intrinsicContentSize.width)! + 20).isActive = true
        
        eventsCollectionView.register(eventsCell.self, forCellWithReuseIdentifier: eventsCellID)
        eventsCollectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        eventsCollectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        eventsCollectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        eventsCollectionView.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 10).isActive = true
        eventsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        self.moreButton.layoutIfNeeded()
    }
}

extension events: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let eventsCell: eventsCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.eventsCellID, for: indexPath) as! eventsCell
        let item = eventsItemStore.allItems[indexPath.row]
        eventsCell.price = item.price
        eventsCell.title = item.title
        eventsCell.footerText = item.companyName + " • " + item.timepost + " ago"
        eventsCell.date = item.date
        eventsCell.detail = item.detail
        eventsCell.location = item.location
        return eventsCell
        
    }
}


extension events: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 40, height: eventsCellHeight)
    }
}


extension events: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let item = eventsItemStore.allItems[indexPath.row]
        let eventsCell = cell as! eventsCell
        eventsCell.logo = UIImage(named: item.logo)
        eventsCell.featureImage = UIImage(named: item.featureImage)
    }
}
