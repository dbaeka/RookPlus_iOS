//
//  SectionFooterView.swift
//  Rook+
//
//  Created by Delmwin Baeka on 2/14/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

class SectionFooterView: UICollectionReusableView {
    
    //MARK:- Properties
    private let lineView : UIView = UIView()
    
    //MARK:- Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureViews()
        self.setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SectionFooterView {
    
    //MARK:- Setup Helper Functions
    private func configureViews() {
        addSubview(lineView)
        
        backgroundColor = .white
        
        lineView.backgroundColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
        lineView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        self.lineView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        self.lineView.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        self.lineView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        self.lineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
}
