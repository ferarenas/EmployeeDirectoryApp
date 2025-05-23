import Foundation

protocol GetEmployeesAPIService {
    func getEmployeeList(url: URL) async throws -> EmployeeList
}
