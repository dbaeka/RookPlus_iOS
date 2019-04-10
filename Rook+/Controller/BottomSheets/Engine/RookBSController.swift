
import UIKit

/// `RookBSController` is an object that can be used to present bottom sheets.
public class RookBSController: NSObject {

    static var privateShared: RookBSController?
    /**
     Initializes a `RookBSController` object with a configuration.

     - parameter configuration: The configuration struct that specifies how Bottom Sheet should be configured.
     */
    
    class func shared() -> RookBSController {
        guard let stillAlive = privateShared else {
            privateShared = RookBSController()
            return privateShared!
        }
        return stillAlive
    }
    
    public init(configuration: RookBSConfiguration? = nil) {
        if let configuration = configuration {
            RookBSConfiguration.shared = configuration
        }

        super.init()
    }

    /**
     Presents a bottom sheet view controller embedded in a navigation controller.

     - parameter viewController:          The presented view controller.
     - parameter containerViewController: The presenting view controller.
     */
    public func present(_ viewController: UIViewController, on containerViewController: UIViewController) {
        if viewController is UINavigationController {
            assertionFailure("Presenting 'UINavigationController' in a bottom sheet is not supported.")
            return
        }

        let width: CGFloat = UIScreen.main.bounds.width
        let maxHeight: CGFloat = UIScreen.main.bounds.height - RookBSConfiguration.shared.minimumTopSpacing
        var height: CGFloat = maxHeight

        viewController.view.setNeedsLayout()
        viewController.view.layoutIfNeeded()
        let size = viewController.view.systemLayoutSizeFitting(CGSize(width: width, height: maxHeight))

        height = size.height <= maxHeight ? size.height : maxHeight

        // Increase height (only useful for the iPhone X for now)
        if #available(iOS 11.0, *) {
            guard let window = UIApplication.shared.keyWindow else {
                return
            }

            let bottomPadding = window.safeAreaInsets.bottom
            if height + bottomPadding <= maxHeight {
                height += bottomPadding
            }
        }

        let positionY = UIScreen.main.bounds.height - height
        viewController.view.frame = CGRect(x: 0.0, y: positionY, width: width, height: height)

        let bottomSheetTransitioningDelegate = RookBSTransitioningDelegate()
        viewController.transitioningDelegate = bottomSheetTransitioningDelegate
        viewController.modalPresentationStyle = .custom

        containerViewController.present(viewController, animated: true, completion: nil)
    }
    
    public func dismiss(from containingController: UIViewController){
        containingController.dismiss(animated: true, completion: nil)
    }
}
