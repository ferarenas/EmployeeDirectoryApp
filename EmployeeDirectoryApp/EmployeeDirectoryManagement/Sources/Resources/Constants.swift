import Foundation

// MARK: - URL
enum urlTypes: String {
    case valid = "https://s3.amazonaws.com/sq-mobile-interview/employees.json"
    case malformed = "https://s3.amazonaws.com/sq-mobile-interview/employees_malformed.json"
    case empty = "https://s3.amazonaws.com/sq-mobile-interview/employees_empty.json"
}

//MARK: - Strings
enum L10n {
    enum EmployeeList {
        static let employeeListTitle = "Employee Directory App"
        static let firstTitle = "Pull to refresh list"
    }
}

//MARK: - Spacing
enum Spacing {
    public static let extraSmall: CGFloat = 12
    public static let small: CGFloat = 16
    public static let medium: CGFloat = 20
    public static let large: CGFloat = 24
    public static let extraLarge: CGFloat = 28
}
