import UIKit

extension UIActivityIndicatorView {
    var animating: Bool {
        get { isAnimating }
        set { newValue ? startAnimating() : stopAnimating() }
    }
}
