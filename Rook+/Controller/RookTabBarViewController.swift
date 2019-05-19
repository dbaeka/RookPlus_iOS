//
//  RookTabBarViewController.swift
//  Rook+
//
//  Created by Delmwin Baeka on 1/31/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

class RookTabBarViewController: UITabBarController, PlayerVCDelegate {
    
    
    //MARK: Properties
    @IBOutlet var playerView: PlayerView!
    
    let hiddenOrigin: CGPoint = {
        let y = CGFloat(320) //UIScreen.main.bounds.height - (UIScreen.main.bounds.width * 9 / 32) - 10
        let x = -UIScreen.main.bounds.width
        let coordinate = CGPoint.init(x: x, y: y)
        return coordinate
    }()
    let minimizedOrigin: CGPoint = {
        let x = UIScreen.main.bounds.width/2 - 10
        let y =  CGFloat(320) //UIScreen.main.bounds.height - (UIScreen.main.bounds.width * 9 / 32) - 10
        let coordinate = CGPoint.init(x: x, y: y)
        return coordinate
    }()
    let fullScreenOrigin = CGPoint.init(x: 0, y: 0)
    
    //Methods
    func customization() {
        //PLayerView setup
        self.playerView.frame = CGRect.init(origin: self.hiddenOrigin, size: UIScreen.main.bounds.size)
        self.playerView.delegate = self
    }
   
    func animatePlayView(toState: PlayerView.stateOfVC) {
        switch toState {
        case .fullScreen:
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: [.beginFromCurrentState], animations: {
                self.playerView.frame.origin = self.fullScreenOrigin
            })
        case .minimized:
            UIView.animate(withDuration: 0.3, animations: {
                self.playerView.frame.origin = self.minimizedOrigin
            })
        case .hidden:
            UIView.animate(withDuration: 0.3, animations: {
                self.playerView.frame.origin = self.hiddenOrigin
            })
        }
    }
    
    func positionDuringSwipe(scaleFactor: CGFloat) -> CGPoint {
        let width = UIScreen.main.bounds.width * 0.5 * scaleFactor
        let height = width * 9 / 16
        let x = (UIScreen.main.bounds.width - 10) * scaleFactor - width
        let y = (UIScreen.main.bounds.height - 10) * scaleFactor - height
        let coordinate = CGPoint.init(x: x, y: y)
        return coordinate
    }
    
    //MARK: Delegate methods
    func didMinimize() {
        self.animatePlayView(toState: .minimized)
    }
    
    func didmaximize(frame: CGRect){
        self.playerView.frame = CGRect(origin: frame.origin, size: UIScreen.main.bounds.size)
        self.animatePlayView(toState: .fullScreen)
    }
    
    func didEndedSwipe(toState: PlayerView.stateOfVC){
        self.animatePlayView(toState: toState)
    }
    
    func swipeToMinimize(translation: CGFloat, toState: PlayerView.stateOfVC){
        switch toState {
        case .fullScreen:
            self.playerView.frame.origin = self.positionDuringSwipe(scaleFactor: translation)
        case .hidden:
            self.playerView.frame.origin.x = UIScreen.main.bounds.width/2 - abs(translation) - 10
        case .minimized:
            self.playerView.frame.origin = self.positionDuringSwipe(scaleFactor: translation)
        }
    }
    
    //MARK: ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.unselectedItemTintColor = UIColor.black
        self.customization()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(self.playerView)
        }
    }
    
 
}


