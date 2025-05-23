import Combine
import UIKit

class AppCoordinator {
    let window: UIWindow
    let navigationController: UINavigationController = .init()
    private var cancellable: AnyCancellable?
    
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
        // Uncomment the desired urlType
//        let viewModel = EmployeeListViewModel(service: GetEmployeesService(), urlType: UrlTypes.empty)
//        let viewModel = EmployeeListViewModel(service: GetEmployeesService(), urlType: UrlTypes.malformed)
        let viewModel = EmployeeListViewModel(service: GetEmployeesService(), urlType: UrlTypes.valid)
        let viewController = EmployeeListViewController(viewModel: viewModel)
        
        cancellable = viewModel.showEmployeePublisher
            .sink { [weak self] in self?.showEmployeeInformation($0)}
        
        
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    func showEmployeeInformation(_ employee: Employee) {
        let viewModel = EmployeeInformationViewModel(employee: employee)
        let viewController = EmployeeInformationViewController(viewModel: viewModel)
        
        navigationController.present(viewController, animated: true)
        
    }
}
