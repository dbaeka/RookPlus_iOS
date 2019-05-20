//
//  Internships.swift
//  RookPlus
//
//  Created by Delmwin Baeka on 3/1/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

protocol ResizableCollectionViewDelegate {
    func resizeParent(with Size: CGSize, for collectionView: UICollectionView)
}


class internships: UICollectionViewCell {
    
    var internshipsItemStore: InternshipItemStore!
    
    let headingLabel: UILabel = {
        let label = UILabel()
        label.text = "All Internships"
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.font = UIFont(name: "Roboto-Medium", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var delegate: ResizableCollectionViewDelegate?
    
    let internshipsCellID = "internshipsCellID"
    let adCellID = "adCellID"
    
    lazy var internshipsCollectionView: UICollectionView = {
        let flowLayout     = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing  = 20
        flowLayout.minimumLineSpacing       = 20
        flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
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
        self.internshipsItemStore = InternshipItemStore()
        addItem()
        
        internshipsCollectionView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.old, context: nil)
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
            let response = try decoder.decode([InternshipItem].self, from: data)
            for item in response {
                internshipsItemStore.allItems.append(item)
            }
        } catch {
            print(error)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let observedObject = object as? UICollectionView, observedObject == self.internshipsCollectionView {
            delegate?.resizeParent(with: self.internshipsCollectionView.collectionViewLayout.collectionViewContentSize, for: self.internshipsCollectionView)
        }
    }
}

private extension internships {
    
    private func configureCollectionView() {
        addSubview(headingLabel)
        addSubview(internshipsCollectionView)
        
        headingLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        headingLabel.widthAnchor.constraint(equalToConstant: headingLabel.intrinsicContentSize.width).isActive = true
        headingLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        headingLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        internshipsCollectionView.register(internshipsCell.self, forCellWithReuseIdentifier: internshipsCellID)
        internshipsCollectionView.register(adCell.self, forCellWithReuseIdentifier: adCellID)
        internshipsCollectionView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width-40).isActive = true
        internshipsCollectionView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        internshipsCollectionView.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 10).isActive = true
        internshipsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
    }
}

extension internships: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return internshipsItemStore.allItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = internshipsItemStore.allItems[indexPath.row]
        if ((indexPath.row+1) % 3 == 0) {
            let adsCell: adCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.adCellID, for: indexPath) as! adCell
            let width = UIScreen.main.bounds.width - UIScreen.main.bounds.width/6
            adsCell.imageHeight = width * item.ratio!
            delegate?.resizeParent(with: self.internshipsCollectionView.collectionViewLayout.collectionViewContentSize, for: collectionView)
            return adsCell
        } else {
            let internshipCell: internshipsCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.internshipsCellID, for: indexPath) as! internshipsCell
            internshipCell.locaiton = item.location
            internshipCell.title = item.title
            internshipCell.companyName = item.companyName
            internshipCell.type = item.type
            internshipCell.deadline = "Apply by " + item.deadline
            return internshipCell
        }
    }
}

extension internships: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if ((indexPath.row+1) % 3 == 0){
            let item = internshipsItemStore.allItems[indexPath.row]
            let width = UIScreen.main.bounds.width - UIScreen.main.bounds.width/6
            let height = item.ratio! * width
            return CGSize(width: width, height: height)
        } else {
            return CGSize(width: UIScreen.main.bounds.width - 40, height: internshipsCellHeight)
        }
    }
}

extension internships: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if ((indexPath.row+1) % 3 == 0) {
            
        } else {
            let item = internshipsItemStore.allItems[indexPath.row]
            let internshipCell = cell as! internshipsCell
            internshipCell.logo = UIImage(named: item.logo)
        }
    }
}
