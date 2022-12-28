import Foundation
import Combine

final class EmployeeListViewModel: EmployeeListViewControllerViewModel {
    private typealias Strings = L10n.EmployeeList
    
    let header: HeaderCellModel
    @Published private(set) var employees: [EmployeeSummaryCellModel] = []
    @Published private(set) var isLoading = false
    
    private(set) lazy var errorPublisher: AnyPublisher<Error, Never> = errorSubject.eraseToAnyPublisher()
    private(set) lazy var employeesPublisher: AnyPublisher<[EmployeeSummaryCellModel], Never> = $employees.eraseToAnyPublisher()
    private(set) lazy var isLoadingPublisher: AnyPublisher<Bool, Never> = $isLoading.eraseToAnyPublisher()
    
    private var errorSubject: PassthroughSubject<Error, Never> = .init()
    private let url: URL
    private let service: GetEmployeesServiceProtocol
    
    init(service: GetEmployeesServiceProtocol, urlType: UrlTypes) {
        self.service = service
        self.header = .init(
            title: Strings.title,
            subTitle: Strings.subtitle
        )
        self.url = URL(string: urlType.rawValue)!
    }
    
    func loadEmployees() async {
        defer {
            isLoading = false
        }
        
        do {
            isLoading = true
            let employeeList = try await service.getEmployeeList(url: url)
            
            employees = employeeList
                .employees
                .compactMap(EmployeeSummaryCellModel.init).sorted { $0.name < $1.name }
        } catch {
            errorSubject.send(error)
        }
    }
}
