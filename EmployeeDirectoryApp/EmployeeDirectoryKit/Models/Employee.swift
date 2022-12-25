import Foundation

struct Employee: Codable {
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

extension Employee {
    enum EmployeeType: String, Codable {
        case contractor = "CONTRACTOR"
        case fullTime = "FULL_TIME"
        case partTime = "PART_TIME"
    }
}
