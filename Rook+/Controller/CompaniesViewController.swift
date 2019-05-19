//
//  MyTasksViewController.swift
//  RookPlus
//
//  Created by Delmwin Baeka on 2/27/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

let companiesCellHeight: CGFloat = 124

class CompaniesViewController: UIViewController {
    
    let companiesCellID = "companiesCellID"
  
    var companiesItemStore: CompaniesItemStore!
    
    private var RookTitle: rookLogoVector?
    
    private var notificationButton: RookNotificationButton?
    
    private var searchButton : UIButton?
    
    private var whiteFilterButton : UIButton?
    
    private var navSearchBar: UISearchBar?
    
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
    
    lazy var RookCompaniesCollectionView: UICollectionView = {
        var flowLayout     = UICollectionViewFlowLayout()
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        RookCollectionViewConfiguration.shared().setCollectionViewConfig(for: &collectionView, and: &flowLayout, with: .companies)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.tabBarController?.navigationItem.title = "Companies"
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
       
        self.companiesItemStore = CompaniesItemStore()
        addItem()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         UIApplication.shared.statusBarView?.backgroundColor = self.tabBarController?.navigationController?.view.backgroundColor
        self.tabBarController?.navigationItem.title = "Companies"
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
        view.addSubview(RookCompaniesCollectionView)
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
            
        RookCompaniesCollectionView.register(companiesCell.self, forCellWithReuseIdentifier: companiesCellID)
        RookCompaniesCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        RookCompaniesCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        RookCompaniesCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 5).isActive = true
        RookCompaniesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
    }
    
    private func addItem() {
        guard let url = Bundle.main.url(forResource: "Companies", withExtension: "json") else {
            return
        }
        guard let data = try? Data(contentsOf: url) else {
            return
        }
        let decoder = JSONDecoder()
        do {
            let response = try decoder.decode([CompaniesItem].self, from: data)
            for item in response {
                companiesItemStore.allItems.append(item)
            }
        } catch {
            print(error)
        }
    }
    
    
}

extension CompaniesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let item = companiesItemStore.allItems[indexPath.row]
        let companyCell = cell as! companiesCell
        companyCell.logo = UIImage(named: item.logo)
    }
}

extension CompaniesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 16, height: CGFloat(companiesCellHeight))
    }
}

extension CompaniesViewController: UISearchBarDelegate {
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

extension CompaniesViewController: UIScrollViewDelegate {
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
            let collectionBounds = RookCompaniesCollectionView.bounds
            let searchBarFrame = self.searchBar.frame
            let blueFilterFrame = self.blueFilterButton.frame
            self.searchBar.frame = CGRect(x: collectionBounds.origin.x, y: -collectionBounds.origin.y, width: searchBarFrame.width, height: searchBarFrame.height)
            self.blueFilterButton.frame = CGRect(x: blueFilterFrame.origin.x, y: searchBarFrame.origin.y + searchBarFrame.height/3.2, width: blueFilterFrame.width, height: blueFilterFrame.height)
            self.RookTitle?.textColor = RookColors.shared().rookMainBlue
         //   self.notificationButton?.color = RookColors.shared().rookMainBlue
        }
    }
    
}

extension CompaniesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print("heya")
    }
}

extension CompaniesViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.companiesItemStore.allItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let companyCell: companiesCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.companiesCellID, for: indexPath) as! companiesCell
        let item = self.companiesItemStore.allItems[indexPath.row]
        companyCell.title = item.companyName
        companyCell.bio = item.bio
        companyCell.subheading = item.location + " ● " + item.type
        return companyCell
    }
}


    
