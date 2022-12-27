import Foundation

enum urlTypes: String {
    case valid = "https://s3.amazonaws.com/sq-mobile-interview/employees.json"
    case malformed = "https://s3.amazonaws.com/sq-mobile-interview/employees_malformed.json"
    case empty = "https://s3.amazonaws.com/sq-mobile-interview/employees_empty.json"
}

enum L10n {
    enum EmployeeList {
        static let employeeListTitle = "Employee Directory App"
        static let firstTitle = "Pull to refresh list"
    }
}
