//
//  RookCollectionViewConfiguration.swift
//  Rook+
//
//  Created by Delmwin Baeka on 2/15/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

public enum RookCollectionViewAppearanceType {
    case home, discover
}

public class RookCollectionViewConfiguration {
    
    private static var privateShared: RookCollectionViewConfiguration?
    
    private var flowLayout: RookCollectionFlowLayout!
    
    private var collectionViewAppearance: RookCollectionViewAppearance!
    
    class func shared() -> RookCollectionViewConfiguration {
        guard let stillAlive = privateShared else {
            privateShared = RookCollectionViewConfiguration()
            return privateShared!
        }
        return stillAlive
    }
    
    public func setCollectionViewConfig(for collectionView: inout UICollectionView, and flowLayout: inout UICollectionViewFlowLayout, with appearance: RookCollectionViewAppearanceType) {
        switch appearance {
        case .home:
            collectionViewAppearance = RookHomeAppearance()
            self.flowLayout = RookHomeAppearance()
            
            flowLayout.headerReferenceSize = self.flowLayout.headerReferenceSize
            flowLayout.footerReferenceSize = self.flowLayout.footerReferenceSize
        case .discover:
            collectionViewAppearance = RookDiscoverAppearance()
            self.flowLayout = RookDiscoverAppearance()
        }
        
        collectionView.backgroundColor = collectionViewAppearance.backgroundColor
        collectionView.contentInset = collectionViewAppearance.contentInset
        collectionView.alwaysBounceVertical = collectionViewAppearance.alwaysBounceVertical
        collectionView.alwaysBounceHorizontal = collectionViewAppearance.alwaysBounceHorizontal
        collectionView.allowsSelection = collectionViewAppearance.allowsSelection
        collectionView.showsVerticalScrollIndicator = collectionViewAppearance.showsVerticalScrollIndicator
        collectionView.translatesAutoresizingMaskIntoConstraints = collectionViewAppearance.translatesAutoresizingMaskIntoConstraints
        collectionView.isScrollEnabled = collectionViewAppearance.isScrollingEnabled
        collectionView.showsHorizontalScrollIndicator = collectionViewAppearance.showsHorizontalScrollIndicator
        
        flowLayout.minimumInteritemSpacing  = self.flowLayout.minimumInteritemSpacing
        flowLayout.minimumLineSpacing       = self.flowLayout.minimumLineSpacing
        flowLayout.scrollDirection = self.flowLayout.scrollDirection
        
    }
}


fileprivate protocol RookCollectionFlowLayout {
    
    var minimumInteritemSpacing: CGFloat { get }
    
    var minimumLineSpacing: CGFloat { get }
    
    var scrollDirection: UICollectionView.ScrollDirection { get }
    
    var headerReferenceSize: CGSize { get }
    
    var footerReferenceSize: CGSize { get }
}

extension RookCollectionFlowLayout {
    var headerReferenceSize: CGSize  {return CGSize(width: UIScreen.main.bounds.width, height: 30)}
    
    var footerReferenceSize: CGSize  { return CGSize(width: UIScreen.main.bounds.width, height: 20) }
}

fileprivate protocol RookCollectionViewAppearance {
    
    var backgroundColor: UIColor { get }
    
    var contentInset: UIEdgeInsets { get }
    
    var alwaysBounceVertical: Bool { get }
    
    var alwaysBounceHorizontal: Bool { get }
    
    var allowsSelection: Bool { get }
    
    var showsVerticalScrollIndicator: Bool { get }
    
    var translatesAutoresizingMaskIntoConstraints: Bool { get }
    
    var isScrollingEnabled: Bool { get }
    
    var showsHorizontalScrollIndicator: Bool { get }
}

fileprivate struct RookHomeAppearance: RookCollectionViewAppearance, RookCollectionFlowLayout {
    
    var minimumInteritemSpacing: CGFloat = 15
    
    var minimumLineSpacing: CGFloat = 20
    
    var scrollDirection: UICollectionView.ScrollDirection = .vertical
    
    var backgroundColor: UIColor = .white
    
    var contentInset: UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 15, right: 0.0)
    
    var alwaysBounceVertical = true
    
    var alwaysBounceHorizontal = false
    
    var allowsSelection = true
    
    var showsVerticalScrollIndicator = false
    
    var translatesAutoresizingMaskIntoConstraints = false
    
    var showsHorizontalScrollIndicator: Bool = false
    
    var isScrollingEnabled: Bool = true
    
    init() {}
}

fileprivate struct RookDiscoverAppearance: RookCollectionViewAppearance, RookCollectionFlowLayout {
    var minimumInteritemSpacing: CGFloat = 5
    
    var minimumLineSpacing: CGFloat = 15
    
    var scrollDirection: UICollectionView.ScrollDirection = .horizontal
    
    var alwaysBounceVertical: Bool = false
    
    var alwaysBounceHorizontal: Bool = false
    
    var allowsSelection: Bool = true
    
    var showsVerticalScrollIndicator: Bool = false
    
    var translatesAutoresizingMaskIntoConstraints: Bool = false
    
    var contentInset: UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 0.0)

    var backgroundColor: UIColor = .white
    
    var showsHorizontalScrollIndicator: Bool = false
    
    var isScrollingEnabled: Bool = true
    
    init() {}
}
