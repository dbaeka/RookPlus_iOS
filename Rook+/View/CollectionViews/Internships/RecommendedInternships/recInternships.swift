//
//  recInternships.swift
//  RookPlus
//
//  Created by Delmwin Baeka on 3/1/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

class recInternships: UICollectionViewCell {
    
    //MARK:- Properties
    private let recIntersnhipCellID = "recIntersnhipCellID"
    
    let headingLabel: UILabel = {
        let label = UILabel()
        label.text = "Recommended for You"
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
    
    var recInternshipItemStore: RecInternshipItemStore!
    
    lazy var recInternshipCardCollectionView: UICollectionView = {
        let flowLayout     = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing  = 14
        flowLayout.minimumLineSpacing       = 14
        flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 0.0, left: 40.0, bottom: 0.0, right: 0.0)
        collectionView.alwaysBounceVertical = false
        collectionView.alwaysBounceHorizontal = false
        collectionView.allowsSelection = true
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    //MARK:- Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureCollectionView()
        self.recInternshipItemStore = RecInternshipItemStore()
        addItem()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addItem() {
        guard let url = Bundle.main.url(forResource: "Internships", withExtension: "json") else {
            return
        }
        guard let data = try? Data(contentsOf: url) else {
            return
        }
        let decoder = JSONDecoder()
        do {
            let response = try decoder.decode([RecInternshipItem].self, from: data)
            for item in response {
                recInternshipItemStore.allItems.append(item)
            }
        } catch {
            print(error)
        }
    }
}

private extension recInternships {
    
    //MARK:- Setup Helper Functions
    private func configureCollectionView() {
        addSubview(headingLabel)
        addSubview(recInternshipCardCollectionView)
        addSubview(moreButton)
        
        headingLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        headingLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        headingLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        headingLabel.widthAnchor.constraint(equalToConstant: headingLabel.intrinsicContentSize.width).isActive = true
        
        moreButton.centerYAnchor.constraint(equalTo: headingLabel.centerYAnchor).isActive = true
        moreButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        moreButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        moreButton.widthAnchor.constraint(equalToConstant: (self.moreButton.titleLabel?.intrinsicContentSize.width)! + 20).isActive = true
        self.moreButton.layoutIfNeeded()
        
        recInternshipCardCollectionView.register(recInternshipsCell.self, forCellWithReuseIdentifier: recIntersnhipCellID)
        recInternshipCardCollectionView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        recInternshipCardCollectionView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        recInternshipCardCollectionView.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 10).isActive = true
        recInternshipCardCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

extension recInternships: UICollectionViewDataSource {
    
    //MARK:- UICollectionViewDataSource Protocol Functions
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recInternshipItemStore.allItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let recInternshipCell: recInternshipsCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.recIntersnhipCellID, for: indexPath) as! recInternshipsCell
        let item = recInternshipItemStore.allItems[indexPath.row]
        recInternshipCell.locaiton = item.location
        recInternshipCell.title = item.title
        recInternshipCell.companyName = item.companyName
        return recInternshipCell
        
    }
}


extension recInternships: UICollectionViewDelegateFlowLayout {
    
    //MARK:- UICollectionViewDelegateFlowLayout Protocol Functions
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 195, height: 130)
    }
}

extension recInternships: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let item = recInternshipItemStore.allItems[indexPath.row]
        let recInternshipCell = cell as! recInternshipsCell
        recInternshipCell.logo = UIImage(named: item.logo)
    }
}
