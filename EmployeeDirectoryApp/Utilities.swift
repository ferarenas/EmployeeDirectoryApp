import Foundation
import UIKit

public protocol Configurable {
    associatedtype ConfigurationItem
    func configure(with item: ConfigurationItem)
}

public extension UICollectionView.CellRegistration
where Cell: Configurable, Item == Cell.ConfigurationItem {
    init(for: Cell.Type, handler: Handler? = nil) {
        self.init { cell, indexPath, item in
            cell.configure(with: item)
            handler?(cell, indexPath, item)
        }
    }
}
