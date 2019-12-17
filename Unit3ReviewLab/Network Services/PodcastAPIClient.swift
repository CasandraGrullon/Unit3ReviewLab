//
//  PodcastAPIClient.swift
//  Unit3ReviewLab
//
//  Created by casandra grullon on 12/17/19.
//  Copyright © 2019 casandra grullon. All rights reserved.
//

import Foundation

struct PodcastAPIClient {
    static func getPodcasts(for search: String, completion: @escaping (Result <[Results], AppError>) -> ()) {
        
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
                    let podcasts = try JSONDecoder().decode(Podcast.self, from: data)
                    let results = podcasts.results
                    completion(.success(results))
                }catch{
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
    static func getID(for trackId: Int, completion: @escaping (Result<[Results], AppError>) -> () ) {
        let endpointURL = "https://itunes.apple.com/search?media=podcast&limit=200&term=\(trackId)"
        
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
                do{
                    let podcasts = try JSONDecoder().decode(Podcast.self, from: data)
                    let results = podcasts.results
                    completion(.success(results))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
