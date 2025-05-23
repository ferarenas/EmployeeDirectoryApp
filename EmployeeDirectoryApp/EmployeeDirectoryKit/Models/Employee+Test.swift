import Foundation

extension Employee {
    static func testEmployee(
        uuid: String = "",
        fullName: String = "",
        emailAddress: String = "",
        phoneNumber: String? = nil,
        biography: String? = nil,
        photoUrlSmall: String? = "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/small.jpg",
        photoUrlLarge: String? = "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/small.jpg",
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
