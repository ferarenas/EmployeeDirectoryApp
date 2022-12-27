import Foundation
import Combine

final class EmployeeListViewModel: EmployeeListViewControllerViewModel {
    private typealias Strings = L10n.EmployeeList
    
    let header: HeaderCellModel
    @Published var employees: [EmployeeSummaryCellModel] = []
    
    var errorSubject: PassthroughSubject<Error, Never> = .init()
    var error: AnyPublisher<Error, Never> { errorSubject.eraseToAnyPublisher() }
    
    private let url: URL
    
    init(urlType: urlTypes) {
        self.header = .init(
            title: Strings.title,
            subTitle: Strings.subtitle
        )
        self.url = URL(string: urlType.rawValue)!
        loadEmployees()
    }
    
    func loadEmployees() {
        Task {
            do {
                let employeeList: EmployeeList = try await
                EmployeeDirectoryAPIService().getEmployeeList(url: url)
                employees = employeeList
                    .employees
                    .compactMap(EmployeeSummaryCellModel.init).sorted { $0.name < $1.name }
            } catch {
                errorSubject.send(error)
            }
        }
    }
}
