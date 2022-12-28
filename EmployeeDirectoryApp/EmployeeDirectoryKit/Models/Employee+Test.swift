import Foundation

extension Employee {
    func testEmployee(
        uuid: String = UUID().uuidString,
        fullName: String = "",
        emailAddress: String = "",
        phoneNumber: String? = nil,
        biography: String? = nil,
        photoUrlSmall: String? = nil,
        photoUrlLarge: String? = nil,
        team: String = "",
        employeeType: EmployeeType = .contractor
    ) -> Employee {
        .init(
            uuid: uuid,
            fullName: fullName,
            emailAddress: emailAddress,
            phoneNumber: phoneNumber,
            biography: biography,
            photoUrlSmall: photoUrlSmall,
            photoUrlLarge: photoUrlLarge,
            team: team,
            employeeType: employeeType
        )
    }
}
