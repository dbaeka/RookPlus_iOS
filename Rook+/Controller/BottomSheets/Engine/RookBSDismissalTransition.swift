

import UIKit

class RookBSDismissalTransition: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return RookBSConfiguration.shared.animationDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!

        let animationDuration = transitionDuration(using: transitionContext)

        UIView.animate(
            withDuration: animationDuration,
            delay: 0.0,
            usingSpringWithDamping: 1.0,
            initialSpringVelocity: 0.8,
            options: UIView.AnimationOptions.curveEaseOut,
            animations: {
                fromViewController.view.transform = CGAffineTransform(translationX: 0, y: fromViewController.view.frame.height)
            }, completion: { _ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        )
    }
}
