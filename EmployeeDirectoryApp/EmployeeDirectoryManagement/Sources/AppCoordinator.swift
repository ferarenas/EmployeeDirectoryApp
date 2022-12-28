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
//        let viewModel = EmployeeListViewModel(service: GetEmployeesService(), urlType: UrlTypes.empty)
//        let viewModel = EmployeeListViewModel(service: GetEmployeesService(), urlType: UrlTypes.malformed)
        let viewModel = EmployeeListViewModel(service: GetEmployeesService(), urlType: UrlTypes.valid)
        let viewController = EmployeeListViewController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: animated)
    }
}
