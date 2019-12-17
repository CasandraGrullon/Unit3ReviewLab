//
//  FavoritesAPIClient.swift
//  Unit3ReviewLab
//
//  Created by casandra grullon on 12/17/19.
//  Copyright © 2019 casandra grullon. All rights reserved.
//

import Foundation

struct FavoritesAPIClient {
    static func postFaves(favorite: Favorite, completion: @escaping (Result<Bool, AppError>) -> () ) {
        
        let endpointURL = "https://5c2e2a592fffe80014bd6904.mockapi.io/api/v1/favorites"
        
        guard let url = URL(string: endpointURL) else {
            completion(.failure(.badURL(endpointURL)))
            return
        }
        do {
            let data = try JSONEncoder().encode(favorite)
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = data
            
            NetworkHelper.shared.performDataTask(with: request) { (result) in
                switch result {
                case .failure(let appError):
                    completion(.failure(.networkClientError(appError)))
                case .success:
                    completion(.success(true))
                }
            }
        } catch {
            completion(.failure(.decodingError(error)))
        }
    }
    
    static func getFaves(completion: @escaping (Result<[Favorite], AppError>) -> () ) {
        let endpointURL = "https://5c2e2a592fffe80014bd6904.mockapi.io/api/v1/favorites"
        guard let url = URL(string: endpointURL) else {
            completion(.failure(.badURL(endpointURL)))
            return
        }
        
    }
}
