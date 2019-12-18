//
//  PodcastAPIClient.swift
//  Unit3ReviewLab
//
//  Created by casandra grullon on 12/17/19.
//  Copyright © 2019 casandra grullon. All rights reserved.
//

import Foundation

struct PodcastAPIClient {
    static func getPodcasts(for search: String, completion: @escaping (Result <[Podcast], AppError>) -> ()) {
        
        let searchQuery = search.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "swift"
        
        let endpointURL = "https://itunes.apple.com/search?media=podcast&limit=200&term=\(searchQuery)"
        
        guard let url = URL(string: endpointURL) else {
            completion(.failure(.badURL(endpointURL)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result{
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do{
                    let podcasts = try JSONDecoder().decode(PodcastResults.self, from: data)
                    let results = podcasts.results
                    completion(.success(results))
                }catch{
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
    
    static func postFaves(favorite: Podcast, completion: @escaping (Result<Bool, AppError>) -> () ) {
        
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
    
    static func getFaves(completion: @escaping (Result<[Podcast], AppError>) -> () ) {
        let endpointURL = "https://5c2e2a592fffe80014bd6904.mockapi.io/api/v1/favorites"
        guard let url = URL(string: endpointURL) else {
            completion(.failure(.badURL(endpointURL)))
            return
        }
        let request = URLRequest(url: url)
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let favorites = try JSONDecoder().decode([Podcast].self, from: data)
                    completion(.success(favorites))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
