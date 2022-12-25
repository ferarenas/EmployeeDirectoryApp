import Foundation

final class EmployeeListViewModel: EmployeeListViewControllerViewModel {
    let header: HeaderCellModel
    var employees: [EmployeeModel] = []
    
    init() {
        self.header = .init(
            title: "TITLE",
            firstInstruction: "firstInstruction",
            secondInstruction: "secondInstruction"
        )
        
        Task {
            
            
            
            do {
               try await getEmployees()
            }
            catch {
                print(error)
            }
        }
    }
    
    func getEmployees() async throws  {
        do {
            let successUrl = URL(string: "https://s3.amazonaws.com/sq-mobile-interview/employees.json")!
            let employeeList: EmployeeList = try await EmployeeDirectoryAPIService().getEmployeeList(url: successUrl)
            self.employees = employeeList.employees.compactMap(EmployeeModel.init)
        } catch {
            print(error)
        }
    }
    
}
