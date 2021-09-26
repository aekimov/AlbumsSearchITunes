//
//  APIService.swift
//  Bored
//
//  Created by Artem Ekimov on 20.09.2021.
//

import UIKit

class APIService {
    static let shared = APIService()
    
    enum APIError: Error {
        case error (_ errorString: String)
    }
    
    func getJSON<T: Codable>(urlString: String, completion: @escaping (Result<T, APIError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.error("Error: Invalid URL.")))
            return
        } // Handling invalid URL error
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.error("Error: \(error)"))) // Error that indicates why the request failed, or nil if the request was successful.
                return
            }
            guard let data = data else {
                completion(.failure(.error("Error: Data is Corrupted."))) // Handling corrupted data error
                return
            }
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
                return
            } catch let decodingError {
                completion(.failure(.error("Error, \(decodingError)")))
            }
        }.resume()
    }
}

