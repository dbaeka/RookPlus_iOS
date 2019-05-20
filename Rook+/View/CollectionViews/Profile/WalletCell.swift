//
//  WalletCell.swift
//  RookPlus
//
//  Created by Delmwin Baeka on 3/2/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

class WalletCell: UICollectionViewCell {
    
    var earnings: Int = 0 {
        didSet {
            self.earningsPriceLabel.text = "GH￠"+String(earnings)
        }
    }
    
    var balance: Int = 0 {
        didSet {
            self.balancePriceLabel.text = "GH￠"+String(balance)
        }
    }
    
    private let headerImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "Wallet.png")
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let totalEarningsButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Transactions.png"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let withdrawButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Withdraw.png"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let headingLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "Wallet"
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Medium", size: 13)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let totalEarningsLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "Total Earnings"
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Medium", size: 12)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let withdrawLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "Withdraw"
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Medium", size: 12)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let earningsPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "#8F8F8F")
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Medium", size: 10)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let balancePriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "#8F8F8F")
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Medium", size: 10)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let balanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "#8F8F8F")
        label.text = "Balance:"
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Medium", size: 10)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func configureViews() {
        backgroundColor = UIColor.white
        
        addSubview(headerImageView)
        addSubview(totalEarningsButton)
        addSubview(withdrawButton)
        addSubview(headingLabel)
        addSubview(totalEarningsLabel)
        addSubview(withdrawLabel)
        addSubview(balanceLabel)
        addSubview(earningsPriceLabel)
        addSubview(balancePriceLabel)
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
        
        self.totalEarningsButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -frame.width/4).isActive = true
        self.totalEarningsButton.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 10).isActive = true
        self.totalEarningsButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        self.totalEarningsButton.widthAnchor.constraint(equalToConstant: 43).isActive = true
        
        self.withdrawButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: frame.width/4).isActive = true
        self.withdrawButton.centerYAnchor.constraint(equalTo: totalEarningsButton.centerYAnchor).isActive = true
        self.withdrawButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        self.withdrawButton.widthAnchor.constraint(equalToConstant: 43).isActive = true
        
        self.totalEarningsLabel.topAnchor.constraint(equalTo: totalEarningsButton.bottomAnchor, constant: 5).isActive = true
        self.totalEarningsLabel.centerXAnchor.constraint(equalTo: totalEarningsButton.centerXAnchor).isActive = true
        self.totalEarningsLabel.heightAnchor.constraint(equalToConstant: 13).isActive = true
        
        self.withdrawLabel.topAnchor.constraint(equalTo: withdrawButton.bottomAnchor, constant: 5).isActive = true
        self.withdrawLabel.centerXAnchor.constraint(equalTo: withdrawButton.centerXAnchor).isActive = true
        self.withdrawLabel.heightAnchor.constraint(equalToConstant: 13).isActive = true
        
        self.earningsPriceLabel.topAnchor.constraint(equalTo: totalEarningsLabel.bottomAnchor, constant: 2).isActive = true
        self.earningsPriceLabel.centerXAnchor.constraint(equalTo: totalEarningsLabel.centerXAnchor).isActive = true
        self.earningsPriceLabel.heightAnchor.constraint(equalToConstant: 11).isActive = true
        
        self.balanceLabel.topAnchor.constraint(equalTo: withdrawLabel.bottomAnchor, constant: 2).isActive = true
        self.balanceLabel.centerXAnchor.constraint(equalTo: withdrawLabel.centerXAnchor).isActive = true
        self.balanceLabel.heightAnchor.constraint(equalToConstant: 11).isActive = true
        
        self.balancePriceLabel.topAnchor.constraint(equalTo: balanceLabel.bottomAnchor, constant: 2).isActive = true
        self.balancePriceLabel.centerXAnchor.constraint(equalTo: balanceLabel.centerXAnchor).isActive = true
        self.balancePriceLabel.heightAnchor.constraint(equalToConstant: 11).isActive = true
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
