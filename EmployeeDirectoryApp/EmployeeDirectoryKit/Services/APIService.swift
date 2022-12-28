import Foundation

protocol GetEmployeesServiceProtocol {
    func getEmployeeList(url: URL) async throws -> EmployeeList
}

public class APIService {
    static let shared: APIService = .init(jsonDecoder: .init())
    
    private init(jsonDecoder: JSONDecoder) {  }
    
    let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func get<T: Decodable>(url: URL) async throws -> T {
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedObject = try decoder.decode(T.self, from: data)
        
        return decodedObject
    }
}


public class GetEmployeesService: GetEmployeesServiceProtocol {
    
    func getEmployeeList(url: URL) async throws -> EmployeeList {
        return try await APIService.shared.get(url: url)
    }
    
}
