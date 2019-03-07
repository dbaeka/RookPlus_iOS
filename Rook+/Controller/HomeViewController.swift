//
//  HomeViewController.swift
//  Rook+
//
//  Created by Delmwin Baeka on 2/13/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit


let completeProfileCellHeight: CGFloat = (UIScreen.main.bounds.width - UIScreen.main.bounds.width/9)/4
let discoverCardCellHeight: CGFloat  = 265
let pollCardCellHeight: CGFloat  = 155
let eventsCellHeight: CGFloat = 130
let forYouCellHeight: CGFloat = 70
let videoCellHeight: CGFloat = 100
let newsCellHeight: CGFloat = 100
let numberOfDiscoverCards = 5
let numberOfPollCards = 6
let numberOfEvents = 4
let numberOfForYou = 4
let numberOfVideos = 4
let numberOfNews = 5

class HomeViewController: UIViewController {
    
    let completeProfileCellID = "completeProfileCellID"
    let discoverCardCellID = "discoverCardCellID"
    let pollCardCellID = "pollCardCellID"
    let eventsCellID = "eventsCellID"
    let SectionHeaderViewID = "SectionHeaderViewID"
    let SectionFooterViewID = "SectionFooterViewID"
    let forYouCellID = "forYouCellID"
    let videosCellID = "videosCellID"
    let newsCellID = "newsCellID"
    
    private var RookTitle: rookLogoVector?
    
    private var notificationButton: RookNotificationButton?
    
    lazy var RookHomeCollectionView: UICollectionView = {
        var flowLayout     = UICollectionViewFlowLayout()
        
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        RookCollectionViewConfiguration.shared().setCollectionViewConfig(for: &collectionView, and: &flowLayout, with: .home)
       
        return collectionView
    }()
    
    private let whiteFilterButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "whiteFilter.png"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let searchButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "search.png"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let searchBar: UISearchBar = {
        let search = UISearchBar()
        search.placeholder = " search"
        search.searchBarStyle = UISearchBar.Style.minimal
        let searchBarTextField = search.value(forKey: "searchField") as? UITextField
        searchBarTextField?.font = UIFont(name: "Roboto-Regular", size: 10)
        search.setSearchFieldBackgroundImage(UIImage(named: "searchWhiteColor"), for: .normal)
        searchBarTextField?.leftView?.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.tabBarController?.navigationItem.title = "Home"
        self.tabBarController?.navigationController?.navigationBar.barTintColor = UIColor.white
        self.tabBarController?.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        if #available(iOS 11.0, *) {
            self.tabBarController?.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
            self.tabBarController?.navigationController?.navigationBar.prefersLargeTitles = true
        } else {
            // Fallback on earlier versions
        }
        
        view.backgroundColor = UIColor.white
        UIApplication.shared.statusBarView?.backgroundColor = self.tabBarController?.navigationController?.view.backgroundColor
        self.configureCollectionView()
        
        guard let navBar = self.navigationController?.navigationBar else {
            return
        }
        
        let RookTitle = rookLogoVector(frame: CGRect(x: 0, y: 0, width: 45, height: 15))
        self.RookTitle = RookTitle
        navBar.addSubview(RookTitle)
        RookTitle.tag = 1
        RookTitle.translatesAutoresizingMaskIntoConstraints = false
        RookTitle.topAnchor.constraint(equalTo: navBar.topAnchor, constant: 12).isActive = true
        RookTitle.heightAnchor.constraint(equalToConstant: 15).isActive = true
        RookTitle.leadingAnchor.constraint(equalTo: navBar.leadingAnchor, constant: 17).isActive = true
        RookTitle.widthAnchor.constraint(equalToConstant: 45).isActive = true
        
        let notificationButton = RookNotificationButton(frame: CGRect(x: 0, y: 0, width: 17, height: 20))
        self.notificationButton = notificationButton
        navBar.addSubview(notificationButton)
        notificationButton.tag = 2
        notificationButton.translatesAutoresizingMaskIntoConstraints = false
        notificationButton.topAnchor.constraint(equalTo: navBar.topAnchor, constant: 12).isActive = true
        notificationButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        notificationButton.trailingAnchor.constraint(equalTo: navBar.trailingAnchor, constant: -17).isActive = true
        notificationButton.widthAnchor.constraint(equalToConstant: 17).isActive = true

        navBar.addSubview(whiteFilterButton)
        whiteFilterButton.tag = 3
        whiteFilterButton.topAnchor.constraint(equalTo: navBar.topAnchor, constant: 12).isActive = true
        whiteFilterButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        whiteFilterButton.trailingAnchor.constraint(equalTo: navBar.trailingAnchor, constant: -17).isActive = true
        whiteFilterButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        navBar.addSubview(searchButton)
        searchButton.tag = 4
        searchButton.topAnchor.constraint(equalTo: navBar.topAnchor, constant: 12).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        searchButton.trailingAnchor.constraint(equalTo: whiteFilterButton.leadingAnchor, constant: -5).isActive = true
        searchButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        navBar.addSubview(searchBar)
        searchBar.tag = 5
        searchBar.centerYAnchor.constraint(equalTo: whiteFilterButton.centerYAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: navBar.leadingAnchor, constant: 15).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: -10).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: self.searchBar.intrinsicContentSize.height).isActive = true
        searchBar.layoutIfNeeded()
        let offset = UIOffset(horizontal: searchBar.frame.width/2 - 30, vertical: 0)
        searchBar.setPositionAdjustment(offset, for: UISearchBar.Icon.search)
        
        
        
        searchButton.isHidden = true
        whiteFilterButton.isHidden = true
        searchBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         UIApplication.shared.statusBarView?.backgroundColor = self.tabBarController?.navigationController?.view.backgroundColor
        self.tabBarController?.navigationItem.title = "Home"
        if #available(iOS 11.0, *) {
            self.tabBarController?.navigationController?.navigationBar.prefersLargeTitles = true
        }
        self.tabBarController?.navigationController?.isNavigationBarHidden = false
        guard let navBarHeight = self.navigationController?.navigationBar.frame.height else {
            return
        }
        var navHeight: CGFloat = 46
        if #available(iOS 12.0, *), self.sizeClass() == (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular) {
            navHeight = 52
        }
        if (navBarHeight <= navHeight) {
            UIApplication.shared.statusBarStyle = .lightContent
        } else {
            UIApplication.shared.statusBarStyle = .default
        }
        searchButton.isHidden = true
        whiteFilterButton.isHidden = true
        notificationButton?.isHidden = false
    }
    
    private func configureCollectionView() {
        view.addSubview(RookHomeCollectionView)
        
        RookHomeCollectionView.register(completeProfile.self, forCellWithReuseIdentifier: completeProfileCellID)
        RookHomeCollectionView.register(discoverCard.self, forCellWithReuseIdentifier: discoverCardCellID)
        RookHomeCollectionView.register(pollCard.self, forCellWithReuseIdentifier: pollCardCellID)
        RookHomeCollectionView.register(events.self, forCellWithReuseIdentifier: eventsCellID)
        RookHomeCollectionView.register(forYou.self, forCellWithReuseIdentifier: forYouCellID)
        RookHomeCollectionView.register(videos.self, forCellWithReuseIdentifier: videosCellID)
        RookHomeCollectionView.register(news.self, forCellWithReuseIdentifier: newsCellID)
        RookHomeCollectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderViewID)
        RookHomeCollectionView.register(SectionFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: SectionFooterViewID)
        
        
        
        RookHomeCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        RookHomeCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        RookHomeCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        RookHomeCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    
}

extension HomeViewController: UICollectionViewDelegate {}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
            return CGSize(width: UIScreen.main.bounds.width, height: CGFloat(completeProfileCellHeight))
        }
            
        else if indexPath.section == 1 {
            switch indexPath.item {
            case 0:
                return CGSize(width: UIScreen.main.bounds.width, height: CGFloat(discoverCardCellHeight))
            case 1:
                return CGSize(width: UIScreen.main.bounds.width, height: CGFloat(pollCardCellHeight))
            case 2:
                return CGSize(width: UIScreen.main.bounds.width, height: ((eventsCellHeight + 15) * CGFloat(numberOfEvents)) + 10)
            default:
                return CGSize(width: UIScreen.main.bounds.width, height: ((forYouCellHeight + 15) * CGFloat(numberOfEvents)) + 15)
            }
            
        } else if indexPath.section == 2 {
            
            return CGSize(width: UIScreen.main.bounds.width, height: ((videoCellHeight + 15) * CGFloat(numberOfVideos)) + 15)
            
        } else {
            
            return CGSize(width: UIScreen.main.bounds.width, height: ((newsCellHeight + 15) * CGFloat(numberOfNews)) + 15)
            
        }
        
        
    }
}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let navBarHeight = self.navigationController?.navigationBar.frame.height else {
            return
        }
        var navHeight: CGFloat = 46
        if #available(iOS 12.0, *), self.sizeClass() == (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular) {
            navHeight = 52
        }
        if (navBarHeight <= navHeight) {
            self.navigationController?.navigationBar.barTintColor = RookColors.shared().rookMainBlue
            self.navigationController?.navigationBar.isTranslucent = false
            self.RookTitle?.textColor = RookColors.shared().rookWhite
            self.notificationButton?.color = RookColors.shared().rookWhite
            UIApplication.shared.statusBarStyle = .lightContent
            setNeedsStatusBarAppearanceUpdate()
        } else {
            self.navigationController?.navigationBar.barTintColor = UIColor.white
            UIApplication.shared.statusBarStyle = .default
            self.RookTitle?.textColor = RookColors.shared().rookMainBlue
            self.notificationButton?.color = RookColors.shared().rookMainBlue
        }
    }
    
}

extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 4
        case 2:
            return 1
        default:
            return 1
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
            
        case UICollectionView.elementKindSectionHeader:
            
            let headerView : SectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderViewID, for: indexPath) as! SectionHeaderView
            
            if indexPath.section == 1 {
                headerView.text = "Discover"
            } else if indexPath.section == 2 {
                headerView.text = "Videos"
                headerView.buttonIsVisible = true
            } else if indexPath.section == 3 {
                headerView.text = "News"
            } else {
                headerView.text = ""
                headerView.frame.size.height = 0
                headerView.frame.size.width = 0
            }
            
            return headerView
            
        case UICollectionView.elementKindSectionFooter:
            
            let headerView : SectionFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionFooterViewID, for: indexPath) as! SectionFooterView
            
            return headerView
            
        default:
            assert(false, "Unexpected element kind")
            return UICollectionReusableView()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let completeProfileCell: completeProfile = collectionView.dequeueReusableCell(withReuseIdentifier: self.completeProfileCellID, for: indexPath) as! completeProfile
            return completeProfileCell
        } else if indexPath.section == 1 {
            switch indexPath.item {
            case 0:
                let discoverCardCell: discoverCard = collectionView.dequeueReusableCell(withReuseIdentifier: self.discoverCardCellID, for: indexPath) as! discoverCard
                return discoverCardCell
            case 1:
                let pollCardCell: pollCard = collectionView.dequeueReusableCell(withReuseIdentifier: self.pollCardCellID, for: indexPath) as! pollCard
                return pollCardCell
            case 2:
                let eventsCell: events = collectionView.dequeueReusableCell(withReuseIdentifier: self.eventsCellID, for: indexPath) as! events
                return eventsCell
            default:
                let forYouCell: forYou = collectionView.dequeueReusableCell(withReuseIdentifier: self.forYouCellID, for: indexPath) as! forYou
                return forYouCell
            }
        } else if indexPath.section == 2 {
            let videosCell: videos = collectionView.dequeueReusableCell(withReuseIdentifier: self.videosCellID, for: indexPath) as! videos
            return videosCell
        } else {
            let newsCell: news = collectionView.dequeueReusableCell(withReuseIdentifier: self.newsCellID, for: indexPath) as! news
            return newsCell
        }
    }
}
