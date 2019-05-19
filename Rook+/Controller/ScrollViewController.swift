//
//  ScrollViewController.swift
//  Rook+
//
//  Created by Delmwin Baeka on 1/25/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit


protocol ScrollViewControllerDelegate {
    var viewControllers: [UIViewController?] { get }
    var initialViewController: UIViewController { get }
    func scrollViewDidScroll()
}

extension ScrollViewControllerDelegate {
    func scrollViewDidScroll() { }
}

class ScrollViewController: UIViewController {
    
    public enum ScrollViewDirection {
        case horizontal, vertical
    }
    
    // MARK: - Properties
    var scrollView: UIScrollView {
        return view as! UIScrollView
    }
    
    var direction: ScrollViewDirection = .horizontal
    
    var pageSize: CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
    var viewControllers: [UIViewController?]!
    var delegate: ScrollViewControllerDelegate?
    
    // MARK: - View Life Cycle
    override func loadView() {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: pageSize.width, height: pageSize.height))
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        
        view = scrollView
        view.backgroundColor = .clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewControllers = delegate?.viewControllers
        
        //add VCs to array as children
        for (index, controller) in viewControllers.enumerated() {
            if let controller = controller {
                addChild(controller)
                controller.view.frame = frame(for: index)
                scrollView.addSubview(controller.view)
                controller.didMove(toParent: self)
            }
        }
        switch direction {
        case .horizontal:
            scrollView.contentSize = CGSize(width: pageSize.width * CGFloat(viewControllers.count), height: pageSize.height)
        case .vertical:
            scrollView.contentSize = CGSize(width: pageSize.width,  height: pageSize.height * CGFloat(viewControllers.count))
        }
        
        //set initial position of scroll view
        if let controller = delegate?.initialViewController {
            setController(to: controller, animated: false)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
       
    }
}


// MARK: - Private methods
fileprivate extension ScrollViewController {
    func frame(for index: Int) -> CGRect {
        switch direction {
        case .horizontal:
            return CGRect(x: CGFloat(index) * pageSize.width, y: 0, width: pageSize.width, height: pageSize.height)
        case .vertical:
            return CGRect(x: 0, y: CGFloat(index) * pageSize.height, width: pageSize.width, height: pageSize.height)
        }
    }
    
    func indexFor(controller: UIViewController?) -> Int? {
        return viewControllers.index(where: {$0 == controller})
    }
}

// MARK: - Public methods
extension ScrollViewController {
    public func setController(to controller: UIViewController, animated: Bool, speed: TimeInterval = 0.2) {
        guard let index = indexFor(controller: controller) else {
            return
        }
        var contentOffset = CGPoint.zero
        switch direction {
        case .horizontal:
            contentOffset = CGPoint(x: pageSize.width * CGFloat(index), y: 0)
        case .vertical:
            contentOffset = CGPoint(x: 0, y: pageSize.height * CGFloat(index))
        }
        
        if animated {
            UIView.animate(withDuration: speed, delay: 0, options: [UIView.AnimationOptions.curveEaseOut], animations: {
                self.scrollView.setContentOffset(contentOffset, animated: false)
                })
        } else {
            scrollView.setContentOffset(contentOffset, animated: animated)
        }
    }
    
    public func isControllerVisible(_ controller: UIViewController?) -> Bool {
        guard controller != nil else {
            return false
        }
        
        for i in 0..<viewControllers.count {
            if viewControllers[i] == controller {
                let controllerFrame = frame(for: i)
                return controllerFrame.intersects(scrollView.bounds)
            }
        }
        return false
    }
}

//MARK: - UISCrollViewDelegate
extension ScrollViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidScroll()
    }
}
