
import UIKit

class WorkExperience: UICollectionViewCell {
    
    var delegate: ResizableCollectionViewDelegate?
    
    private let headerImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "Employment.png")
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let headingLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "Work Experience"
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Medium", size: 13)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let updateButton : UIButton = {
        let button = UIButton()
        let textAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont(name: "Roboto-Medium", size: 10), NSAttributedString.Key.foregroundColor: UIColor(hexString: "#5F5F5F")]
        let attributedString = NSMutableAttributedString(string: "update >", attributes: textAttributes)
        button.setAttributedTitle(attributedString, for: .normal)
        let textPressedAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont(name: "Roboto-Medium", size: 10), NSAttributedString.Key.foregroundColor: UIColor(hexString: "#B8B8B8")]
        let attributePresseddString = NSMutableAttributedString(string: "uodate >", attributes: textPressedAttributes)
        button.setAttributedTitle(attributePresseddString, for: .highlighted)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let workExperienceCellID = "workExperienceCellID"
    
    lazy var workExperienceCollectionView: UICollectionView = {
        let flowLayout     = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing  = 5
        flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        flowLayout.minimumLineSpacing       = 3
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.tag = 6
        collectionView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        collectionView.alwaysBounceVertical = false
        collectionView.alwaysBounceHorizontal = false
        collectionView.allowsSelection = true
        collectionView.isScrollEnabled = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureCollectionView()
        
        workExperienceCollectionView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.old, context: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let observedObject = object as? UICollectionView, observedObject == self.workExperienceCollectionView {
            let size = self.workExperienceCollectionView.collectionViewLayout.collectionViewContentSize
            delegate?.resizeParent(with: CGSize(width: size.width, height: size.height+40), for: self.workExperienceCollectionView)
        }
    }
}

private extension WorkExperience {
    
    private func configureCollectionView() {
        addSubview(headingLabel)
        addSubview(workExperienceCollectionView)
        addSubview(headerImageView)
        addSubview(updateButton)
        
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
        
        self.updateButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -13).isActive = true
        self.updateButton.centerYAnchor.constraint(equalTo: headingLabel.centerYAnchor).isActive = true
        self.updateButton.heightAnchor.constraint(equalToConstant: 11).isActive = true
        
        workExperienceCollectionView.register(WorkExperienceCell.self, forCellWithReuseIdentifier: workExperienceCellID)
        workExperienceCollectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        workExperienceCollectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        workExperienceCollectionView.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 15).isActive = true
        workExperienceCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
    }
}

extension WorkExperience: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return RookUser.shared.user.experience?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let workExperienceCell: WorkExperienceCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.workExperienceCellID, for: indexPath) as! WorkExperienceCell
        let experienceItem = RookUser.shared.user.experience?[indexPath.row]
        workExperienceCell.workTitle = experienceItem?.title
        workExperienceCell.workplace = experienceItem?.name
        let startDate = experienceItem?.startDate.string2date(format: "yyyy-mm")?.date2string(format: "MMMMy")
        let endDate: String? = (experienceItem?.isCurrent ?? "0" == "1") ? "Present" : experienceItem?.endDate.string2date(format: "yyyy-mm")?.date2string(format: "MMMMy")
        if (startDate != nil && endDate != nil){
            workExperienceCell.duration = startDate! + "-" + endDate!
        } else if (startDate != nil){
            workExperienceCell.duration = startDate
        } else if (endDate != nil) {
            workExperienceCell.duration = endDate
        }
        workExperienceCell.location = experienceItem?.location
        return workExperienceCell
        
    }
}

extension WorkExperience: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 20, height: 60)
    }
}
