//
//  DatePickerViewController.swift
//  NBIBottomSheet_Example
//
//  Created by Bichon, Nicolas on 2018-10-02.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {

    // MARK: - Properties

    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker(frame: .zero)
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "en_GH")
        datePicker.maximumDate = Date(timeInterval: TimeInterval(-410227443), since: Date())
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.accessibilityIdentifier = "DatePickerBottomSheet"
        return datePicker
    }()
    
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

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupDatePicker()
    }
    
    init(startDate: Date){
        self.datePicker.date = startDate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func setupDatePicker() {
        view.addSubview(datePicker)
        view.addSubview(doneButton)
        self.doneButton.addTarget(self, action: #selector(dateUpdated(_:)), for: .touchUpInside)

        let heightConstraint = datePicker.heightAnchor.constraint(equalToConstant: 218)
        heightConstraint.priority = UILayoutPriority.defaultHigh

        NSLayoutConstraint.activate([
            doneButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            doneButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            doneButton.heightAnchor.constraint(equalToConstant: 18)
        ])
        
        NSLayoutConstraint.activate([
            heightConstraint,
            datePicker.topAnchor.constraint(equalTo: doneButton.bottomAnchor, constant: 5),
            datePicker.leftAnchor.constraint(equalTo: view.leftAnchor),
            datePicker.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])

        if #available(iOS 11, *) {
            let guide = view.safeAreaLayoutGuide
            NSLayoutConstraint.activate([
                datePicker.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -10.0)
            ])
        } else {
            NSLayoutConstraint.activate([
                datePicker.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10.0)
            ])
        }
    }
    
    @objc private func dateUpdated(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("dateChosen"), object: nil, userInfo: ["date": self.datePicker.date])
    }
}
