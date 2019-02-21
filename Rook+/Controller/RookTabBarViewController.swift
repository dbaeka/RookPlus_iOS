//
//  RookTabBarViewController.swift
//  Rook+
//
//  Created by Delmwin Baeka on 1/31/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

class RookTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.unselectedItemTintColor = UIColor.black
    }
}

//extension RookTabBarViewController: UIScrollViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
//            changeTabBar(hidden: true, animated: true)
//        } else {
//            changeTabBar(hidden: false, animated: true)
//        }
//    }
//    func changeTabBar(hidden: Bool, animated: Bool) {
//        let tabBar = self.tabBarController?.tabBar
//        let offset = (hidden ? UIScreen.main.bounds.size.height : UIScreen.main.bounds.size.height - (tabBar?.frame.size.height)!)
//        if offset == tabBar?.frame.origin.y {
//            return
//        }
//        let duration: TimeInterval = (animated ? 0.5 : 0.0)
//        UIView.animate(withDuration: duration) {
//            tabBar?.frame.origin.y = offset
//        }
//    }
//}
