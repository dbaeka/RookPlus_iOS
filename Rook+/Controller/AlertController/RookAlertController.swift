//
//  RookAlertController.swift
//  RookPlus
//
//  Created by Delmwin Baeka on 4/8/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit
import os

enum RookAlertControllerError: Error {
    /**
     An exception thrown when an unimplemented feature is encountered at runtime.
     */
    case RookAlertControllerNotImplementedException
    /**
     An exception thrown when a text field is added to an alert controller which doesn't support text fields
     */
    case RookAlertControllerTextFieldInvalidException
    /**
     An exception thrown when a view controller presentation animation fails
     */
    case RookAlertControllerPresentationAnimationException
}


/**
 An enumeration describing the kinds of alerts that RookAlertController can display
 
 - RookAlertControllerStyleAlert: A standard alert, 270pt wide, variable height. Supports texts fields.
 - RookAlertControllerStyleWalkthroughAlert: A wider alert that stretches to the margins of the device - 18pt in either direction. Supports text fields, useful for onboarding. 500pt wide on iPad.
 - RookAlertControllerStyleActionSheet: An alert that appears at the bottom of the display, similar to Apple's action sheet stlye. Does NOT support text fields.
 */
enum RookAlertControllerStyle : Int {
    /**
     A standard alert, 270pt wide, variable height. Supports text fields
     */
    case alert
    /**
     A wider alert that stretches to the margins of the device - 18pt in either direction. Supports text fields, useful for onboarding. 500pt wide on iPad.
     */
    case walkthroughAlert
    /**
     An alert that appears at the bottom of the display, similar to Apple's action sheet stlye. Does NOT support text fields.
     */
    case actionSheet
}


/**
 An enumeration describing the kinds of animations that can be used to present and hide an alert
 
 - RookAlertControllerAnimationStyleRise: The alert rises from the bottom of the screen and falls down when dismissed.
 - RookAlertControllerAnimationStyleFall: The alert falls from the top of the screen and rises up when dismissed.
 - RookAlertControllerAnimationStyleSlide: The alert slides from the left of the screen and slides to the right when dismissed.
 - RookAlertControllerAnimationStyleFlip: The alert flips from the right, and flips to the left when dismissed.
 - RookAlertControllerAnimationStyleSticker: The alert page flips from the top, then again from the bottom when dismissed.
 - RookAlertControllerAnimationStyleCrossDisolve: The alert page fades in, then fades out dismissed.
 - RookAlertControllerAnimationStyleAutomatic: The alert chooses its presentation and dismissal styles automatically.
 */
enum RookAlertControllerAnimationStyle : Int {
    /**
     The alert rises from the bottom of the screen and falls down when dismissed.
     */
    case rise
    /**
     The alert falls from the top of the screen and rises up when dismissed.
     */
    case fall
    /**
     The alert slides from the left of the screen and slides to the right when dismissed.
     */
    case slide
    /**
     The alert flips from the right, and flips to the left when dismissed.
     */
    case flip
    /**
     The alert page flips from the top, then again from the bottom when dismissed.
     */
    case sticker
    /**
     The alert page fades in, then fades out dismissed.
     */
    case crossDisolve
    /**
     The alert chooses its presentation and dismissal styles automatically.
     */
    case automatic
}


/**
 RookAlertControllerDelegate is a protocol used to inform an object about user intractions with alerts
 */
@objc protocol RookAlertControllerDelegate: NSObjectProtocol {
    /**
     Sent to the delegate just before the view controller appears.
     
     @param alertController The alert controller
     */
    @objc optional func alertControllerWillAppear(_ alertController: RookAlertController)
    /**
     Sent to teh delegate just after the view controller appears.
     
     @param alertController The alert controller
     */
    @objc optional func alertControllerDidAppear(_ alertController: RookAlertController)
    /**
     Sent to the delegate just before the view controller disappears.
     
     @param alertController The alert controller
     */
    @objc optional func alertControllerWillDisappear(_ alertController: RookAlertController)
    /**
     Sent to teh delegate just after the view controller disappears.
     
     @param alertController The alert controller
     */
    @objc optional func alertControllerDidDisappear(_ alertController: RookAlertController)
    /**
     Sent to the delegate when the user taps on an action. Message is sent *before* the action block is executed.
     
     @param alertController The alert controller that houses the action.
     @param action The action that was interacted with.
     */
    @objc optional func alertController(_ alertController: RookAlertController, didSelect action: RookAlertAction)
}


/**
 RookAlertController is a drop-in replacement for UIAlertController with more features. It is created using the `+alertControllerWithTitle:message:image:style:` class method, and configured using instances of VSAlertAction. You can add text fields by calling `-addTextField:` on an instance of RookAlertController. Instantiate the controller, add your actions and textfieds. and any other configuration you might need. Present the controller modally using UIViewController's `-presentViewController:animated:completion:` method. RookAlertController respects the animation paramater of this call, and you configure the animation in question by setting your instances animationStyle property before presentation. You can also change this property in the handler of an action to use a different animation on dismissal.
 */
let kStandardAlertWidth: CGFloat = 270.0
let kWideAlertWidth: CGFloat = 480.0
let kAlertMargin: CGFloat = 18.0
let kAlertMinHeight: CGFloat = 100.0


class RookAlertControllerTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var actionStyle: RookAlertActionStyle?
    
    // MARK: - Overridden Instance Methods
    convenience override init() {
        self.init(actionStyle: RookAlertActionStyle.default)
    }
    
    // MARK: - UIViewControllerContextTransitioning
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        do {
            try animate(using: transitionContext)
        } catch {
            debugPrint(error.localizedDescription)
            return
        }
    }
    
    private func animate(using transitionContext: UIViewControllerContextTransitioning) throws {
        
        guard let toController = transitionContext.viewController(forKey: .to), let fromController = transitionContext.viewController(forKey: .from) else {
            throw RookAlertControllerError.RookAlertControllerPresentationAnimationException
        }
        
        if toController.isBeingPresented {
            
            if !(toController is RookAlertController) {
                
                // RookAlertControllerTransitinAnimator can only be used to present or dismiss RookAlertController objects
                transitionContext.completeTransition(false)
                
                // Throw Exception
                throw RookAlertControllerError.RookAlertControllerPresentationAnimationException
                return
            }
            
            if !transitionContext.isAnimated {
                
                if let view = toController.view {
                    transitionContext.containerView.addSubview(view)
                }
                transitionContext.completeTransition(true)
                
                return
            } else {
                
                // Find AlertController
                guard let alertController: RookAlertController = toController as? RookAlertController else {
                    throw RookAlertControllerError.RookAlertControllerPresentationAnimationException
                }
                
                // Create Shadow
                let shadowView = UIView(frame: transitionContext.containerView.frame)
                shadowView.autoresizingMask = [.flexibleWidth, .flexibleWidth]
                shadowView.translatesAutoresizingMaskIntoConstraints = true
                shadowView.layer.backgroundColor = UIColor.clear.cgColor
                transitionContext.containerView.addSubview(shadowView)
                
                let animationStyle: RookAlertControllerAnimationStyle? = alertController.animationStyle == RookAlertControllerAnimationStyle.automatic ? _automaticPresentationStyle(for: alertController) : alertController.animationStyle
                
                if (animationStyle == RookAlertControllerAnimationStyle.rise || animationStyle == RookAlertControllerAnimationStyle.fall) {
                    
                    // Rise & Fall Animations
                    
                    var dy: CGFloat = animationStyle == RookAlertControllerAnimationStyle.rise ? fromController.view.frame.size.height : -1.0 * fromController.view.frame.size.height
                    
                    var initialFrame: CGRect = fromController.view.frame.offsetBy(dx: 0.0, dy: dy)
                    
                    alertController.view.frame = initialFrame
                    
                    transitionContext.containerView.addSubview((alertController.view)!)
                    
                    UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                        
                        alertController.view.frame = fromController.view.frame
                        shadowView.layer.backgroundColor = UIColor.black.withAlphaComponent(0.5).cgColor
                        
                    }) { finished in
                        
                        transitionContext.completeTransition(finished)
                        
                    }
                } else if (animationStyle == RookAlertControllerAnimationStyle.slide) {
                    // Slide From Left Animation
                    
                    var initialFrame: CGRect = fromController.view.frame.offsetBy(dx: -1.0 * fromController.view.frame.size.width, dy: 0.0)
                    
                    alertController.view.frame = initialFrame
                    
                    transitionContext.containerView.addSubview((alertController.view)!)
                    
                    UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                        
                        alertController.view.frame = fromController.view.frame
                        shadowView.layer.backgroundColor = UIColor.black.withAlphaComponent(0.5).cgColor
                        
                    }) { finished in
                        
                        
                        transitionContext.completeTransition(finished)
                        
                    }
                    
                    
                } else if (animationStyle == RookAlertControllerAnimationStyle.flip) {
                    
                    // Flip Animation
                    
                    alertController.view.alpha = 0.0
                    transitionContext.containerView.addSubview(alertController.view)
                    
                    var flipDuration: TimeInterval = transitionDuration(using: transitionContext) - 0.1
                    
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
                        
                        DispatchQueue.main.async(execute: {
                            
                            UIView.transition(with: alertController.view, duration: flipDuration, options: .transitionFlipFromLeft, animations: {
                                
                                shadowView.layer.backgroundColor = UIColor.black.withAlphaComponent(0.5).cgColor
                                alertController.view.alpha = 1.0
                                
                            }) { finished in
                                
                                transitionContext.completeTransition(finished)
                                
                            }
                            
                        })
                        
                    })
                    
                } else if (animationStyle == RookAlertControllerAnimationStyle.sticker) {
                    
                    // Sticker Animation
                    
                    var body = alertController.alertView
                    body?.alpha = 0.0
                    transitionContext.containerView.addSubview(alertController.view)
                    
                    var stickerDuration: TimeInterval = transitionDuration(using: transitionContext) - 0.1
                    
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
                        
                        DispatchQueue.main.async(execute: {
                            
                            if let body = body {
                                UIView.transition(with: body, duration: stickerDuration, options: .transitionCurlDown, animations: {
                                    
                                    shadowView.layer.backgroundColor = UIColor.black.withAlphaComponent(0.5).cgColor
                                    body.alpha = 1.0
                                    
                                }) { finished in
                                    
                                    transitionContext.completeTransition(finished)
                                    
                                }
                            }
                            
                        })
                        
                    })
                    
                } else if (animationStyle == RookAlertControllerAnimationStyle.crossDisolve) {
                    
                    // Fade Disolve
                    
                    alertController.view.alpha = 0.0
                    transitionContext.containerView.addSubview(alertController.view)
                    
                    var fadeDuration = transitionDuration(using: transitionContext) - TimeInterval(0.1)
                    
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
                        
                        DispatchQueue.main.async(execute: {
                            
                            UIView.transition(with: (alertController.view)!, duration: fadeDuration, options: .transitionCrossDissolve, animations: {
                                
                                shadowView.layer.backgroundColor = UIColor.black.withAlphaComponent(0.5).cgColor
                                alertController.view.alpha = 1.0
                                
                            }) { finished in
                                
                                transitionContext.completeTransition(finished)
                                
                            }
                            
                        })
                        
                    })
                } else {
                    transitionContext.completeTransition(false)
                    throw RookAlertControllerError.RookAlertControllerPresentationAnimationException
                }
                
            }
            
        } else if (fromController.isBeingDismissed) {
            
            if !(fromController is RookAlertController) {
                
                // RookAlertControllerTransitinAnimator can only be used to present or dismiss RookAlertController objects
                transitionContext.completeTransition(false)
                
                // Throw Exception
                throw RookAlertControllerError.RookAlertControllerPresentationAnimationException
                
                return
            }
            
            
            if (!transitionContext.isAnimated) {
                fromController.view.removeFromSuperview()
                transitionContext.completeTransition(true)
                
                return;
                
            } else {
                
                // Find Alert Controller
                guard var alertController = fromController as? RookAlertController, var shadowView = transitionContext.containerView.subviews[0] as? UIView else {
                    throw RookAlertControllerError.RookAlertControllerPresentationAnimationException
                }
                
                var animationStyle: RookAlertControllerAnimationStyle? = alertController.animationStyle == RookAlertControllerAnimationStyle.automatic ? _automaticDismissalStyle(for: alertController) : alertController.animationStyle
                
                if (animationStyle == RookAlertControllerAnimationStyle.rise || animationStyle == RookAlertControllerAnimationStyle.fall) {
                    
                    // Fall & Rise Animation
                    var dy: CGFloat = animationStyle == RookAlertControllerAnimationStyle.rise ? toController.view.frame.size.height : -1.0 * toController.view.frame.size.height
                    
                    if animationStyle == RookAlertControllerAnimationStyle.rise && alertController.style != RookAlertControllerStyle.actionSheet {
                        
                        var rotationAnimation: CABasicAnimation?
                        rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
                        var rotations: CGFloat = actionStyle == RookAlertActionStyle.cancel ? -0.45 : 0.45
                        rotationAnimation?.toValue = NSNumber(value: Float(.pi * 2.0 * rotations * CGFloat(transitionDuration(using: transitionContext))))
                        rotationAnimation?.duration = CFTimeInterval(transitionDuration(using: transitionContext))
                        rotationAnimation?.isCumulative = true
                        rotationAnimation?.repeatCount = 0
                        
                        var body = alertController.alertView
                        
                        if let rotationAnimation = rotationAnimation {
                            body?.layer.add(rotationAnimation, forKey: "rotationAnimation")
                        }
                    }
                    
                    var destinationFrame: CGRect = toController.view.frame.offsetBy(dx: 0.0, dy: dy)
                    UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                        shadowView.layer.backgroundColor = UIColor.clear.cgColor
                        alertController.view.frame = destinationFrame
                        
                    }) { finished in
                        alertController.view.removeFromSuperview()
                        shadowView.removeFromSuperview()
                        transitionContext.completeTransition(finished)
                    }
                    
                } else if (animationStyle == RookAlertControllerAnimationStyle.slide) {
                    
                    // Slide To Right Animation
                    
                    var destinationFrame: CGRect = toController.view.frame.offsetBy(dx: toController.view.frame.size.width, dy: 0.0)
                    
                    UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                        
                        shadowView.layer.backgroundColor = UIColor.clear.cgColor
                        alertController.view.frame = destinationFrame
                        
                    }) { finished in
                        
                        alertController.view.removeFromSuperview()
                        shadowView.removeFromSuperview()
                        transitionContext.completeTransition(finished)
                        
                    }
                    
                    
                } else if (animationStyle == RookAlertControllerAnimationStyle.flip) {
                    
                    // Flip Animation
                    UIView.transition(with: alertController.view, duration: transitionDuration(using: transitionContext), options: .transitionFlipFromRight, animations: {
                        
                        alertController.view.alpha = 0.0
                        shadowView.layer.backgroundColor = UIColor.clear.cgColor
                        
                    }) { finished in
                        
                        alertController.view.removeFromSuperview()
                        shadowView.removeFromSuperview()
                        transitionContext.completeTransition(finished)
                        
                    }
                    
                    
                } else if (animationStyle == RookAlertControllerAnimationStyle.sticker) {
                    
                    // Sticker animation
                    var body = alertController.alertView
                    
                    if let body = body {
                        UIView.transition(with: body, duration: transitionDuration(using: transitionContext), options: .transitionCurlUp, animations: {
                            
                            body.alpha = 0.0
                            shadowView.layer.backgroundColor = UIColor.clear.cgColor
                            
                        }) { finished in
                            
                            alertController.view.removeFromSuperview()
                            shadowView.removeFromSuperview()
                            transitionContext.completeTransition(true)
                            
                        }
                    }
                    
                } else if (animationStyle == RookAlertControllerAnimationStyle.crossDisolve) {
                    
                    UIView.transition(with: alertController.view, duration: transitionDuration(using: transitionContext), options: .transitionCrossDissolve, animations: {
                        
                        alertController.view.alpha = 0.0
                        shadowView.layer.backgroundColor = UIColor.clear.cgColor
                        
                    }) { finished in
                        
                        alertController.view.removeFromSuperview()
                        shadowView.removeFromSuperview()
                        transitionContext.completeTransition(finished)
                        
                    }
                } else {
                    transitionContext.completeTransition(false)
                    throw RookAlertControllerError.RookAlertControllerPresentationAnimationException
                }
                
            }
        }
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        let toController: UIViewController? = transitionContext?.viewController(forKey: .to)
        let fromController: UIViewController? = transitionContext?.viewController(forKey: .from)
        
        var controller: RookAlertController?
        
        if toController?.isBeingPresented != nil {
            
            controller = toController as? RookAlertController
            
            if controller?.animationStyle == RookAlertControllerAnimationStyle.flip {
                
                return 0.5
            } else if controller?.animationStyle == RookAlertControllerAnimationStyle.sticker {
                
                return 0.6
            } else if controller?.animationStyle == RookAlertControllerAnimationStyle.crossDisolve {
                
                return 0.4
            }
            
            return 0.3
        } else if fromController?.isBeingDismissed != nil {
            controller = fromController as? RookAlertController
            if controller?.animationStyle == RookAlertControllerAnimationStyle.flip {
                return 0.4
            } else if controller?.animationStyle == RookAlertControllerAnimationStyle.sticker {
                return 0.5
            }
            return 0.3
        }
        return 0.0
        
    }

    init(actionStyle: RookAlertActionStyle) {
        super.init()
        self.actionStyle = actionStyle
    }
    
    // MARK: - Private Instance Methods
    func _automaticPresentationStyle(for controller: RookAlertController?) -> RookAlertControllerAnimationStyle {
        
        if controller?.style == RookAlertControllerStyle.actionSheet {
            return RookAlertControllerAnimationStyle.rise
        }
        return RookAlertControllerAnimationStyle.crossDisolve
    }
    
    func _automaticDismissalStyle(for controller: RookAlertController?) -> RookAlertControllerAnimationStyle {
        return RookAlertControllerAnimationStyle.rise
    }
}
            

class RookAlertController: UIViewController, UIViewControllerTransitioningDelegate {
    // Actions
    private var defaultActions: [RookAlertAction] = []
    private var destructiveActions: [RookAlertAction] = []
    private var cancelActions: [RookAlertAction] = []
    // Keyboard Show / Hide
    private var tempFrameOrigin = CGPoint.zero
    private var keyboardHasBeenShown = false
    // Transition
    private var presentAnimator: RookAlertControllerTransitionAnimator?
    private var dismissAnimator: RookAlertControllerTransitionAnimator?
    
    private var alertMaskBackground: UIImageView?
    fileprivate var alertView: UIView?
    private var headerView: UIView?
    private var headerViewHeightConstraint: NSLayoutConstraint?
    private var alertImage: UIImageView?
    private var alertTitle: UILabel?
    private var alertMessage: UILabel?
    private var alertActionStackView: UIStackView?
    private var alertStackViewHeightConstraint: NSLayoutConstraint?
    private var tapRecognizer: UITapGestureRecognizer?
    private var alertStackViewHeight: CGFloat {
        return UIScreen.main.bounds.size.height < 480.0 ? 40.0 : 62.0
    }
    private var hasTextFieldAdded: Bool {
        return textFields.count > 0
    }
    
    /**
     @name Configure Alert Behavior
     */
    
    /**
     Set to YES if you want the alert to dismiss itself when the user taps on the background of the alert. Default is NO.
     */
    var dismissOnBackgroundTap = false
    /**
     Change the animation used when the alert is presented AND dismissed. Default is RookAlertControllerAnimationStyleRise.
     */
    var animationStyle: RookAlertControllerAnimationStyle?
    /**
     @name Interacting with Alerts
     */
    
    /**
     The delegate object to handle alert action interactions
     */
    weak var delegate: RookAlertControllerDelegate?
    /**
     Returns the array of text field objects that are displayed in the alert, so you can interact with the user's inputs.
     */
    private(set) var textFields: [UITextField] = []
    /**
     The style of the alert
     */
    private(set) var style: RookAlertControllerStyle?
    /**
     The message of the alert
     */
    private(set) var message = ""
    /**
     The image of the alert
     */
    private(set) var image: UIImage?
    
    /**
     A factory method to create an instance of RookAlertController.
     
     @param title The title of the alert
     @param message The message of the alert
     @param preferredStyle The style of the alert
     @return The instantiated alert object
     */
    convenience init(title: String?, message: String?, preferredStyle: RookAlertControllerStyle) {
        self.init(title: title, message: message, image: nil, preferredStyle: preferredStyle)
    }

    /** Create an instance of RookAlertController
     
     @param title The title of the alert
     @param message The message of the alert
     @param image The image to be displayed in the header of the alert.
     @param preferredStyle The style of the alert
     @return The instantiated alert object
     */
    required init(title: String?, message: String?, image: UIImage?, preferredStyle: RookAlertControllerStyle) {
        
        super.init(nibName: nil, bundle: nil)
        
        // Basic setup
        _setUp()
        
        // Assign title
        self.title = title
        
        // Assign read-only properties
        guard let message = message else {return}
        self.message = message
        self.image = image
        style = preferredStyle
        
    }
    
    convenience init() {
        self.init(title: nil, message: nil, image: nil, preferredStyle: RookAlertControllerStyle.alert)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Basic setup
        _setUp()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        // Basic setup
        _setUp()
        
    }
    
    // MARK: - Overridden Instance Methods
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        _setUpUI()
        
        // Configure Text
        alertTitle?.text = title
        alertMessage?.text = message
        
        // Configure Image
        alertImage?.image = image
        
        // Update Constraints
        headerViewHeightConstraint?.constant = alertImage?.image != nil ? 180.0 : 0.0
        
        // Set Up Background Tap Gesture Recognizer If Needed
        if dismissOnBackgroundTap {
            
            tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(RookAlertController._dismissFromBackgroundTap))
            alertMaskBackground?.addGestureRecognizer(tapRecognizer!)
        }
        
        // Process Text Fields
        _processTextFields()
        
        // Process Actions
        _processActions()
        
        // Configure Stack
        _configureStack()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let delegate = delegate else {return}
    
        DispatchQueue.main.async(execute: {
            delegate.alertControllerWillAppear!(self)
        })
        
    }

    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        // Register for keyboard show/hide notifications
        NotificationCenter.default.addObserver(self, selector: #selector(RookAlertController._keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(RookAlertController._keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        guard let alertView = alertView else { return }
        if UI_USER_INTERFACE_IDIOM() == .pad && style == RookAlertControllerStyle.actionSheet {
            preferredContentSize = CGSize(width: alertView.bounds.size.width, height: alertView.frame.size.height + kAlertMargin)
        }
        guard let delegate = delegate else { return  }
        DispatchQueue.main.async(execute: {
            delegate.alertControllerDidAppear!(self)
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        guard let delegate = delegate else { return  }
        DispatchQueue.main.async(execute: {
            delegate.alertControllerWillDisappear!(self)
        })
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // Unregisted for keyboard show/hide notifications
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        guard let delegate = delegate else { return  }
        DispatchQueue.main.async(execute: {
            delegate.alertControllerDidDisappear!(self)
        })
    }
    
    // MARK: - Property Access Methods
    func alertTitleTextColor() -> UIColor? {
        
        return _alertTitleTextColor
        
    }
    
    func setAlertTitleTextColor(_ alertTitleTextColor: UIColor?) {
        
        _alertTitleTextColor = alertTitleTextColor
        if let alertTitleTextColor = self.alertTitleTextColor() {
            alertTitle?.textColor = alertTitleTextColor
        }
        
    }
    
    func alertTitleTextFont() -> UIFont? {
        return _alertTitleTextFont
    }
    
    func setAlertTitleTextFont(_ alertTitleTextFont: UIFont?) {
        _alertTitleTextFont = alertTitleTextFont
        alertTitle?.font = self.alertTitleTextFont()
    }
    
    func alertMessageTextColor() -> UIColor? {
        return _alertMessageTextColor
    }
    
    func setAlertMessageTextColor(_ alertMessageTextColor: UIColor?) {
        self._alertMessageTextColor = alertMessageTextColor
        alertMessage?.textColor = self.alertMessageTextColor()
        
    }
    
    func alertMessageTextFont() -> UIFont? {
        return _alertMessageTextFont
    }
    
    func setAlertMessageTextFont(_ alertMessageTextFont: UIFont?) {
        _alertMessageTextFont = alertMessageTextFont
        alertMessage?.font = self.alertMessageTextFont()
    }
    
    func alertMessageTextAlignment() -> NSTextAlignment? {
        return _alertMessageTextAlignment
    }
    
    func setAlertMessageTextAlignment(_ alertMessageTextAlignment: NSTextAlignment) {
        _alertMessageTextAlignment = alertMessageTextAlignment
        guard let textAlignment = self.alertMessageTextAlignment() else { return }
        alertMessage?.textAlignment = textAlignment
    }
    
    func alertBackgroundColor() -> UIColor? {
        return _alertBackgroundColor
    }
    
    func setAlertBackgroundColor(_ alertBackgroundColor: UIColor?) {
        _alertBackgroundColor = alertBackgroundColor
    }
    
    // MARK: - UIViewControllerTransitioningDelegate
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return presentAnimator
        
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return dismissAnimator
        
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        return nil
        
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
    
    // MARK: - Public Instance Methods
    
    func add(_ alertAction: RookAlertAction?) {
        
        // Keep actions separate because they maybe added in a different order than they maybe displayed
        if alertAction?.style == RookAlertActionStyle.default {
            
            if let alertAction = alertAction {
                defaultActions = defaultActions + [alertAction]
            }
        } else if alertAction?.style == RookAlertActionStyle.destructive {
            
            if let alertAction = alertAction {
                destructiveActions = destructiveActions + [alertAction]
            }
        } else if alertAction?.style == RookAlertActionStyle.cancel {
            
            if let alertAction = alertAction {
                cancelActions = cancelActions + [alertAction]
            }
        }
        
    }

    func addTextField(_ configuration: @escaping (UITextField?) -> Void) throws {
        
        if style == RookAlertControllerStyle.actionSheet {
            throw RookAlertControllerError.RookAlertControllerTextFieldInvalidException
        }
        
        // Instantiate textfield rather than accepting textfield param
        let textField = UITextField()
        
        // Customize textfield
        textField.returnKeyType = .done
        textField.font = UIFont.systemFont(ofSize: 17.0)
        textField.textAlignment = .center
        textField.addTarget(self, action: #selector(RookAlertController._closeKeyboard(_:)), for: .editingDidEndOnExit)
        
        // Perform configuration block on textfeild
        //if configuration
        configuration(textField)
        
        // Store textfield for use in -viewDidLoad
        textFields = textFields + [textField]
    }
    
    func _setUp() {
        
        // Prepare for proper modal use
        modalPresentationStyle = .overFullScreen
        
        // Take Over Transition Process
        transitioningDelegate = self
        
        // Set ivar defaults
        keyboardHasBeenShown = false
        defaultActions = [RookAlertAction]()
        destructiveActions = [RookAlertAction]()
        cancelActions = [RookAlertAction]()
        tempFrameOrigin = CGPoint(x: 0.0, y: 0.0)
        textFields = [UITextField]()
        presentAnimator = RookAlertControllerTransitionAnimator()
        dismissAnimator = RookAlertControllerTransitionAnimator()
        
        //     Set up propertie without accessors for use with UIAppearance
        _alertTitleTextColor = (_alertTitleTextColor != nil) ? _alertTitleTextColor : UIColor.black
        _alertTitleTextFont = (_alertTitleTextFont != nil) ? _alertTitleTextFont : UIFont.systemFont(ofSize: 17.0, weight: .semibold)
        _alertMessageTextColor = (_alertMessageTextColor != nil) ? _alertMessageTextColor : UIColor.black
        _alertMessageTextFont = (_alertMessageTextFont != nil) ? _alertMessageTextFont : UIFont.systemFont(ofSize: 15.0, weight: .regular)
        _alertMessageTextAlignment = NSTextAlignment.center
        _alertBackgroundColor = (_alertBackgroundColor != nil) ? _alertBackgroundColor : UIColor.white
        
        // Set instance read-only properties
        style = RookAlertControllerStyle.alert
        message = ""
        image = nil
        
        // Set instance property defaults
        title = nil
        animationStyle = RookAlertControllerAnimationStyle.automatic
        dismissOnBackgroundTap = false
    
    }
    
    // MARK: - Private Instance Methods
    private func _setUpUI() {
        
        /// Build alert view UI without xib
        _setUpAlertMaskBackground()
        _setUpAlertView()
        _setUpHeaderView()
        _setUpAlertImage()
        _setUpAlertTitle()
        _setUpAlertMessage()
        _setUpAlertActionStackView()
        _setUpPopoverController()
        
    }

    private func _setUpAlertMaskBackground() {
        
        alertMaskBackground = UIImageView(frame: CGRect.zero)
        alertMaskBackground?.backgroundColor = UIColor.clear
        alertMaskBackground?.translatesAutoresizingMaskIntoConstraints = false
        alertMaskBackground?.isUserInteractionEnabled = true
        
        view.addSubview(alertMaskBackground!)
        
        view.addConstraints([
            NSLayoutConstraint(item: alertMaskBackground, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: alertMaskBackground, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: alertMaskBackground, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: alertMaskBackground, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0.0)])
    }
    
    private func _setUpAlertView() {
        
        alertView = UIView(frame: CGRect.zero)
        alertView?.backgroundColor = alertBackgroundColor()
        alertView?.translatesAutoresizingMaskIntoConstraints = false
        
        alertMaskBackground?.addSubview(alertView!)
        
        if !(UI_USER_INTERFACE_IDIOM() == .pad && style == RookAlertControllerStyle.actionSheet) {
            
            alertView?.layer.cornerRadius = 5.0
            alertView?.layer.masksToBounds = false
            alertView?.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            alertView?.layer.shadowRadius = 8.0
            alertView?.layer.shadowOpacity = 0.3
        }
        
        if style == RookAlertControllerStyle.alert {
            view.addConstraint(NSLayoutConstraint(item: alertView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 0.0, constant: kStandardAlertWidth))
        } else {
            
            if UI_USER_INTERFACE_IDIOM() == .phone {
                
                view.addConstraints([
                    NSLayoutConstraint(item: alertView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: kAlertMargin),
                    NSLayoutConstraint(item: alertView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: -kAlertMargin)
                    ])
            } else if UI_USER_INTERFACE_IDIOM() == .pad {
                
                view.addConstraint(NSLayoutConstraint(item: alertView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 0.0, constant: kWideAlertWidth))
            }
        }
        view.addConstraints([
            NSLayoutConstraint(item: alertView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: alertView, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .height, multiplier: 0.0, constant: kAlertMinHeight)
            ])
        
        if style == RookAlertControllerStyle.actionSheet {
            
            view.addConstraint(NSLayoutConstraint(item: alertView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: -kAlertMargin))
        } else {
            
            view.addConstraint(NSLayoutConstraint(item: alertView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        }
    }
    
    private func _setUpHeaderView() {
        
        headerView = UIView(frame: CGRect.zero)
        headerView?.backgroundColor = UIColor.white
        headerView?.translatesAutoresizingMaskIntoConstraints = false
        
        alertView?.addSubview(headerView!)
        
        alertView?.addConstraints([
            NSLayoutConstraint(item: headerView, attribute: .top, relatedBy: .equal, toItem: alertView, attribute: .top, multiplier: 1.0, constant: 8.0),
            NSLayoutConstraint(item: headerView, attribute: .left, relatedBy: .equal, toItem: alertView, attribute: .left, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: headerView, attribute: .right, relatedBy: .equal, toItem: alertView, attribute: .right, multiplier: 1.0, constant: 0.0)
            ])
        headerViewHeightConstraint = NSLayoutConstraint(item: headerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 0.0, constant: 0.0)
        
        alertView?.addConstraint(headerViewHeightConstraint!)
    }
    
    private func _setUpAlertImage() {
        
        alertImage = UIImageView(frame: CGRect.zero)
        alertImage?.translatesAutoresizingMaskIntoConstraints = false
        alertImage?.contentMode = .scaleAspectFit
        
        headerView?.addSubview(alertImage!)
        
        headerView?.addConstraints([
            NSLayoutConstraint(item: alertImage, attribute: .top, relatedBy: .equal, toItem: headerView, attribute: .top, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: alertImage, attribute: .left, relatedBy: .equal, toItem: headerView, attribute: .left, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: alertImage, attribute: .right, relatedBy: .equal, toItem: headerView, attribute: .right, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: alertImage, attribute: .bottom, relatedBy: .equal, toItem: headerView, attribute: .bottom, multiplier: 1.0, constant: 0.0)])
    }
    
    private func _setUpAlertTitle() {
        
        alertTitle = UILabel()
        alertTitle?.font = alertTitleTextFont()
        alertTitle?.textColor = alertTitleTextColor()
        alertTitle?.numberOfLines = 0
        alertTitle?.textAlignment = .center
        alertTitle?.translatesAutoresizingMaskIntoConstraints = false
        
        alertView?.addSubview(alertTitle!)
        
        let height: CGFloat = (title != nil) ? 23.0 : 0.0
        
        alertView?.addConstraints([
            NSLayoutConstraint(item: alertTitle, attribute: .top, relatedBy: .equal, toItem: headerView, attribute: .bottom, multiplier: 1.0, constant: 10.0),
            NSLayoutConstraint(item: alertTitle, attribute: .left, relatedBy: .equal, toItem: alertView, attribute: .left, multiplier: 1.0, constant: 8.0),
            NSLayoutConstraint(item: alertTitle, attribute: .right, relatedBy: .equal, toItem: alertView, attribute: .right, multiplier: 1.0, constant: -8.0),
            NSLayoutConstraint(item: alertTitle, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .height, multiplier: 0.0, constant: height)
            ])
    }
    
    private func _setUpAlertMessage() {
        
        alertMessage = UILabel()
        alertMessage?.font = alertMessageTextFont()
        alertMessage?.textColor = alertMessageTextColor()
        alertMessage?.numberOfLines = 0
        guard let textAlignment = alertMessageTextAlignment() else { return }
        alertMessage?.textAlignment = textAlignment
        alertMessage?.translatesAutoresizingMaskIntoConstraints = false
        
        alertView?.addSubview(alertMessage!)
        
        alertView?.addConstraints([
            NSLayoutConstraint(item: alertMessage, attribute: .top, relatedBy: .equal, toItem: alertTitle, attribute: .bottom, multiplier: 1.0, constant: 8.0),
            NSLayoutConstraint(item: alertMessage, attribute: .left, relatedBy: .equal, toItem: alertView, attribute: .left, multiplier: 1.0, constant: 8.0),
            NSLayoutConstraint(item: alertMessage, attribute: .right, relatedBy: .equal, toItem: alertView, attribute: .right, multiplier: 1.0, constant: -8.0),
            NSLayoutConstraint(item: alertMessage, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .height, multiplier: 0.0, constant: 0.0)
            ])
        
    }
    
    private func _setUpAlertActionStackView() {
        
        alertActionStackView = UIStackView(frame: CGRect.zero)
        alertActionStackView?.distribution = UIStackView.Distribution.fillEqually
        alertActionStackView?.translatesAutoresizingMaskIntoConstraints = false
        
        alertView?.addSubview(alertActionStackView!)
        
        alertView?.addConstraints([
            NSLayoutConstraint(item: alertActionStackView, attribute: .top, relatedBy: .equal, toItem: alertMessage, attribute: .bottom, multiplier: 1.0, constant: 8.0),
            NSLayoutConstraint(item: alertActionStackView, attribute: .right, relatedBy: .equal, toItem: alertView, attribute: .right, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: alertActionStackView, attribute: .left, relatedBy: .equal, toItem: alertView, attribute: .left, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: alertActionStackView, attribute: .bottom, relatedBy: .equal, toItem: alertView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
            ])
        
        alertStackViewHeightConstraint = NSLayoutConstraint(item: alertActionStackView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 0.0, constant: 60.0)
        alertView?.addConstraint(alertStackViewHeightConstraint!)
        
    }
    
    private func _setUpPopoverController() {
        if UI_USER_INTERFACE_IDIOM() == .pad && style == RookAlertControllerStyle.actionSheet {
            
            modalPresentationStyle = .popover
            popoverPresentationController?.backgroundColor = UIColor.white
        }
        
    }

    
    private func _dismiss(from sender: RookAlertAction?) {
        // Pass action style to animator
        dismissAnimator = RookAlertControllerTransitionAnimator(actionStyle: (sender?.style)!)
        dismiss(animated: true)
        
    }
    
    @objc private func _dismissFromBackgroundTap() {
        // Pass "cancel" style to animator
        dismissAnimator = RookAlertControllerTransitionAnimator(actionStyle: RookAlertActionStyle.cancel)
        dismiss(animated: true)
        
    }
    
    private func _add(_ textField: UITextField?) {
        if let textField = textField {
            alertActionStackView?.addArrangedSubview(textField)
        }
        _configureStack()
        
    }

    @objc private func _keyboardWillShow(_ notif: Notification?) {
        
        // Adjust alert view's location when keyboard appears
        
        guard let alertView = alertView else { return }
        
        keyboardHasBeenShown = true
        
        let userInfo = notif?.userInfo
        let endKeyBoardFrame = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.minY
        
        if tempFrameOrigin.x == 0.0 && tempFrameOrigin.y == 0.0 {
            
            tempFrameOrigin = alertView.frame.origin
        }
        
        var newContentFrameY: CGFloat = alertView.frame.maxY - endKeyBoardFrame!
        
        if newContentFrameY < 0.0 {
            newContentFrameY = 0.0
        }
        
        alertView.frame = CGRect(x: alertView.frame.origin.x, y: CGFloat(alertView.frame.origin.y - newContentFrameY), width: alertView.frame.size.width, height: alertView.frame.size.height)
        
    }
    
    @objc private func _keyboardWillHide(_ notif: Notification?) {
        
        // Adjust alert view's location when keyboard disappears
         guard let alertView = alertView else { return }
        if keyboardHasBeenShown {
            
            if tempFrameOrigin.x != 0.0 || tempFrameOrigin.y != 0.0 {
                
                alertView.frame = CGRect(x: alertView.frame.origin.x, y: tempFrameOrigin.y, width: alertView.frame.size.width, height: alertView.frame.size.height)
                
                tempFrameOrigin = CGPoint(x: 0.0, y: 0.0)
            }
            
            keyboardHasBeenShown = false
        }
        
    }
    
    private func _processTextFields() {
        
        // Display Text Fields
        for textField in textFields {
            
            _add(textField)
        }
        
    }
    
    private func _processActions() {
        
        if cancelActions.count > 1 {
            debugPrint("""
            WARNING: Alerts with more than 1 \
            cancel\
             action are not recommended
            """)
        }
        
        let totalActions: Int = cancelActions.count + destructiveActions.count + defaultActions.count + textFields.count
        
        if totalActions > 2 || style == RookAlertControllerStyle.actionSheet {
            
            _processDefaultActions()
            _processDestructiveActions()
            _processCancelActions()
        } else {
            
            _processCancelActions()
            _processDestructiveActions()
            _processDefaultActions()
        }
        
    }

    private func _processDefaultActions() {
        
        for alertAction in defaultActions {
            
            alertActionStackView?.addArrangedSubview(alertAction)
            
            alertAction.addTarget(self, action: #selector(RookAlertController._tappedAction(_:)), for: .touchUpInside)
        }
        
        // Remove duplicate references
        defaultActions = []
        
    }
    
    private func _processDestructiveActions() {
        
        for alertAction in destructiveActions {
            
            alertActionStackView?.addArrangedSubview(alertAction)
            
            alertAction.addTarget(self, action: #selector(RookAlertController._tappedAction(_:)), for: .touchUpInside)
        }
        
        // Remove duplicate references
        destructiveActions = []
        
    }

    private func _processCancelActions() {
        for alertAction in cancelActions {
            alertActionStackView?.addArrangedSubview(alertAction)

            alertAction.addTarget(self, action: #selector(RookAlertController._tappedAction(_:)), for: .touchUpInside)
        }
        
        // Remove duplicate references
        cancelActions = []
        
    }
    
    private func _configureStack() {
        guard let alertActionStackView = alertActionStackView else { return }
        if alertActionStackView.arrangedSubviews.count > 2 || hasTextFieldAdded || style == RookAlertControllerStyle.actionSheet {
            
            alertStackViewHeightConstraint?.constant = alertStackViewHeight * (CGFloat(alertActionStackView.arrangedSubviews.count))
            alertActionStackView.axis = NSLayoutConstraint.Axis.vertical
        } else {
            
            alertStackViewHeightConstraint?.constant = alertStackViewHeight
            alertActionStackView.axis = NSLayoutConstraint.Axis.horizontal
        }
        
    }
    
    
    @objc private func _tappedAction(_ sender: RookAlertAction?) {
        // Check for delegate and inform on main thread
        guard let delegate = delegate else { return }
        DispatchQueue.main.async(execute: {
            delegate.alertController!(self, didSelect: sender!)
        })

        // Check if action has block and perform on main thread in-case of UI animations
        if sender?.action != nil {
            DispatchQueue.main.async(execute: {
                sender?.action!(sender!)
                
            })
        }
        
        _dismiss(from: sender)
        
    }
    
    @objc private func _closeKeyboard(_ sender: Any?) {
        let sender = sender as? UITextField
        sender?.resignFirstResponder()
    }
    
    /**
     @name Configuring Alert Appearance
     */
    
    /**
     The color of the alert title. The default value is black.
     */
    var _alertTitleTextColor: UIColor?
    /**
     The color of the alert message (description). The default value is black.
     */
    var _alertMessageTextColor: UIColor?
    /**
     The font of the alert title. The default value is the system font size 17 weight medium.
     */
    var _alertTitleTextFont: UIFont?
    /**
     The font of the alert message (description). The default value is the system font size 15 weight regular.
     */
    var _alertMessageTextFont: UIFont?
    /**
     The text alignment of the alert message
     */
    var _alertMessageTextAlignment: NSTextAlignment?
    /**
     The background color of the alert
     */
    var _alertBackgroundColor: UIColor?

    /**
     @name Configuring Interactive Alert Content
     */
    
    /**
     Add an action to an alert
     
     @param alertAction The action to add to the alert.
     */
    func add(_ alertAction: RookAlertAction) {
    }
    
    /**
     Add a text field to the alert. Rather than instantiating a UITextField object yourself, RookAlertController instantiates one for you. You can configure it using the optional configuration block
     
     @param configuration The block used to configure the text field.
     */
    func addTextField(_ configuration: ((_ textField: UITextField) -> Void)? = nil) {
    }
    
   
}
