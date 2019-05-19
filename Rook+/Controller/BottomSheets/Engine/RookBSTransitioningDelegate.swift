

import UIKit

class RookBSTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return RookBSPresentationController(presentedViewController: presented, presenting: presenting)
    }

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return RookBSPresentationTransition()
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return RookBSDismissalTransition()
    }
}
