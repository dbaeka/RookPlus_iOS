//
//  InternshipsViewController.swift
//  RookPlus
//
//  Created by Delmwin Baeka on 3/1/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

let internshipsCellHeight: CGFloat = 85
let recInternshipsCellHeight: CGFloat = 160
let numberOfInternships = 5

class InternshipsViewController: UIViewController {
    
    let internshipsCellID = "internshipsCellID"
    let recInternshipsCellID = "recInternshipsCellID"
    let SectionFooterViewID = "SectionFooterViewID"
    
    private var RookTitle: rookLogoVector?
    
    private var notificationButton: RookNotificationButton?
    
    private var searchButton : UIButton?
    
    private var whiteFilterButton : UIButton?
    
    private var navSearchBar: UISearchBar?
    
    private var collectionViewHeight: CGFloat = 0
    
    private let searchBar: UISearchBar = {
        let search = UISearchBar()
        search.placeholder = "search"
        search.searchBarStyle = UISearchBar.Style.minimal
        let searchBarTextField = search.value(forKey: "searchField") as? UITextField
        searchBarTextField?.font = UIFont(name: "Roboto-Regular", size: 10)
        searchBarTextField?.leftView?.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    
    private let blueFilterButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "blueFilter.png"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var RookInternshipsCollectionView: UICollectionView = {
        var flowLayout     = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        RookCollectionViewConfiguration.shared().setCollectionViewConfig(for: &collectionView, and: &flowLayout, with: .internships)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.tabBarController?.navigationItem.title = "Internships"
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
        
        
        guard let navBar = self.navigationController?.navigationBar else {
            return
        }
        
        RookTitle = navBar.viewWithTag(1) as? rookLogoVector
        notificationButton = navBar.viewWithTag(2) as? RookNotificationButton
        whiteFilterButton = navBar.viewWithTag(3) as? UIButton
        searchButton = navBar.viewWithTag(4) as? UIButton
        navSearchBar = navBar.viewWithTag(5) as? UISearchBar
        
        notificationButton?.isHidden = true
        whiteFilterButton?.isHidden = false
        searchButton?.isHidden = false
        searchButton?.addTarget(self, action: #selector(searchBarAction), for: .touchUpInside)
        navSearchBar?.delegate = self
        navSearchBar?.alpha = 0
        
        self.configureCollectionView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         UIApplication.shared.statusBarView?.backgroundColor = self.tabBarController?.navigationController?.view.backgroundColor
        self.tabBarController?.navigationItem.title = "Internships"
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
        searchButton?.isHidden = false
        whiteFilterButton?.isHidden = false
        notificationButton?.isHidden = true
    }
    
    @objc private func searchBarAction(){
        if navSearchBar?.alpha == 0 {
            showSearchBar()
        } else {
            hideSearchBar()
        }
    }
    
    private func showSearchBar(){
        navSearchBar?.isHidden = false
        navSearchBar?.alpha = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.navSearchBar?.alpha = 1
        })
    }
    
    private func hideSearchBar(){
        UIView.animate(withDuration: 0.3, animations: {
            self.navSearchBar?.alpha = 0
            self.searchButton?.isHidden = false
        })
    }
    
    private var searchBarHeight: NSLayoutConstraint?
    
    
    private func configureCollectionView() {
        view.addSubview(RookInternshipsCollectionView)
        view.addSubview(searchBar)
        view.addSubview(blueFilterButton)
        
        blueFilterButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        blueFilterButton.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor).isActive = true
        blueFilterButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        blueFilterButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        searchBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        searchBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        searchBar.rightAnchor.constraint(equalTo: blueFilterButton.leftAnchor, constant: -5).isActive = true
        self.searchBarHeight = searchBar.heightAnchor.constraint(equalToConstant: searchBar.intrinsicContentSize.height)
        self.searchBarHeight?.isActive = true
        searchBar.layoutIfNeeded()
        searchBar.delegate = self
        let offset = UIOffset(horizontal: searchBar.frame.width/2 - 30, vertical: 0)
        searchBar.setPositionAdjustment(offset, for: UISearchBar.Icon.search)
        
        RookInternshipsCollectionView.register(recInternships.self, forCellWithReuseIdentifier: recInternshipsCellID)
        RookInternshipsCollectionView.register(internships.self, forCellWithReuseIdentifier: internshipsCellID)
        RookInternshipsCollectionView.register(SectionFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: SectionFooterViewID)
 
        RookInternshipsCollectionView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        RookInternshipsCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 5).isActive = true
        RookInternshipsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    
}

extension InternshipsViewController: ResizableCollectionViewDelegate {
    func resizeParent(with Size: CGSize, for collectionView: UICollectionView) {
        collectionViewHeight = Size.height
        RookInternshipsCollectionView.reloadData()
    }
}

extension InternshipsViewController: UICollectionViewDelegate {}

extension InternshipsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: UIScreen.main.bounds.width, height: CGFloat(recInternshipsCellHeight))
        } else {
            return CGSize(width: UIScreen.main.bounds.width, height: collectionViewHeight)
        }
    }
}

extension InternshipsViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        let zeroOffset = UIOffset(horizontal: 0, vertical: 0)
        searchBar.setPositionAdjustment(zeroOffset, for: UISearchBar.Icon.search)
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        if (searchBar.tag != 5){
            let offset = UIOffset(horizontal: searchBar.frame.width/2 - 30, vertical: 0)
            searchBar.setPositionAdjustment(offset, for: UISearchBar.Icon.search)
            
        }
        return true
    }
}

extension InternshipsViewController: UIScrollViewDelegate {
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
            //  self.notificationButton?.color = RookColors.shared().rookWhite
            self.searchBar.isHidden = true
            self.navSearchBar?.isHidden = false
            self.blueFilterButton.isHidden = true
            self.searchBarHeight?.constant = 0
            UIApplication.shared.statusBarStyle = .lightContent
            setNeedsStatusBarAppearanceUpdate()
        } else {
            self.navigationController?.navigationBar.barTintColor = UIColor.white
             UIApplication.shared.statusBarStyle = .default
            self.searchBar.isHidden = false
            self.navSearchBar?.isHidden = true
            self.blueFilterButton.isHidden = false
            self.searchBarHeight?.constant = self.searchBar.intrinsicContentSize.height
            let collectionBounds = RookInternshipsCollectionView.bounds
            let searchBarFrame = self.searchBar.frame
            let blueFilterFrame = self.blueFilterButton.frame
            self.searchBar.frame = CGRect(x: collectionBounds.origin.x, y: -collectionBounds.origin.y, width: searchBarFrame.width, height: searchBarFrame.height)
            self.blueFilterButton.frame = CGRect(x: blueFilterFrame.origin.x, y: searchBarFrame.origin.y + searchBarFrame.height/3.2, width: blueFilterFrame.width, height: blueFilterFrame.height)
            self.RookTitle?.textColor = RookColors.shared().rookMainBlue
            //   self.notificationButton?.color = RookColors.shared().rookMainBlue
        }
    }
    
}

extension InternshipsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print("heya")
    }
}

extension InternshipsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         if indexPath.section == 0 {
            let recInternshipsCell: recInternships = collectionView.dequeueReusableCell(withReuseIdentifier: self.recInternshipsCellID, for: indexPath) as! recInternships
            return recInternshipsCell
         } else {
            let internshipsCell: internships = collectionView.dequeueReusableCell(withReuseIdentifier: self.internshipsCellID, for: indexPath) as! internships
            internshipsCell.delegate = self
            return internshipsCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionFooter:
            let footerView : SectionFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionFooterViewID, for: indexPath) as! SectionFooterView
            
            return footerView
        default:
            assert(false, "Unexpected element kind")
            return UICollectionReusableView()
        }
    }
}



