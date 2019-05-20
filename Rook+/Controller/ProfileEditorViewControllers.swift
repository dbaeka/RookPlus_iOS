//
//  ProfileEditorViewControllers.swift
//  RookPlus
//
//  Created by Delmwin Baeka on 5/7/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

class TagEditViewController: UIViewController {
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tabBarController?.navigationController?.isNavigationBarHidden = false
//        self.tabBarController?.navigationItem.hidesBackButton = true
//        self.tabBarController?.navigationItem.title = "Companies"
//        self.tabBarController?.navigationController?.navigationBar.barTintColor = UIColor.white
//        self.tabBarController?.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//        if #available(iOS 11.0, *) {
//            self.tabBarController?.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
//            self.tabBarController?.navigationController?.navigationBar.prefersLargeTitles = true
//        } else {
//            // Fallback on earlier versions
//        }
        
        view.backgroundColor = UIColor.white
       // UIApplication.shared.statusBarView?.backgroundColor = self.tabBarController?.navigationController?.view.backgroundColor
        
        
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
       // searchButton?.isHidden = false
      //  searchButton?.addTarget(self, action: #selector(searchBarAction), for: .touchUpInside)
      //  navSearchBar?.delegate = self
        navSearchBar?.alpha = 0
        
        self.configureCollectionView()
        
    }
    
    override func loadView() {
        super.loadView()
        view = UIView(frame: UIScreen.main.bounds)
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
        view.addSubview(searchBar)
        view.addSubview(blueFilterButton)
        
        blueFilterButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        blueFilterButton.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor).isActive = true
        blueFilterButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        blueFilterButton.widthAnchor.constraint(equalToConstant: 20).isActive = true        
    }
   
    
}
