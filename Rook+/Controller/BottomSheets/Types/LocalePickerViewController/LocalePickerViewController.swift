import UIKit

public class LocalePickerViewController: UIViewController {
    
    // MARK: UI Metrics
    
    struct UI {
        static let rowHeight = CGFloat(50)
        static let separatorColor: UIColor = UIColor.lightGray.withAlphaComponent(0.4)
    }
    
    // MARK: Properties
    
  //  public typealias Selection = (LocaleInfo?) -> Swift.Void
    
    public enum Kind {
        case country
        case phoneCode
        case currency
    }
    
    fileprivate var type: Kind
//fileprivate var selection: Selection?
    
    fileprivate var orderedInfo = [String: [LocaleInfo]]()
    fileprivate var sortedInfoKeys = [String]()
    fileprivate var filteredInfo: [LocaleInfo] = []
    fileprivate var selectedInfo: LocaleInfo?
    
    //fileprivate var searchBarIsActive: Bool = false
    
    fileprivate lazy var searchView: UIView = UIView()
    
//    fileprivate lazy var searchController: UISearchController = { [unowned self] in
//        $0.searchResultsUpdater = self
//        $0.searchBar.delegate = self
//        $0.dimsBackgroundDuringPresentation = false
//        /// true if search bar in tableView header
//        $0.hidesNavigationBarDuringPresentation = true
//        $0.searchBar.searchBarStyle = .minimal
//        $0.searchBar.textField?.textColor = .black
//        $0.searchBar.textField?.clearButtonMode = .whileEditing
//        return $0
//    }(UISearchController(searchResultsController: nil))
    
    private let doneButton: UIButton = {
        let button = UIButton()
        let textAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont(name: "Roboto-Medium", size: 17), NSAttributedString.Key.foregroundColor: UIColor.black]
        let attributedString = NSMutableAttributedString(string: "Done", attributes: textAttributes)
        button.setAttributedTitle(attributedString, for: .normal)
        let textPressedAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont(name: "Roboto-Medium", size: 17), NSAttributedString.Key.foregroundColor: UIColor.gray]
        let attributePresseddString = NSMutableAttributedString(string: "Done", attributes: textPressedAttributes)
        button.setAttributedTitle(attributePresseddString, for: .highlighted)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate lazy var tableView: UITableView = { [unowned self] in
        $0.dataSource = self
        $0.delegate = self
        $0.rowHeight = UI.rowHeight
        $0.separatorColor = UI.separatorColor
        $0.bounces = true
        $0.backgroundColor = nil
        $0.tableFooterView = UIView()
        $0.sectionIndexBackgroundColor = .clear
        $0.sectionIndexTrackingBackgroundColor = .clear
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITableView(frame: .zero, style: .plain))
    
    fileprivate lazy var indicatorView: UIActivityIndicatorView = {
        $0.color = .lightGray
        return $0
    }(UIActivityIndicatorView(style: .whiteLarge))
    
    // MARK: Initialize
    
    required public init(type: Kind) {
        self.type = type
       // self.selection = selection
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    deinit {
//        // http://stackoverflow.com/questions/32675001/uisearchcontroller-warning-attempting-to-load-the-view-of-a-view-controller/
//        let _ = searchController.view
//    }
//
    override public func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.addSubview(indicatorView)
        view.addSubview(doneButton)
        self.doneButton.addTarget(self, action: #selector(doneAction(_:)), for: .touchUpInside)
        view.backgroundColor = .white
 //       view.addSubview(searchController.searchBar)

        
        //extendedLayoutIncludesOpaqueBars = true
        //edgesForExtendedLayout = .bottom
        definesPresentationContext = true
        
        setupConstraints()
        
        switch type {
        case .country:
            tableView.register(CountryTableViewCell.self, forCellReuseIdentifier: CountryTableViewCell.identifier)
        case .phoneCode:
            tableView.register(PhoneCodeTableViewCell.self, forCellReuseIdentifier: PhoneCodeTableViewCell.identifier)
        case .currency:
            tableView.register(CurrencyTableViewCell.self, forCellReuseIdentifier: CurrencyTableViewCell.identifier)
        }
        
        updateInfo()
    }
    
    private func setupConstraints() {
        let heightConstraint = self.tableView.heightAnchor.constraint(equalToConstant: 200)
        heightConstraint.priority = UILayoutPriority.defaultHigh
        
        NSLayoutConstraint.activate([
            doneButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            doneButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            doneButton.heightAnchor.constraint(equalToConstant: 18)
            ])
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: doneButton.topAnchor, constant: 10),
            self.tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            self.tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            heightConstraint
        ])
        
        if #available(iOS 11, *) {
            let guide = view.safeAreaLayoutGuide
            NSLayoutConstraint.activate([
                self.tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -10.0)
                ])
        } else {
            NSLayoutConstraint.activate([
                self.tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10.0)
                ])
        }
    }
    
    @objc private func doneAction(_ sender: Any) {
        guard let selectedInfo = self.selectedInfo else {
            NotificationCenter.default.post(name: NSNotification.Name("localeDoneChosen"), object: nil, userInfo: nil)
            return
        }
        NotificationCenter.default.post(name: NSNotification.Name("localeDoneChosen"), object: nil, userInfo: ["locale": selectedInfo])
    }
    
    
    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        indicatorView.center = view.center
        preferredContentSize.height = tableView.contentSize.height
    }
    
    func updateInfo() {
        indicatorView.startAnimating()
        
        LocaleStore.fetch { [unowned self] result in
            switch result {
                
            case .success(let orderedInfo):
                let data: [String: [LocaleInfo]] = orderedInfo
                /*
                 switch self.type {
                 case .currency:
                 data = data.filter { i in
                 guard let code = i.currencyCode else { return false }
                 return Locale.commonISOCurrencyCodes.contains(code)
                 }.sorted { $0.currencyCode < $1.currencyCode }
                 default: break }
                 */
                
                self.orderedInfo = data
                self.sortedInfoKeys = Array(self.orderedInfo.keys).sorted(by: <)
                
                DispatchQueue.main.async {
                    self.indicatorView.stopAnimating()
                    self.tableView.reloadData()
                }
                
            case .error(let error):
                
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: error.title, message: error.message, preferredStyle: .alert)
                    let button = UIAlertAction(title: "OK", style: .cancel) { action in
                        self.indicatorView.stopAnimating()
                        self.dismiss(animated: true, completion: nil)
                    }
                    alert.addAction(button)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    func sortFilteredInfo() {
        filteredInfo = filteredInfo.sorted { lhs, rhs in
            switch type {
            case .country:
                return lhs.country < rhs.country
            case .phoneCode:
                return lhs.country < rhs.country
            case .currency:
                return lhs.country < rhs.country
            }
        }
    }
    
    func info(at indexPath: IndexPath) -> LocaleInfo? {
//        if searchController.isActive {
//            return filteredInfo[indexPath.row]
//        }
        let key: String = sortedInfoKeys[indexPath.section]
        if let info = orderedInfo[key]?[indexPath.row] {
            return info
        }
        return nil
    }
    
    func indexPathOfSelectedInfo() -> IndexPath? {
        guard let selectedInfo = selectedInfo else { return nil }
//        if searchController.isActive {
//            for row in 0 ..< filteredInfo.count {
//                if filteredInfo[row].country == selectedInfo.country {
//                    return IndexPath(row: row, section: 0)
//                }
//            }
//        }
        for section in 0 ..< sortedInfoKeys.count {
            if let orderedInfo = orderedInfo[sortedInfoKeys[section]] {
                for row in 0 ..< orderedInfo.count {
                    if orderedInfo[row].country == selectedInfo.country {
                        return IndexPath(row: row, section: section)
                    }
                }
            }
        }
        return nil
    }
}

// MARK: - UISearchResultsUpdating

extension LocalePickerViewController: UISearchResultsUpdating {
    
    
    
    public func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, searchController.isActive {
            filteredInfo = []
            if searchText.count > 0, let values = orderedInfo[String(searchText[searchText.startIndex])] {
                filteredInfo.append(contentsOf: values.filter { $0.country.hasPrefix(searchText) })
            } else {
                orderedInfo.forEach { key, value in
                    filteredInfo += value
                }
            }
            sortFilteredInfo()
        }
        tableView.reloadData()
        
        guard let selectedIndexPath = indexPathOfSelectedInfo() else { return }
        tableView.selectRow(at: selectedIndexPath, animated: false, scrollPosition: .none)
    }
}

// MARK: - UISearchBarDelegate

//extension LocalePickerViewController: UISearchBarDelegate {
//
//    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.resignFirstResponder()
//    }
//}

// MARK: - TableViewDelegate

extension LocalePickerViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let info = info(at: indexPath) else { return }
        selectedInfo = info
       // selection?(selectedInfo)
    }
}

// MARK: - TableViewDataSource

extension LocalePickerViewController: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
    //    if searchController.isActive { return 1 }
        return sortedInfoKeys.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if searchController.isActive { return filteredInfo.count }
        if let infoForSection = orderedInfo[sortedInfoKeys[section]] {
            return infoForSection.count
        }
        return 0
    }
    
    public func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        //if searchController.isActive { return 0 }
        tableView.scrollToRow(at: IndexPath(row: 0, section: index), at: .top , animated: false)
        return sortedInfoKeys.index(of: title)!
    }
    
    public func sectionIndexTitles(for tableView: UITableView) -> [String]? {
     //   if searchController.isActive { return nil }
        return sortedInfoKeys
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
     //   if searchController.isActive { return nil }
        return sortedInfoKeys[section]
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let info = info(at: indexPath) else { return UITableViewCell() }
        
        let cell: UITableViewCell
        
        switch type {
            
        case .country:
            cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.identifier) as! CountryTableViewCell
            cell.textLabel?.text = info.country
            
        case .phoneCode:
            cell = tableView.dequeueReusableCell(withIdentifier: PhoneCodeTableViewCell.identifier) as! PhoneCodeTableViewCell
            cell.textLabel?.text = info.phoneCode
            cell.detailTextLabel?.text = info.country
            
        case .currency:
            cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.identifier) as! CurrencyTableViewCell
            cell.textLabel?.text = info.currencyCode
            cell.detailTextLabel?.text = info.country
        }
        
        cell.detailTextLabel?.textColor = .darkGray
        
        DispatchQueue.main.async {
            let size: CGSize = CGSize(width: 32, height: 24)
            let flag: UIImage? = info.flag?.imageWithSize(size: size, roundedRadius: 3)
            cell.imageView?.image = flag
            cell.setNeedsLayout()
            cell.layoutIfNeeded()
        }
        
        if let selected = selectedInfo, selected.country == info.country {
            cell.isSelected = true
        }
        
        return cell
    }
}
