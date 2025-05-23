import Foundation

public class MockEmployeeService: GetEmployeesAPIService {
    internal init(result: Result<[Employee], Error>) {
        self.result = result
    }
    
    let result: Result<[Employee], Error>
    
    func getEmployeeList(url: URL) async throws -> EmployeeList {
        switch result {
        case .success(let employees):
            return .init(employees: employees)
            
        case .failure(let error):
            throw error
        }
    }
}

