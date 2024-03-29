//
//  Videos.swift
//  Rook+
//
//  Created by Delmwin Baeka on 2/14/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

class videos: UICollectionViewCell {
    
    var videosItemStore: VideosItemStore!
    
    let videosCellID = "videosCellID"
    
    lazy var videosCollectionView: UICollectionView = {
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
        videosItemStore = VideosItemStore()
        addItem()
    }
    
    func addItem() {
        guard let url = Bundle.main.url(forResource: "Videos", withExtension: "json") else {
            return
        }
        guard let data = try? Data(contentsOf: url) else {
            return
        }
        let decoder = JSONDecoder()
        do {
            let response = try decoder.decode([VideosItem].self, from: data)
            
            for item in response {
                videosItemStore.allItems.append(item)
            }
        } catch {
            print(error)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension videos {
    
    private func configureCollectionView() {
        addSubview(videosCollectionView)
        
        videosCollectionView.register(videosCell.self, forCellWithReuseIdentifier: videosCellID)
        videosCollectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        videosCollectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        videosCollectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        videosCollectionView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        videosCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

extension videos: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let videosCell: videosCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.videosCellID, for: indexPath) as! videosCell
        let item = videosItemStore.allItems[indexPath.row]
        videosCell.views = item.views
        videosCell.title = item.title
        videosCell.headerText = "• " + item.category
        videosCell.timepost = item.timepost
        return videosCell
        
    }
}

extension videos: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 40, height: videoCellHeight)
    }
}

extension videos: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let item = videosItemStore.allItems[indexPath.row]
        let videosCell = cell as! videosCell
        videosCell.logo = UIImage(named: item.logo)
        videosCell.videoImage = UIImage(named: item.videoImage)
    }
}
