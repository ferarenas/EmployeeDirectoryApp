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
        navigationController.isNavigationBarHidden = true
        
        showEmployeeList(animated: true)
    }
    
    func showEmployeeList(animated: Bool) {
//        let viewModel = EmployeeListViewModel(urlType: .empty)
//        let viewModel = EmployeeListViewModel(urlType: .malformed)
        let viewModel = EmployeeListViewModel(service: GetEmployeesService(), urlType: .valid)
        let viewController = EmployeeListViewController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: animated)
    }
}
