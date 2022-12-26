import Foundation
import Combine

final class EmployeeListViewModel: EmployeeListViewControllerViewModel {
    let header: HeaderCellModel
    
    @Published var employees: [EmployeeModel] = []
    @Published var isLoading: Bool = false
    
    private let url: URL
    
    init(urlType: urlTypes) {
        self.header = .init(
            title: "TITLE",
            firstInstruction: "firstInstruction",
            secondInstruction: "secondInstruction"
        )
        self.url = URL(string: urlType.rawValue)!
        loadEmployees()
    }
    
    func loadEmployees() {
        Task {
            do {
                let employeeList: EmployeeList = try await EmployeeDirectoryAPIService().getEmployeeList(url: url)
                employees = employeeList.employees.compactMap(EmployeeModel.init).sorted { $0.name < $1.name }

                for employee in employees {
                    print(employee.name)
                }
                isLoading = false
            } catch {
                isLoading = false
                print(error)
            }
        }
    }
}
