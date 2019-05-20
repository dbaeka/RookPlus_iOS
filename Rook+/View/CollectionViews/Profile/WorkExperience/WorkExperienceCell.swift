

import UIKit

class WorkExperienceCell: UICollectionViewCell {
    
    var workTitle: String? {
        didSet {
            self.workTitleLabel.text = workTitle
        }
    }
    
    var workplace: String? {
        didSet {
            self.workPlaceLabel.text = workplace
        }
    }
    
    var duration: String? {
        didSet {
            self.durationLabel.text = duration
        }
    }
    
    var location: String? {
        didSet {
            self.locationLabel.text = location
        }
    }
    
    private let workTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Medium", size: 12)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let workPlaceLabel: UILabel = {
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
    
    private let locationLabel: UILabel = {
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
        
        addSubview(workTitleLabel)
        addSubview(workPlaceLabel)
        addSubview(durationLabel)
        addSubview(locationLabel)
    }
    
    private func setupConstraints() {
        self.workTitleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        self.workTitleLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 50).isActive = true
        self.workTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        self.workPlaceLabel.leftAnchor.constraint(equalTo: workTitleLabel.leftAnchor).isActive = true
        self.workPlaceLabel.rightAnchor.constraint(equalTo: workTitleLabel.rightAnchor).isActive = true
        self.workPlaceLabel.topAnchor.constraint(equalTo: workTitleLabel.bottomAnchor, constant: 1).isActive = true
        
        self.durationLabel.leftAnchor.constraint(equalTo: workTitleLabel.leftAnchor).isActive = true
        self.durationLabel.rightAnchor.constraint(equalTo: workTitleLabel.rightAnchor).isActive = true
        self.durationLabel.topAnchor.constraint(equalTo: workPlaceLabel.bottomAnchor, constant: 1).isActive = true
        
        self.locationLabel.leftAnchor.constraint(equalTo: workTitleLabel.leftAnchor).isActive = true
        self.locationLabel.rightAnchor.constraint(equalTo: workTitleLabel.rightAnchor).isActive = true
        self.locationLabel.topAnchor.constraint(equalTo: durationLabel.bottomAnchor, constant: 1).isActive = true
        
        
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
