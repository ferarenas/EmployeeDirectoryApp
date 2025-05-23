import Foundation

// MARK: - URL
enum UrlTypes: String {
    case valid = "https://s3.amazonaws.com/sq-mobile-interview/employees.json"
    case malformed = "https://s3.amazonaws.com/sq-mobile-interview/employees_malformed.json"
    case empty = "https://s3.amazonaws.com/sq-mobile-interview/employees_empty.json"
}

//MARK: - Strings
enum L10n {
    enum EmployeeList {
        static let title = "Employee Directory App"
        static let subtitle = "Pull to refresh list"
        internal enum Alert {
            static let title = "Decoding Error"
            static let button = "Dismiss"
        }
        static let emptyListTitle = "No Employees Found"
    }
    enum Employee {
        static let contractor = "Contractor"
        static let fullTime = "Full Time"
        static let partTime = "Part Time"
    }
    
}

//MARK: - Spacing
enum Spacing {
    public static let extraSmall: CGFloat = 12
    public static let small: CGFloat = 16
    public static let medium: CGFloat = 20
    public static let large: CGFloat = 24
    public static let extraLarge: CGFloat = 28
    public static let huge: CGFloat = 60
}
