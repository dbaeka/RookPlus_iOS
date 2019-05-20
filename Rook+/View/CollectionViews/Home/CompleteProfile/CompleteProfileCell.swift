//
//  CompleteProfileCell.swift
//  Rook+
//
//  Created by Delmwin Baeka on 2/14/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

class completeProfileCell: UICollectionViewCell {
    
    private var viewProfile: RookCompleteProfile!
    
    
    func configureViews() {
        self.layer.masksToBounds = true
        backgroundColor = .white
    }
    
    private func setupConstraints() {
        self.viewProfile.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        self.viewProfile.topAnchor.constraint(equalTo: topAnchor).isActive = true
        self.viewProfile.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        self.viewProfile.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        self.viewProfile.layoutIfNeeded()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureViews()
        let view = RookCompleteProfile(frame: bounds)
        self.viewProfile = view
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        self.setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
