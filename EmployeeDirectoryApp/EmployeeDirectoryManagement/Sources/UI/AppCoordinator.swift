import UIKit

class AppCoordinator {
    let window: UIWindow
    let navigationController: UINavigationController = .init()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        showEmployeeList(animated: true)
    }
    
    func showEmployeeList(animated: Bool) {
        let viewController = EmployeeListViewController()
        
        navigationController.pushViewController(viewController, animated: animated)
    }
}
