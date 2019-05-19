//
//  PortfolioCell.swift
//  RookPlus
//
//  Created by Delmwin Baeka on 3/2/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

class PortfolioCell: UICollectionViewCell {
    
    var projectTitle: String? {
        didSet {
            self.projectTitleLabel.text = projectTitle
        }
    }
    
    var projectDescription: String? {
        didSet {
            self.descriptionLabel.text = projectDescription
        }
    }
    
    var duration: String? {
        didSet {
            self.durationLabel.text = duration
        }
    }
    
    private let projectTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Medium", size: 12)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "#5F5F5F")
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Medium", size: 11)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let durationLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Regular", size: 11)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let exampleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private func configureViews() {
        backgroundColor = .white
        
        addSubview(projectTitleLabel)
        addSubview(descriptionLabel)
        addSubview(durationLabel)
        addSubview(exampleView)
    }
    
    private func setupConstraints() {
        self.projectTitleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        self.projectTitleLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 50).isActive = true
        self.projectTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        self.descriptionLabel.leftAnchor.constraint(equalTo: projectTitleLabel.leftAnchor).isActive = true
        self.projectTitleLabel.rightAnchor.constraint(equalTo: projectTitleLabel.rightAnchor).isActive = true
        self.descriptionLabel.topAnchor.constraint(equalTo: projectTitleLabel.bottomAnchor, constant: 1).isActive = true
        
        self.durationLabel.leftAnchor.constraint(equalTo: projectTitleLabel.leftAnchor).isActive = true
        self.durationLabel.rightAnchor.constraint(equalTo: projectTitleLabel.rightAnchor).isActive = true
        self.durationLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 1).isActive = true
        
        self.exampleView.leftAnchor.constraint(equalTo: projectTitleLabel.leftAnchor).isActive = true
        self.exampleView.rightAnchor.constraint(equalTo: projectTitleLabel.rightAnchor).isActive = true
        self.exampleView.topAnchor.constraint(equalTo: durationLabel.bottomAnchor, constant: 1).isActive = true
        self.exampleView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureViews()
        self.setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
