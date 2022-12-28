import Foundation
import Combine

final class EmployeeListViewModel: EmployeeListViewControllerViewModel {
    private typealias Strings = L10n.EmployeeList
    typealias EmployeesPublisher = AnyPublisher<[EmployeeSummaryCellModel], Never>
    
    let header: HeaderCellModel
    private(set) lazy var employeesPublisher: EmployeesPublisher = employeesSubject.eraseToAnyPublisher()
    private(set) lazy var errorPublisher: AnyPublisher<Error, Never> = errorSubject.eraseToAnyPublisher()
    private(set) lazy var isLoadingPublisher: AnyPublisher<Bool, Never> = isLoading.eraseToAnyPublisher()
    
    private var employeesSubject: PassthroughSubject<[EmployeeSummaryCellModel], Never> = .init()
    private var isLoading: CurrentValueSubject<Bool, Never> = .init(false)
    private var errorSubject: PassthroughSubject<Error, Never> = .init()
    private let url: URL
    private let service: GetEmployeesAPIService
    
    init(service: GetEmployeesAPIService, urlType: UrlTypes) {
        self.service = service
        self.header = .init(
            title: Strings.title,
            subTitle: Strings.subtitle
        )
        self.url = URL(string: urlType.rawValue)!
    }
    
    func loadEmployees() async {
        defer { isLoading.send(false) }
        do {
            isLoading.send(true)
            
            let employeeList = try await service.getEmployeeList(url: url)
            
            employeesSubject
                .send(
                    employeeList
                        .employees
                        .compactMap(EmployeeSummaryCellModel.init)
                        .sorted { $0.name < $1.name }
                )
        } catch {
            errorSubject.send(error)
        }
    }
}
