import Foundation

extension Employee.EmployeeType {
    typealias Employee = L10n.Employee
    
    var localizable: String {
        switch self {
        case .contractor:
            return Employee.contractor
        case .fullTime:
            return Employee.fullTime
        case .partTime:
            return Employee.partTime
        }
    }
}
