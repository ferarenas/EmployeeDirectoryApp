//import Foundation
//import UIKit
//
//public protocol Configurable {
//    associatedtype ConfigurationItem
//    func configure(with item: ConfigurationItem)
//}
//
//public extension UICollectionView.CellRegistration
//where Cell: Configurable, Item == Cell.ConfigurationItem {
//    init(for: Cell.Type, handler: Handler? = nil) {
//        self.init { cell, indexPath, item in
//            cell.configure(with: item)
//            handler?(cell, indexPath, item)
//        }
//    }
//}

//import Foundation
//import Combine
//
//public extension ObservableObject {
//    /// A publisher that emits after the object has changed.
//    /// - Parameter scheduler: The scheduler that is used to debounce the objectWillChange events.
//    func objectDidChange(on scheduler: some Scheduler) -> AnyPublisher<Self.ObjectWillChangePublisher.Output, Never> {
//        objectWillChange
//            .debounce(for: 0, scheduler: scheduler)
//            .eraseToAnyPublisher()
//    }
//}
