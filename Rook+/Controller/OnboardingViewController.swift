//
//  ViewController.swift
//  Rook+
//
//  Created by Delmwin Baeka on 1/21/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

protocol OnboardView {
    var controllerColor: UIColor { get set }
    var circleColor: UIColor {get set }
    var pageNumber: Int { get set }
}

class OnboardingViewController: UIViewController {
    
    //MARK: - Properties
    private let scrollViewController: ScrollViewController = {
        let controller = ScrollViewController()
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        controller.scrollView.bounces = true
        return controller
    }()
    
    private let colorView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let backCircle: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#DC4900")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let circle: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let beginButton: RookOutlineButton = {
        let button = RookOutlineButton()
        button.isPressed = false
        button.title = "NEXT"
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let controlCircles: UIPageControl = {
        let control = UIPageControl()
        control.numberOfPages = 3
        control.currentPage = 0
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    private let barrook: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "RookBar.png")
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var CVOnboardViewController: CVOnboardViewController! = {
        return self.storyboard?.instantiateViewController(withIdentifier: "CVOnboardViewController") as! CVOnboardViewController
    }()
    
    lazy var ExperienceOnboardViewController: ExperienceOnboardViewController! = {
        return self.storyboard?.instantiateViewController(withIdentifier: "ExperienceOnboardViewController") as! ExperienceOnboardViewController
    }()
    
    lazy var JobReadyOnboardViewController: JobReadyOnboardViewController! = {
        return self.storyboard?.instantiateViewController(withIdentifier: "JobReadyOnboardViewController") as! JobReadyOnboardViewController
    }()
    
    // MARK: - IBActions
    @objc func handleNext(_ sender: Any) {
        if scrollViewController.isControllerVisible(CVOnboardViewController) {
            scrollViewController.setController(to: ExperienceOnboardViewController, animated: true)
        } else if scrollViewController.isControllerVisible(ExperienceOnboardViewController) {
             scrollViewController.setController(to: JobReadyOnboardViewController, animated: true)
        } else if scrollViewController.isControllerVisible(JobReadyOnboardViewController){
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
             self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        view.backgroundColor = UIColor(hexString: "#FF5500")
        view.addSubview(colorView)
        view.addSubview(backCircle)
        view.addSubview(circle)
        
        addChild(self.scrollViewController)
        view.addSubview(scrollViewController.view)
        scrollViewController.viewControllers = [CVOnboardViewController, ExperienceOnboardViewController, JobReadyOnboardViewController]
        scrollViewController.delegate = self
        
        view.addSubview(beginButton)
        beginButton.addTarget(self, action: #selector(handleNext(_:)), for: .touchUpInside)
        
        view.addSubview(controlCircles)
        view.addSubview(barrook)
        
        configureConstraints()
    }
    
    private func configureConstraints() {
        self.colorView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.colorView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.colorView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        self.colorView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        self.controlCircles.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.controlCircles.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        self.controlCircles.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        self.controlCircles.topAnchor.constraint(equalTo: view.topAnchor, constant: UIScreen.main.bounds.height/18).isActive = true
        self.controlCircles.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        let width = (self.sizeClass() == (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) ? UIScreen.main.bounds.width/2 : UIScreen.main.bounds.width
        self.backCircle.topAnchor.constraint(equalTo: self.controlCircles.bottomAnchor, constant: UIScreen.main.bounds.height/38).isActive = true
        self.backCircle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.backCircle.widthAnchor.constraint(equalToConstant: width*1.1).isActive = true
        self.backCircle.heightAnchor.constraint(equalToConstant: width*1.1).isActive = true
        self.backCircle.layer.cornerRadius = (1.1*width)/2
        
        self.circle.centerXAnchor.constraint(equalTo: backCircle.centerXAnchor).isActive = true
        self.circle.centerYAnchor.constraint(equalTo: backCircle.centerYAnchor).isActive = true
        self.circle.widthAnchor.constraint(equalToConstant: width*1.1).isActive = true
        self.circle.heightAnchor.constraint(equalToConstant: width*1.1).isActive = true
        self.circle.layer.cornerRadius = (1.1*width)/2
        
        self.scrollViewController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.scrollViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.scrollViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        self.scrollViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        self.barrook.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        self.barrook.topAnchor.constraint(equalTo: circle.bottomAnchor, constant: UIScreen.main.bounds.height/38).isActive = true
        let aspect = (barrook.image?.size.width)!/(barrook.image?.size.height)!
        self.barrook.widthAnchor.constraint(equalToConstant: width/3.3).isActive = true
        self.barrook.heightAnchor.constraint(equalToConstant: (width/3.3)/aspect).isActive = true

        let screenRatio = UIScreen.main.bounds.height/UIScreen.main.bounds.width
        let bottomButtonDistance = (screenRatio < 2.0 && self.sizeClass() != (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular)) ? -10 : -UIScreen.main.bounds.height/15
        self.beginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottomButtonDistance).isActive = true
        self.beginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.beginButton.widthAnchor.constraint(equalToConstant: width/3.3).isActive = true
        self.beginButton.heightAnchor.constraint(equalToConstant: width/8.25).isActive = true
        
        for i in 0..<2 {
            let lineView = UIView()
            lineView.translatesAutoresizingMaskIntoConstraints = false
            lineView.backgroundColor = UIColor.white
            self.view.addSubview(lineView)
            lineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
            lineView.centerYAnchor.constraint(equalTo: beginButton.centerYAnchor).isActive = true
            if (i == 0) {
                lineView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
                lineView.rightAnchor.constraint(equalTo: beginButton.leftAnchor, constant: 5).isActive = true
            } else {
                lineView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
                lineView.leftAnchor.constraint(equalTo: beginButton.rightAnchor, constant: -5).isActive = true
            }
        }
    }
}

// MARK: ScrollViewControllerDelegate
extension OnboardingViewController: ScrollViewControllerDelegate {
    var viewControllers: [UIViewController?] {
        return [CVOnboardViewController, ExperienceOnboardViewController, JobReadyOnboardViewController]
    }
    
    var initialViewController: UIViewController {
        if scrollViewController.isControllerVisible(CVOnboardViewController) {
            colorView.backgroundColor = CVOnboardViewController.controllerColor
            circle.backgroundColor = CVOnboardViewController.circleColor
            controlCircles.currentPage = CVOnboardViewController.pageNumber
            controlCircles.hidesForSinglePage = true
            controlCircles.numberOfPages = viewControllers.count
        }
        return CVOnboardViewController
    }
    
    func scrollViewDidScroll() {
        
        //calculate percentage for animation
        let min: CGFloat = 0
        let max: CGFloat = scrollViewController.pageSize.width
        let x = scrollViewController.scrollView.contentOffset.x
        let result = ((x - min) / (max - min)) - 1 // Normalize value between 0 and 2
        
        //check controller that is visible and animate specific parts in the previous controller
        
        var controller: UIViewController?
    
        if scrollViewController.isControllerVisible(CVOnboardViewController) {
            controller = CVOnboardViewController
        } else if scrollViewController.isControllerVisible(ExperienceOnboardViewController) {
            controller = ExperienceOnboardViewController
        } else if scrollViewController.isControllerVisible(JobReadyOnboardViewController){
            controller = JobReadyOnboardViewController
        }
       animate(controller: controller, percent: result)
    }
    
    

}

fileprivate extension OnboardingViewController {
    func animate(controller: UIViewController?, percent: CGFloat){
        let offset = abs(percent)
        if let controller = controller as? OnboardView {
            colorView.backgroundColor = controller.controllerColor
            circle.backgroundColor = controller.circleColor
            controlCircles.currentPage = controller.pageNumber
        }
        
        var colorOffset = (offset - 0.2) / (0.8 - 0.2)
        colorOffset = min(max(colorOffset,0),1)
        colorView.alpha = colorOffset
        circle.alpha = colorOffset
    }
}
