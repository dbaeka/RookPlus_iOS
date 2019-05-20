//
//  SectionHeaderView.swift
//  Rook+
//
//  Created by Delmwin Baeka on 2/14/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

class SectionHeaderView: UICollectionReusableView {
    
    //MARK:- Properties
    var text: String? {
        didSet {
            headingLabel.text = text
        }
    }
    
    var buttonIsVisible: Bool = false {
        didSet{
            moreButton.isHidden = !buttonIsVisible
        }
    }
    
    private let moreButton: RookRoundButton = RookRoundButton()
    
    private let headingLabel: UILabel = UILabel()
    
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

private extension SectionHeaderView {
    
    //MARK:- Setup Helper Functions
    private func configureViews() {
        addSubview(headingLabel)
        addSubview(moreButton)
        
        backgroundColor = .white
        
        headingLabel.text =  self.text
        headingLabel.textColor = UIColor.black
        headingLabel.font = UIFont(name: "Roboto-Bold", size: 24)
        headingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        guard let font = UIFont(name: "Roboto-Regular", size: 13) else {return}
        let labelAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.white]
        let labelString = NSMutableAttributedString(string: "More", attributes: labelAttributes)
        moreButton.setAttributedTitle(labelString, for: .normal)
        moreButton.backgroundColor = UIColor(hexString: "#004AEF")
        moreButton.isShadowOn = false
        moreButton.isHidden = !self.buttonIsVisible
        moreButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        self.headingLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        self.headingLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        moreButton.centerYAnchor.constraint(equalTo: headingLabel.centerYAnchor).isActive = true
        moreButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        moreButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        moreButton.widthAnchor.constraint(equalToConstant: (self.moreButton.titleLabel?.intrinsicContentSize.width)! + 20).isActive = true
    }
}
