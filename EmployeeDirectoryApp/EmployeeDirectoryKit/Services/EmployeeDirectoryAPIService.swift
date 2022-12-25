import Foundation

public class EmployeeDirectoryAPIService {
    let decoder: JSONDecoder = {
        let d = JSONDecoder()
        d.keyDecodingStrategy = .convertFromSnakeCase
        return d
    }()
    
    func getEmployeeList<T: Decodable>(url: URL) async throws -> T {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedObject = try decoder.decode(T.self, from: data)
            
            return decodedObject
        } catch {
            throw error
        }
    }
}
