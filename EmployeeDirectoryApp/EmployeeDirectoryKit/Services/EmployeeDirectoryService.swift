import Foundation

protocol EmployeeDirectoryService {
    func getEmployeeList<T: Decodable>(url: URL) async throws -> T
}
