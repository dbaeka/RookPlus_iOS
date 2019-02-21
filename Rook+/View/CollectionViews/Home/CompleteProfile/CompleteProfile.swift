//
//  CompleteProfile.swift
//  Rook+
//
//  Created by Delmwin Baeka on 2/14/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

class completeProfile: UICollectionViewCell , UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let completeProfileCellID = "completeProfileCellID"
    
    lazy var completeProfileCollectionView: UICollectionView = {
        let flowLayout     = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing  = 5
        flowLayout.minimumLineSpacing       = 15
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
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
    }
    
    private func configureCollectionView() {
        
        addSubview(completeProfileCollectionView)
        
        completeProfileCollectionView.register(completeProfileCell.self, forCellWithReuseIdentifier: completeProfileCellID)
        completeProfileCollectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        completeProfileCollectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        completeProfileCollectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        completeProfileCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension completeProfile {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let completeProfileCell: completeProfileCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.completeProfileCellID, for: indexPath) as! completeProfileCell
        return completeProfileCell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width-40, height: completeProfileCellHeight)
    }
}
