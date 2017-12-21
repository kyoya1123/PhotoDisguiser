import UIKit

class BackgroundHighlightedButton: UIButton {
    override var isHighlighted :Bool {
        didSet {
            if isHighlighted {
                self.backgroundColor = UIColor(red:1, green:1, blue:1, alpha:0.65)
            } else {
                self.backgroundColor = .clear
            }
        }
    }
}
