//
//  NetworkManager.swift
//  jokes
//
//  Created by ShrishMishra on 26/08/23.
//

import Foundation
class NetworkManager {
    static let shared  = NetworkManager()
    private let apiUrl = "https://geek-jokes.sameerkumar.website/api"
    private init() {}

    func fetchJokeData(completion: @escaping (Result<String, Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            guard let url = URL(string: self.apiUrl) else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.invalidUrl))
                }
                return
            }
            
            do {
                let data = try Data(contentsOf: url)
                if let joke = String(data: data, encoding: .utf8) {
                    DispatchQueue.main.async {
                        completion(.success(joke))
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(.failure(NetworkError.invalidData))
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}


enum NetworkError: Error {
    case invalidUrl
    case invalidData
}
