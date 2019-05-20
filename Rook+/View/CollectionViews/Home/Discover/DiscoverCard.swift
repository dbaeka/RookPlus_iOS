//
//  DiscoverCard.swift
//  Rook+
//
//  Created by Delmwin Baeka on 2/14/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

class discoverCard: UICollectionViewCell {
    
    //MARK:- Properties
    private let discoverCardCellID = "discoverCardCellID"
    
    var discoverItemStore: DiscoverItemStore!
    
    lazy var discoverCardCollectionView: UICollectionView = {
        var flowLayout     = UICollectionViewFlowLayout()
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
    
        RookCollectionViewConfiguration.shared().setCollectionViewConfig(for: &collectionView, and: &flowLayout, with: .discover)
        return collectionView
    }()
    //MARK:- Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureCollectionView()
        self.discoverItemStore = DiscoverItemStore()
        addItem()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    func addItem() {
        guard let url = Bundle.main.url(forResource: "Discover", withExtension: "json") else {
            return
        }
        guard let data = try? Data(contentsOf: url) else {
            return
        }
        let decoder = JSONDecoder()
        do {
            let response = try decoder.decode([DiscoverItem].self, from: data)
            for item in response {
                discoverItemStore.allItems.append(item)
            }
        } catch {
            print(error)
        }
    }
}

private extension discoverCard {
    
    //MARK:- Setup Helper Functions
    private func configureCollectionView() {
        
        addSubview(discoverCardCollectionView)
        
        discoverCardCollectionView.register(discoverCardCell.self, forCellWithReuseIdentifier: discoverCardCellID)
        discoverCardCollectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        discoverCardCollectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        discoverCardCollectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        discoverCardCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

extension discoverCard: UICollectionViewDataSource {
    
    //MARK:- UICollectionViewDataSource Protocol Functions
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return discoverItemStore.allItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let discoverCardCell: discoverCardCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.discoverCardCellID, for: indexPath) as! discoverCardCell
        return discoverCardCell
        
    }
}


extension discoverCard: UICollectionViewDelegateFlowLayout {
    
    //MARK:- UICollectionViewDelegateFlowLayout Protocol Functions
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 268, height: 220)
    }
}

extension discoverCard: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let item = discoverItemStore.allItems[indexPath.row]
        let discoverCardCell = cell as! discoverCardCell
        discoverCardCell.image = UIImage(named: item.image)
    }
}
