//
//  NetworkManager.swift
//  blindIdCase
//
//  Created by Emre Yılmaz on 21.05.2025.
//


import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
    case unauthorized
    case unknown
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func request<T: Decodable>(
        endpoint: String,
        method: String = "GET",
        body: Data? = nil,
        requiresAuth: Bool = false,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        guard let url = URL(string: "\(Constants.baseURL)\(endpoint)") else {
            return completion(.failure(.invalidURL))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if requiresAuth, let token = TokenManager.shared.token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        if let body = body {
            request.httpBody = body
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                return completion(.failure(.invalidResponse))
            }
            
            guard (200...299).contains(httpResponse.statusCode), let data = data else {
                if httpResponse.statusCode == 401 {
                    return completion(.failure(.unauthorized))
                } else {
                    return completion(.failure(.invalidResponse))
                }
            }
            //Hata nerden kaynaklaniyor.
            print("📦 Gelen JSON:")
            print(String(data: data, encoding: .utf8) ?? "Veri yok")
            
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
