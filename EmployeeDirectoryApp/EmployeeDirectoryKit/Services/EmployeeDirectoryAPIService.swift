import Foundation

public class EmployeeDirectoryAPIService {
    let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func getEmployeeList<T: Decodable>(url: URL) async throws -> T {
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedObject = try decoder.decode(T.self, from: data)
        
        return decodedObject
    }
}
