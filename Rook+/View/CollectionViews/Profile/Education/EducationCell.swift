//
//  EducationCell.swift
//  RookPlus
//
//  Created by Delmwin Baeka on 3/2/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

class EducationCell: UICollectionViewCell {
    
    var schoolName: String? {
        didSet {
            self.schoolNameLabel.text = schoolName
        }
    }
    
    var course: String? {
        didSet {
            self.courseNameLabel.text = course
        }
    }
    
    var completionYear: String? {
        didSet {
            guard let completionYear = completionYear else { return }
            self.completionLabel.text = "Completion: " + String(completionYear)
        }
    }
    
    var gradeLevel: String? {
        didSet {
            guard let gradeLevel = gradeLevel else {return}
            self.gradeLevelLabel.text = "Grade: " + gradeLevel
        }
    }
    
    var id: String?
    
    private let schoolNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Medium", size: 12)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let courseNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "#5F5F5F")
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Medium", size: 11)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let completionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Regular", size: 11)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let gradeLevelLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Regular", size: 11)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    private func configureViews() {
        backgroundColor = .white
        
        addSubview(schoolNameLabel)
        addSubview(courseNameLabel)
        addSubview(completionLabel)
        addSubview(gradeLevelLabel)
    }
    
    private func setupConstraints() {
        self.schoolNameLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        self.schoolNameLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 50).isActive = true
        self.schoolNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        self.courseNameLabel.leftAnchor.constraint(equalTo: schoolNameLabel.leftAnchor).isActive = true
        self.courseNameLabel.rightAnchor.constraint(equalTo: schoolNameLabel.rightAnchor).isActive = true
        self.courseNameLabel.topAnchor.constraint(equalTo: schoolNameLabel.bottomAnchor, constant: 1).isActive = true
        
        self.completionLabel.leftAnchor.constraint(equalTo: schoolNameLabel.leftAnchor).isActive = true
        self.completionLabel.rightAnchor.constraint(equalTo: schoolNameLabel.rightAnchor).isActive = true
        self.completionLabel.topAnchor.constraint(equalTo: courseNameLabel.bottomAnchor, constant: 1).isActive = true
        
        self.gradeLevelLabel.leftAnchor.constraint(equalTo: schoolNameLabel.leftAnchor).isActive = true
        self.gradeLevelLabel.rightAnchor.constraint(equalTo: schoolNameLabel.rightAnchor).isActive = true
        self.gradeLevelLabel.topAnchor.constraint(equalTo: completionLabel.bottomAnchor, constant: 1).isActive = true
        

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
