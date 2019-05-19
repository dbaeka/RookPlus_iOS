//
//  InterestsPageViewController.swift
//  RookPlus
//
//  Created by Delmwin Baeka on 3/15/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

class InterestsPageViewController: UIViewController {
    
    var tags: [String] = ["Writing", "Music","Writing", "Music","Writing", "Music","Writing", "Music","Writing", "Music"]
    
    private let background: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "background3")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let headingLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "Choose your interests"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont(name: "Roboto-Bold", size: 22)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let addInterestTextField: UITextField = {
        let textfield = UITextField()
        textfield.tintColor = .white
        textfield.textColor = .white
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.font = UIFont(name: "Roboto-Regular", size: 17)
        return textfield
    }()
    
    lazy var InterestsCollectionView: UICollectionView = {
        let tagCellLayout = TagCellLayout(alignment: .center, delegate: self)
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: tagCellLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        collectionView.allowsSelection = true
        return collectionView
    }()
    
    private let getStartedAlreadyButton: UIButton = {
        let button = UIButton()
        guard let font = UIFont(name: "Roboto-Bold", size: 17) else {return UIButton()}
        let labelAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.black]
        let labelString = NSMutableAttributedString(string: "Get Started Already", attributes: labelAttributes)
        button.setAttributedTitle(labelString, for: .normal)
        button.backgroundColor = UIColor.white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let addInterestButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "add"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    private let tagsCollectionViewID = "tagsCollectionViewID"
    
    private var oneLineHeight: CGFloat {
        return 30.0
    }
    
    var longTagIndex: Int {
        return 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureCollectionView()
    }
    
    private func configureCollectionView() {
        self.automaticallyAdjustsScrollViewInsets = false
        view.addSubview(background)
        view.addSubview(headingLabel)
        view.addSubview(addInterestTextField)
        view.addSubview(InterestsCollectionView)
        view.addSubview(getStartedAlreadyButton)
        self.getStartedAlreadyButton.addTarget(self, action: #selector(getStartedAction(_:)), for: .touchUpInside)
        view.addSubview(addInterestButton)
        addInterestButton.addTarget(self, action: #selector(addInterest), for: .touchUpInside)
        
        let width = UIScreen.main.bounds.width
        let screenRatio = UIScreen.main.bounds.height/UIScreen.main.bounds.width
        let distanceToTop: CGFloat = (screenRatio < 2.0 && self.sizeClass() != (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) ? 50 : 60
        let textFontSize: CGFloat = (self.sizeClass() == (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) ? 35 : 20
        let textFieldWIdth: CGFloat = (self.sizeClass() == (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) ? 400 : width-100
        
        self.headingLabel.font = UIFont(name: "Roboto-Bold", size: textFontSize)
        self.headingLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: distanceToTop).isActive = true
        self.headingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.headingLabel.heightAnchor.constraint(equalToConstant: headingLabel.intrinsicContentSize.width/7.5).isActive = true
        
        self.background.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.background.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        self.background.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        self.background.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        InterestsCollectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: tagsCollectionViewID)
        InterestsCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        InterestsCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        InterestsCollectionView.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: distanceToTop/1.5).isActive = true
        InterestsCollectionView.bottomAnchor.constraint(equalTo: addInterestTextField.topAnchor, constant: -30).isActive = true
        
        self.addInterestTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: distanceToTop).isActive = true
        self.addInterestTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.addInterestTextField.widthAnchor.constraint(equalToConstant: textFieldWIdth).isActive = true
        
        let lineView = UIView()
        lineView.backgroundColor = .white
        lineView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lineView)
        lineView.topAnchor.constraint(equalTo: addInterestTextField.bottomAnchor).isActive = true
        lineView.widthAnchor.constraint(equalToConstant: textFieldWIdth).isActive = true
        lineView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        self.addInterestButton.leftAnchor.constraint(equalTo: addInterestTextField.rightAnchor).isActive = true
        self.addInterestButton.bottomAnchor.constraint(equalTo: addInterestTextField.bottomAnchor, constant: -10).isActive = true
        self.addInterestButton.widthAnchor.constraint(equalToConstant: 27).isActive = true
        self.addInterestButton.heightAnchor.constraint(equalToConstant: 27).isActive = true
        
        self.getStartedAlreadyButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -distanceToTop).isActive = true
        self.getStartedAlreadyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.getStartedAlreadyButton.widthAnchor.constraint(equalToConstant: textFieldWIdth - 40).isActive = true
        self.getStartedAlreadyButton.heightAnchor.constraint(equalToConstant: (textFieldWIdth - 40)/5.2).isActive = true
        self.getStartedAlreadyButton.layer.cornerRadius = (textFieldWIdth - 40)/16
    }
    
    @objc func addInterest() {
        guard let tag = addInterestTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        if !tags.contains(tag) && !tag.isEmpty {
            self.tags.append(tag)
            self.InterestsCollectionView.reloadData()
        }
    }
    
    @objc private func getStartedAction(_ sender: Any) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainNavigationController") else {return}
        self.present(vc, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.addInterestTextField.resignFirstResponder()
    }
}

extension InterestsPageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: - UICollectionView Delegate/Datasource Methods
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tagsCollectionViewID, for: indexPath) as! TagCollectionViewCell
        let item = tags[indexPath.row]
        cell.configure(with: item)
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.addInterestTextField.resignFirstResponder()
        let cell = collectionView.cellForItem(at: indexPath) as! TagCollectionViewCell
        cell.tagSelected = !cell.tagSelected
    }
}

extension InterestsPageViewController: TagCellLayoutDelegate {
    
    func tagCellLayoutTagSize(layout: TagCellLayout, atIndex index: Int) -> CGSize {
        if tags[index].count <= 7 {
            let width: CGFloat = (tags[index].count < 3) ? 60 : 100
            return CGSize(width: width, height: oneLineHeight)
        } else {
            var s = textSize(text: tags[index], font: UIFont(name: "Roboto-Medium", size: 17)!, collectionView: InterestsCollectionView)
            s.height += 8.0
            return s
        }
    }
}

extension InterestsPageViewController {
    
    func textSize(text: String, font: UIFont, collectionView: UICollectionView) -> CGSize {
        var f = collectionView.bounds
        f.size.height = 9999.0
        let label = UILabel()
        label.numberOfLines = 0
        label.text = text
        label.font = font
        var s = label.sizeThatFits(f.size)
        s.height = max(oneLineHeight, s.height)
        return s
    }
}


