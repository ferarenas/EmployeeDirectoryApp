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
//        let viewModel = EmployeeListViewModel(urlType: .empty)
        let viewModel = EmployeeListViewModel(urlType: .malformed)
//        let viewModel = EmployeeListViewModel(urlType: .valid)
        let viewController = EmployeeListViewController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: animated)
    }
}
