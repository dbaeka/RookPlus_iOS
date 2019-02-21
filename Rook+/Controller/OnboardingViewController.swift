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
    var scrollViewController: ScrollViewController!
    
    lazy var CVOnboardViewController: CVOnboardViewController! = {
        return self.storyboard?.instantiateViewController(withIdentifier: "CVOnboardViewController") as! CVOnboardViewController
    }()
    
    lazy var ExperienceOnboardViewController: ExperienceOnboardViewController! = {
        return self.storyboard?.instantiateViewController(withIdentifier: "ExperienceOnboardViewController") as! ExperienceOnboardViewController
    }()
    
    lazy var JobReadyOnboardViewController: JobReadyOnboardViewController! = {
        return self.storyboard?.instantiateViewController(withIdentifier: "JobReadyOnboardViewController") as! JobReadyOnboardViewController
    }()
    
    // MARK: - IBOutlets
    @IBOutlet var colorView: UIView!
    @IBOutlet var circle: circleShape!
    @IBOutlet var controlCircles: UIPageControl!
    
    // MARK: - IBActions
    @IBAction func handleNext(_ sender: Any) {
        if scrollViewController.isControllerVisible(CVOnboardViewController) {
            scrollViewController.setController(to: ExperienceOnboardViewController, animated: true)
        } else if scrollViewController.isControllerVisible(ExperienceOnboardViewController) {
             scrollViewController.setController(to: JobReadyOnboardViewController, animated: true)
        } else if scrollViewController.isControllerVisible(JobReadyOnboardViewController){
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
             self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollViewController.scrollView.bounces = true
        
    }
    
   
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? ScrollViewController {
            scrollViewController = controller
            scrollViewController.delegate = self
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
            circle.color = CVOnboardViewController.circleColor
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
            circle.color = controller.circleColor
            controlCircles.currentPage = controller.pageNumber
        }
        
        var colorOffset = (offset - 0.2) / (0.8 - 0.2)
        colorOffset = min(max(colorOffset,0),1)
        colorView.alpha = colorOffset
        circle.alpha = colorOffset
    }
}
