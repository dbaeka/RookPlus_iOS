//
//  StatsCell.swift
//  RookPlus
//
//  Created by Delmwin Baeka on 3/2/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

class StatsCell: UICollectionViewCell {
    
    var tasks: Int = 0 {
        didSet {
            self.numberOfTasksLabel.text = "0"
            if tasks != 0 {
                if tasks < 1000 {
                    self.numberOfTasksLabel.text = String(tasks)
                } else if tasks < 1000000 {
                    self.numberOfTasksLabel.text = String(tasks/1000) + "k"
                } else if tasks < 1000000000 {
                    self.numberOfTasksLabel.text = String(tasks/1000000) + "m"
                }
            }
        }
    }
    
    var completed: Int = 0 {
        didSet {
            self.numberOfCompletedLabel.text = "0"
            if completed != 0 {
                if tasks < 1000 {
                    self.numberOfCompletedLabel.text = String(completed)
                } else if completed < 1000000 {
                    self.numberOfCompletedLabel.text = String(completed/1000) + "k"
                } else if completed < 1000000000 {
                    self.numberOfCompletedLabel.text = String(completed/1000000) + "m"
                }
            }
        }
    }
    
    var successRate: CGFloat = 0 {
        didSet {
            
        }
    }
    
    var speed: CGFloat = 0 {
        didSet {
            
        }
    }
    
    var badges: [StatsItem.Badge]? {
        didSet {
            guard let badges = badges else {return}
            self.numberOfBadgesLabel.text = String(badges.count)
        }
    }
    
    private let headerImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "Stats.png")
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let successRateView : UIView = {
        let view = RookProgressBar()
        view.gaugeColor = UIColor.black
        view.tubeColor = UIColor.lightGray
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let speedRateView : RookProgressBar = {
        let view = RookProgressBar()
        view.gaugeColor = UIColor.black
        view.tubeColor = UIColor.lightGray
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
//    private let badgesIconView : UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor.red
//        view.clipsToBounds = true
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    
    private let headingLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "Stats"
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Medium", size: 13)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tasksLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "Tasks"
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Regular", size: 14)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let completedLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "Completed"
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Regular", size: 14)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let badgesLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "Badges"
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Regular", size: 14)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let successRateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "Success Rate"
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Regular", size: 11)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let speedRateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "Speed"
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Regular", size: 11)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let numberOfBadgesLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Regular", size: 28)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let numberOfCompletedLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Regular", size: 28)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let numberOfTasksLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Regular", size: 28)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var badgesIconView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        collectionView.isScrollEnabled = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private var bubblePictures: BubblePictures!
    
    private func configureViews() {
        backgroundColor = UIColor.white
        
        addSubview(headerImageView)
        addSubview(successRateView)
        addSubview(speedRateView)
        addSubview(headingLabel)
        addSubview(badgesIconView)
        addSubview(tasksLabel)
        addSubview(completedLabel)
        addSubview(badgesLabel)
        addSubview(successRateLabel)
        addSubview(speedRateLabel)
        addSubview(numberOfBadgesLabel)
        addSubview(numberOfTasksLabel)
        addSubview(numberOfCompletedLabel)
    }
    
    private func setupConstraints() {
        widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 20).isActive = true
        self.layoutIfNeeded()
        layer.borderWidth = 0.2
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        self.headerImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        self.headerImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        self.headerImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        self.headerImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.headingLabel.leftAnchor.constraint(equalTo: headerImageView.rightAnchor, constant: 5).isActive = true
        self.headingLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
        self.headingLabel.centerYAnchor.constraint(equalTo: headerImageView.centerYAnchor).isActive = true
        self.headingLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
        self.numberOfTasksLabel.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 15).isActive = true
        self.numberOfTasksLabel.leftAnchor.constraint(equalTo: headingLabel.leftAnchor, constant: -10).isActive = true
        self.numberOfTasksLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.numberOfCompletedLabel.centerYAnchor.constraint(equalTo: numberOfTasksLabel.centerYAnchor).isActive = true
        self.numberOfCompletedLabel.centerXAnchor.constraint(equalTo: completedLabel.centerXAnchor).isActive = true
        self.numberOfCompletedLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.tasksLabel.centerXAnchor.constraint(equalTo: numberOfTasksLabel.centerXAnchor).isActive = true
        self.tasksLabel.topAnchor.constraint(equalTo: numberOfTasksLabel.bottomAnchor, constant: 5).isActive = true
        self.tasksLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        self.completedLabel.leftAnchor.constraint(equalTo: tasksLabel.rightAnchor, constant: 20).isActive = true
        self.completedLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        self.completedLabel.centerYAnchor.constraint(equalTo: tasksLabel.centerYAnchor).isActive = true
        
        self.numberOfBadgesLabel.topAnchor.constraint(equalTo: tasksLabel.bottomAnchor, constant: 35).isActive = true
        self.numberOfBadgesLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.numberOfBadgesLabel.centerXAnchor.constraint(equalTo: tasksLabel.centerXAnchor).isActive = true
        
        self.badgesLabel.centerXAnchor.constraint(equalTo: numberOfBadgesLabel.centerXAnchor).isActive = true
        self.badgesLabel.topAnchor.constraint(equalTo: numberOfBadgesLabel.bottomAnchor, constant: 5).isActive = true
        self.badgesLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        self.badgesIconView.leftAnchor.constraint(equalTo: badgesLabel.rightAnchor, constant: 5).isActive = true
        self.badgesIconView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        self.badgesIconView.topAnchor.constraint(equalTo: numberOfBadgesLabel.topAnchor).isActive = true
        self.badgesIconView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.successRateLabel.topAnchor.constraint(equalTo: numberOfCompletedLabel.topAnchor).isActive = true
        self.successRateLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        self.successRateLabel.leftAnchor.constraint(equalTo: centerXAnchor, constant: 20).isActive = true
        
        self.successRateView.topAnchor.constraint(equalTo: successRateLabel.bottomAnchor, constant: 3).isActive = true
        self.successRateView.leftAnchor.constraint(equalTo: successRateLabel.leftAnchor).isActive = true
        self.successRateView.rightAnchor.constraint(equalTo: successRateLabel.rightAnchor).isActive = true
        self.successRateView.heightAnchor.constraint(equalToConstant: 6).isActive = true
        
        self.speedRateLabel.topAnchor.constraint(equalTo: successRateView.bottomAnchor, constant: 8).isActive = true
        self.speedRateLabel.leftAnchor.constraint(equalTo: successRateLabel.leftAnchor).isActive = true
        self.speedRateLabel.rightAnchor.constraint(equalTo: successRateLabel.rightAnchor).isActive = true
        
        self.speedRateView.topAnchor.constraint(equalTo: speedRateLabel.bottomAnchor, constant: 3).isActive = true
        self.speedRateView.leftAnchor.constraint(equalTo: speedRateLabel.leftAnchor).isActive = true
        self.speedRateView.rightAnchor.constraint(equalTo: speedRateLabel.rightAnchor).isActive = true
        self.speedRateView.heightAnchor.constraint(equalToConstant: 6).isActive = true
    }
    
    private func setupBadges(){
        self.badgesIconView.layoutIfNeeded()
        let configFiles = getConfigFiles()
        let layoutConfigurator = BPLayoutConfigurator(
            backgroundColorForTruncatedBubble: UIColor.lightGray,
            fontForBubbleTitles: UIFont(name: "Roboto-Regular", size: 16.0)!,
            colorForBubbleBorders: UIColor.black,
            colorForBubbleTitles: UIColor.black,
            maxCharactersForBubbleTitles: 2,
           // maxNumberOfBubbles: 4,
            distanceInterBubbles: 0.2,
            direction: .leftToRight,
            alignment: .left)
        
        bubblePictures = BubblePictures(collectionView: badgesIconView, configFiles: configFiles, layoutConfigurator: layoutConfigurator , width: 240)
        bubblePictures.delegate = self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureViews()
        self.setupConstraints()
        self.setupBadges()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func getConfigFiles() -> [BPCellConfigFile] {
        let _badges = RookUser.shared.user.stats?.badges
        guard let badges = _badges else { return [] }
        var badgeItems: [BPCellConfigFile] = []
        for badge in badges {
            badgeItems.append(BPCellConfigFile(imageType: BPImageType.URL(URL(string: badge.image)!), title: badge.name))
        }
        return badgeItems
    }
}

extension StatsCell: BPDelegate {
    func didSelectBubble(at index: Int) {
        print(index)
    }
    
    func didSelectTruncatedBubble() {
        print("more!")
    }
    
    
}
