import Foundation

protocol GetEmployeesAPIService {
    func getEmployeeList(url: URL) async throws -> EmployeeList
}

public class GetEmployeesService: GetEmployeesAPIService {
    func getEmployeeList(url: URL) async throws -> EmployeeList {
        return try await APIService.shared.get(url: url)
    }
}
