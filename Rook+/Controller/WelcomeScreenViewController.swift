//
//  WelcomeScreenViewController.swift
//  RookPlus
//
//  Created by Delmwin Baeka on 3/13/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

class WelcomeScreenViewController: UIViewController {
    
    //MARK: - Properties
    private let scrollViewController: ScrollViewController = {
        let controller = ScrollViewController()
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        controller.direction = .vertical
        controller.scrollView.isScrollEnabled = true
        controller.scrollView.isUserInteractionEnabled = false
        controller.scrollView.bounces = true
        return controller
    }()
    
    private let background: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "background")
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var WelcomeScreen1ViewController: WelcomeScreen1ViewController! = {
        return self.storyboard?.instantiateViewController(withIdentifier: "WelcomeScreen1ViewController") as! WelcomeScreen1ViewController
    }()
    
    lazy var WelcomeScreen2ViewController: WelcomeScreen2ViewController! = {
        return self.storyboard?.instantiateViewController(withIdentifier: "WelcomeScreen2ViewController") as! WelcomeScreen2ViewController
    }()
    
    lazy var WelcomeScreen3ViewController: WelcomeScreen3ViewController! = {
        return self.storyboard?.instantiateViewController(withIdentifier: "WelcomeScreen3ViewController") as! WelcomeScreen3ViewController
    }()
    
    lazy var WelcomeScreen4ViewController: WelcomeScreen4ViewController! = {
        return self.storyboard?.instantiateViewController(withIdentifier: "WelcomeScreen4ViewController") as! WelcomeScreen4ViewController
    }()
    
    lazy var WelcomeScreen5ViewController: WelcomeScreen5ViewController! = {
        return self.storyboard?.instantiateViewController(withIdentifier: "WelcomeScreen5ViewController") as! WelcomeScreen5ViewController
    }()
        
    private var startTouch: CGFloat?
    private var isUp: Bool?
    
    // MARK: - IBActions
    func handleNext() {
        for (index, vc) in viewControllers.enumerated() {
            if scrollViewController.isControllerVisible(vc), index < viewControllers.count  {
                if (index == 0) {
                    self.background.image = UIImage(named: "background2")
                }
                if index < 4 {
                    scrollViewController.setController(to: viewControllers[index+1]!, animated: true, speed: 0.5)
                    break
                } else {
                    guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "InterestsPageViewController") else {return}
                    self.present(vc, animated: true, completion: nil)
                }
            }
        }
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(background)
        
        addChild(self.scrollViewController)
        view.addSubview(scrollViewController.view)
        scrollViewController.viewControllers = [WelcomeScreen1ViewController, WelcomeScreen2ViewController, WelcomeScreen3ViewController, WelcomeScreen4ViewController, WelcomeScreen5ViewController]
        scrollViewController.delegate = self
              
        configureConstraints()
    }
    
    private func configureConstraints() {
        self.background.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.background.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        self.background.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        self.background.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        self.scrollViewController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.scrollViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.scrollViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        self.scrollViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    @objc func skipAction(_ sender: Any){
        for (index, vc) in viewControllers.enumerated() {
            if scrollViewController.isControllerVisible(vc), index < viewControllers.count {
                    scrollViewController.setController(to: viewControllers[index-1]!, animated: true)
            }
        }
    }
}

// MARK: ScrollViewControllerDelegate
extension WelcomeScreenViewController: ScrollViewControllerDelegate {
    
    var viewControllers: [UIViewController?] {
        return [WelcomeScreen1ViewController, WelcomeScreen2ViewController, WelcomeScreen3ViewController, WelcomeScreen4ViewController, WelcomeScreen5ViewController]
    }
    
    var initialViewController: UIViewController {
        return WelcomeScreen1ViewController
    }
}

extension WelcomeScreenViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let screenRatio = UIScreen.main.bounds.height/UIScreen.main.bounds.width
        let distanceToTop: CGFloat = (screenRatio < 2.0 && self.sizeClass() != (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) ? 60 : 70
        let distance: CGFloat = (screenRatio < 2.0 && self.sizeClass() != (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) ? -50 : -distanceToTop*1.2
        self.startTouch = touches.first?.location(in: self.view).y
        guard let startTouch = self.startTouch else { return }
        if startTouch < UIScreen.main.bounds.height + distance {
            self.startTouch = -1
            self.isUp = false
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let startTouch = self.startTouch else { return }
        if startTouch < CGFloat(0) {
            return
        }
        let nowTouch = touches.first?.location(in: self.view).y
        guard let now = nowTouch else { return }
        let diff = startTouch - now
        self.isUp = diff > UIScreen.main.bounds.height/20
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let isUp = self.isUp else { return }
        if isUp {
            self.handleNext()
        }
    }
}
