//
//  News.swift
//  Rook+
//
//  Created by Delmwin Baeka on 2/14/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

class news: UICollectionViewCell {
    
    var newsItemStore: NewsItemStore!
    
    let newsCellID = "newsCellID"
    
    lazy var newsCollectionView: UICollectionView = {
        let flowLayout     = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing  = 15
        flowLayout.minimumLineSpacing       = 20
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
        self.newsItemStore = NewsItemStore()
        addItem()
    }
    
    func addItem() {
        guard let url = Bundle.main.url(forResource: "News", withExtension: "json") else {
            return
        }
        guard let data = try? Data(contentsOf: url) else {
            return
        }
        let decoder = JSONDecoder()
        do {
            let response = try decoder.decode([NewsItem].self, from: data)
            for item in response {
                newsItemStore.allItems.append(item)
            }
        } catch {
            print(error)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension news {
    private func configureCollectionView() {
        addSubview(newsCollectionView)
        
        newsCollectionView.register(newsCell.self, forCellWithReuseIdentifier: newsCellID)
        newsCollectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        newsCollectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        newsCollectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        newsCollectionView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        newsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

extension news: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsItemStore.allItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let newsCell: newsCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.newsCellID, for: indexPath) as! newsCell
        let item = self.newsItemStore.allItems[indexPath.row]
        newsCell.companyName = item.companyName
        newsCell.timepost = item.timepost
        newsCell.title = item.title
        return newsCell
        
    }
}

extension news: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 40, height: newsCellHeight)
    }
}

extension news: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let item = newsItemStore.allItems[indexPath.row]
        let newsCell = cell as! newsCell
        newsCell.logo = UIImage(named: item.logo)
        newsCell.sourceImage = UIImage(named: item.source.rawValue)
    }
}
