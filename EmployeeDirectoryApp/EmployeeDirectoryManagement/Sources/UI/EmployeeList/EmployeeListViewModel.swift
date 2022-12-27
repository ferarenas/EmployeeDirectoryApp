import Foundation
import Combine

final class EmployeeListViewModel: EmployeeListViewControllerViewModel {
    private typealias Strings = L10n.EmployeeList
    let header: HeaderCellModel
    
    @Published var employees: [EmployeeModel] = []
    @Published var isLoading: Bool = false
    
    private let url: URL
    
    init(urlType: urlTypes) {
        self.header = .init(
            title: Strings.employeeListTitle,
            firstInstruction: Strings.firstTitle,
            secondInstruction: "TO DELETE"
        )
        self.url = URL(string: urlType.rawValue)!
        loadEmployees()
    }
    
    func loadEmployees() {
        Task {
            do {
                let employeeList: EmployeeList = try await EmployeeDirectoryAPIService().getEmployeeList(url: url)
                employees = employeeList.employees.compactMap(EmployeeModel.init).sorted { $0.name < $1.name }
                isLoading = false
            } catch {
                isLoading = false
                print(error)
            }
        }
    }
}
