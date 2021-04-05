//
//  NetworkManager.swift
//  WatchWeather WatchKit Extension
//
//  Created by benjamiin on 30/03/2021.
//

import Foundation

class NetworkManager<T: Codable> {
    func fetch(for url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completion(.failure(.error(err: error!.localizedDescription)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.badResponse))
                return
            }
            
            guard httpResponse.statusCode == 200 else {
                completion(.failure(.wrongStatusCode(code: httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.emptyData))
                return
            }
            
            do {
                let json = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(json))
                }
            } catch let err {
                completion(.failure(.decodingError(err: err.localizedDescription)))
            }
        }
        .resume()
    }
}

enum NetworkError: Error {
    case badResponse
    case wrongStatusCode(code: Int)
    case error(err: String)
    case decodingError(err: String)
    case emptyData
}
