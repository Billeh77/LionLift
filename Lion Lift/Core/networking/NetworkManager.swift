//

//
//  Created by Chloe Lee on 11/14/24.
//


import Foundation

class NetworkManager {
    static let shared = NetworkManager() // Singleton pattern
    private init() {}
    
    // Sign Up API Call
    func signUp(email: String, phoneNumber: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let url = URL(string: "https://your-backend.com/api/signup") else {
            completion(.failure(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }

        let userData: [String: Any] = [
            "email": email,
            "phoneNumber": phoneNumber,
            "password": password
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: userData)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "Signup failed"])))
                return
            }

            completion(.success(true))
        }.resume()
    }
    
    // Login API Call
    func login(email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let url = URL(string: "https://your-backend.com/api/login") else {
            completion(.failure(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }

        let loginData: [String: Any] = [
            "email": email,
            "password": password
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: loginData)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Login failed"])))
                return
            }

            completion(.success(true))
        }.resume()
    }
}
