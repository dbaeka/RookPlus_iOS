//
//  ProfileViewController.swift
//  RookPlus
//
//  Created by Delmwin Baeka on 3/1/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

//let internshipsCellHeight: CGFloat = 85
//let recInternshipsCellHeight: CGFloat = 160
//let numberOfInternships = 5

class ProfileViewController: UIViewController {
    
    let basicInfoCellID = "basicInfoCellID"
    let statsCellID = "statsCellID"
    let walletCellID = "walletCellID"
    let psychometricTestCellID = "psychometricTestCellID"
    let demopgraphicsCellID = "demopgraphicsCellID"
    let educationCellID = "educationCellID"
    let workExperienceCellID = "workExperienceCellID"
    let skillsCellID = "skillsCellID"
    let interestsCellID = "interestsCellID"
    let aptitudeTestCellID = "aptitudeTestCellID"
    let portfolioCellID = "portfolioCellID"
    
    private var topBlueBar: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#004AEF")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var navBar: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#004AEF")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var educationViewHeight: CGFloat = 100
    
    private var workExperienceViewHeight: CGFloat = 100
    
    private var portfolioViewHeight: CGFloat = 100
    
    lazy var RookProfileCollectionView: UICollectionView = {
        var flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        RookCollectionViewConfiguration.shared().setCollectionViewConfig(for: &collectionView, and: &flowLayout, with: .profile)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.navigationController?.isNavigationBarHidden = true
        UIApplication.shared.statusBarView?.backgroundColor = UIColor(hexString: "#004AEF")
        RookProfileCollectionView.backgroundColor = UIColor.clear
        UIApplication.shared.statusBarStyle = .lightContent
        
        view.addSubview(topBlueBar)
        view.backgroundColor = UIColor.white
        
        self.configureCollectionView()
        
        let titleLabel = UILabel()
        titleLabel.text = "Profile"
        titleLabel.textColor = UIColor.white
        titleLabel.numberOfLines = 1
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let settingsButton : UIButton = UIButton()
        settingsButton.setImage(UIImage(named: "Settings.png"), for: .normal)
        settingsButton.setImage(UIImage(named: "SettingsPressed.png"), for: .highlighted)
        settingsButton.imageView?.contentMode = .scaleAspectFit
        settingsButton.clipsToBounds = true
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        
        let cvButton : RookRoundButton = RookRoundButton()
        guard let font = UIFont(name: "Roboto-Regular", size: 12) else {return}
        let labelAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor(hexString: "#004AEF")]
        let labelString = NSMutableAttributedString(string: "CV", attributes: labelAttributes)
        cvButton.setAttributedTitle(labelString, for: .normal)
        cvButton.backgroundColor = UIColor.white
        cvButton.isShadowOn = false
        cvButton.translatesAutoresizingMaskIntoConstraints = false
      
        navBar.addSubview(titleLabel)
        navBar.addSubview(settingsButton)
        navBar.addSubview(cvButton)
        
        titleLabel.centerXAnchor.constraint(equalTo: navBar.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: navBar.centerYAnchor).isActive = true
        
        settingsButton.rightAnchor.constraint(equalTo: navBar.rightAnchor, constant: -17).isActive = true
        settingsButton.centerYAnchor.constraint(equalTo: navBar.centerYAnchor).isActive = true
        settingsButton.widthAnchor.constraint(equalToConstant: 23).isActive = true
        settingsButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        cvButton.leftAnchor.constraint(equalTo: navBar.leftAnchor, constant: 17).isActive = true
        cvButton.centerYAnchor.constraint(equalTo: navBar.centerYAnchor).isActive = true
        cvButton.widthAnchor.constraint(equalToConstant: 56).isActive = true
        cvButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarView?.backgroundColor = UIColor(hexString: "#004AEF")
        self.tabBarController?.navigationController?.isNavigationBarHidden = true
        let viewFrame = view.frame
        view.frame = CGRect(x: viewFrame.origin.x, y: viewFrame.origin.y, width: viewFrame.width, height: UIScreen.main.bounds.height)
        self.view.layoutIfNeeded()
    }

    
    private func configureCollectionView() {
        view.addSubview(RookProfileCollectionView)
        view.addSubview(navBar)
        
        RookProfileCollectionView.register(BasicInfoCell.self, forCellWithReuseIdentifier: basicInfoCellID)
        RookProfileCollectionView.register(StatsCell.self, forCellWithReuseIdentifier: statsCellID)
        RookProfileCollectionView.register(WalletCell.self, forCellWithReuseIdentifier: walletCellID)
        RookProfileCollectionView.register(PsychometricTestCell.self, forCellWithReuseIdentifier: psychometricTestCellID)
        RookProfileCollectionView.register(DemographicsCell.self, forCellWithReuseIdentifier: demopgraphicsCellID)
        RookProfileCollectionView.register(Education.self, forCellWithReuseIdentifier: educationCellID)
        RookProfileCollectionView.register(WorkExperience.self, forCellWithReuseIdentifier: workExperienceCellID)
        RookProfileCollectionView.register(SkillsCell.self, forCellWithReuseIdentifier: skillsCellID)
        RookProfileCollectionView.register(InterestsCell.self, forCellWithReuseIdentifier: interestsCellID)
        RookProfileCollectionView.register(AptitudeTestCell.self, forCellWithReuseIdentifier: aptitudeTestCellID)
        RookProfileCollectionView.register(Portfolio.self, forCellWithReuseIdentifier: portfolioCellID)
        
        RookProfileCollectionView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        RookProfileCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        RookProfileCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        topBlueBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topBlueBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        topBlueBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        topBlueBar.heightAnchor.constraint(equalToConstant: 165).isActive = true
        
        if #available(iOS 11.0, *) {
            navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        } else {
            navBar.topAnchor.constraint(equalTo: topLayoutGuide.topAnchor).isActive = true
        }
        navBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        navBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        var navBarHeight: CGFloat = 44.0
        if #available(iOS 12.0, *), self.sizeClass() == (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular) {
            navBarHeight = 50
        }
        navBar.heightAnchor.constraint(equalToConstant: navBarHeight).isActive = true
        navBar.alpha = 0.0
    }
    
    
}

extension ProfileViewController: ResizableCollectionViewDelegate {
    func resizeParent(with Size: CGSize, for collectionView: UICollectionView) {
        if (collectionView.tag == 5) {
            educationViewHeight = Size.height
        } else if (collectionView.tag == 6) {
            workExperienceViewHeight = Size.height
        } else {
            portfolioViewHeight = Size.height
        }
        RookProfileCollectionView.reloadData()
    }
}

extension ProfileViewController: UICollectionViewDelegate {}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.row {
        case 1:
            return CGSize(width: UIScreen.main.bounds.width-20, height: 185)
        case 2:
            return CGSize(width: UIScreen.main.bounds.width-20, height: 130)
        case 3:
            return CGSize(width: UIScreen.main.bounds.width-20, height: 143)
        case 4:
           return CGSize(width: UIScreen.main.bounds.width-20, height: 130)
        case 5:
            return CGSize(width: UIScreen.main.bounds.width-20, height: educationViewHeight)
        case 6:
            return CGSize(width: UIScreen.main.bounds.width-20, height: workExperienceViewHeight)
        case 7:
          return CGSize(width: UIScreen.main.bounds.width-20, height: 100)
        case 8:
            return CGSize(width: UIScreen.main.bounds.width-20, height: 100)
        case 9:
            return CGSize(width: UIScreen.main.bounds.width-20, height: 140)
        case 10:
            return CGSize(width: UIScreen.main.bounds.width-20, height: portfolioViewHeight)
        default:
           return CGSize(width: UIScreen.main.bounds.width, height: 100)
        }
    }
}

extension ProfileViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let collectionBounds = RookProfileCollectionView.bounds
        let topBlueBarFrame = self.topBlueBar.frame
        self.topBlueBar.frame = CGRect(x: collectionBounds.origin.x, y: -collectionBounds.origin.y-44, width: topBlueBarFrame.width, height: topBlueBarFrame.height)
        let min: CGFloat = -20.0
        let offset = (scrollView.contentOffset.y - min)/((min+20) - min)
        navBar.alpha = offset
    }
}

extension ProfileViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 11
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 1:
            let statsCell: StatsCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.statsCellID, for: indexPath) as! StatsCell
            statsCell.completed = 5
            statsCell.tasks = 100
            let badges: [String] = ["come","come","come","come"]
            statsCell.badges = badges
            return statsCell
        case 2:
            let walletCell: WalletCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.walletCellID, for: indexPath) as! WalletCell
            walletCell.balance = 2000
            walletCell.earnings = 6000
            return walletCell
        case 3:
            let psychometricTestCell: PsychometricTestCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.psychometricTestCellID, for: indexPath) as! PsychometricTestCell
            return psychometricTestCell
        case 4:
            let demographicsCell: DemographicsCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.demopgraphicsCellID, for: indexPath) as! DemographicsCell
            demographicsCell.gender = "Male"
            demographicsCell.age = "22"
            demographicsCell.nationality = "Ghana"
            demographicsCell.employmentStatus = "Student"
            demographicsCell.city = "Accra"
            demographicsCell.maritalStatus = "Single"
            return demographicsCell
        case 5:
            let educationCell: Education = collectionView.dequeueReusableCell(withReuseIdentifier: self.educationCellID, for: indexPath) as! Education
            educationCell.delegate = self
            return educationCell
        case 6:
            let workExperienceCell: WorkExperience = collectionView.dequeueReusableCell(withReuseIdentifier: self.workExperienceCellID, for: indexPath) as! WorkExperience
            workExperienceCell.delegate = self
            return workExperienceCell
        case 7:
            let skillsCell: SkillsCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.skillsCellID, for: indexPath) as! SkillsCell
            return skillsCell
        case 8:
            let interestsCell: InterestsCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.interestsCellID, for: indexPath) as! InterestsCell
            return interestsCell
        case 9:
            let aptitudeTestCell: AptitudeTestCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.aptitudeTestCellID, for: indexPath) as! AptitudeTestCell
            aptitudeTestCell.averageScore = 95
            aptitudeTestCell.highestScore = 100
            aptitudeTestCell.percentile = 75
            aptitudeTestCell.testsTaken = 5
            return aptitudeTestCell
        case 10:
            let portfolioCell: Portfolio = collectionView.dequeueReusableCell(withReuseIdentifier: self.portfolioCellID, for: indexPath) as! Portfolio
            portfolioCell.delegate = self
            return portfolioCell
        default:
            let basicInfoCell: BasicInfoCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.basicInfoCellID, for: indexPath) as! BasicInfoCell
            basicInfoCell.fullName = "Delmwin Baeka"
            basicInfoCell.points = 2000
            basicInfoCell.subscriptionLevel = "gold"
          //  basicInfoCell.delegate = self
            return basicInfoCell
        }
    }
}



