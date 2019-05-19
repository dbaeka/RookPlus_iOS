

import Foundation
import UIKit

/// Encapsulates configuration information for the behavior of Bottom Sheet.
public struct RookBSConfiguration {
    
    static var shared: RookBSConfiguration = RookBSConfiguration()

    /// The presentation and dismissal animation duration.
    public var animationDuration: TimeInterval = 0.0

    /// The minimum spacing between the bottom sheet and the top of the screen.
    public var minimumTopSpacing: CGFloat = 0.0

    /// The default presentation and dismissal animation duration.
    public static let defaultAnimationDuration: TimeInterval = 0.4

    /// The default minimum spacing between the bottom sheet and the top of the screen.
    public static let defaultMinimumTopSpacing: CGFloat = 150.0

    /**
     Initializes a `NBBottomSheetConfiguration` object with optionally customizable behaviors.

     - parameter animationDuration: The presentation and dismissal animation duration.
     - parameter minimumTopSpacing: The minimum spacing between the bottom sheet and the top of the screen.
     */
    public init(animationDuration: TimeInterval = defaultAnimationDuration,
                minimumTopSpacing: CGFloat = defaultMinimumTopSpacing) {
        self.animationDuration = animationDuration
        self.minimumTopSpacing = minimumTopSpacing
    }
}
