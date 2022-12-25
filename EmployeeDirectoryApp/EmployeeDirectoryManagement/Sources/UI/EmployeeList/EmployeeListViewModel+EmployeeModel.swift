import Foundation

extension EmployeeListViewModel {
    struct EmployeeModel: EmployeeSummaryCellViewModel, Hashable {
        let imageUrl: URL
        var name: String { employee.fullName }
        var team: String { employee.team }
        let employee: Employee
        
        init?(employee: Employee) {
            guard let imageUrlString = employee.photoURLSmall,
                  let imageUrl = URL(string: imageUrlString)
            else { return nil }
            
            self.imageUrl = imageUrl
            self.employee = employee
        }
    }
}
