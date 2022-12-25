import Foundation

struct EmployeeList: Codable, Hashable {
    let employees: [Employee]
}

struct Employee: Codable, Hashable {
    let uuid: String
    let fullName: String
    let emailAddress: String
    let phoneNumber: String?
    let biography: String?
    let photoURLSmall: String?
    let photoURLLarge: String?
    let team: String
    let employeeType: EmployeeType
}

enum EmployeeType: String, Codable, Hashable {
    case contractor = "CONTRACTOR"
    case fullTime = "FULL_TIME"
    case partTime = "PART_TIME"
}
