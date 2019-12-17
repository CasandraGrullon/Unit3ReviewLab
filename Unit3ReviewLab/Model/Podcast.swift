//
//  Podcast.swift
//  Unit3ReviewLab
//
//  Created by casandra grullon on 12/16/19.
//  Copyright © 2019 casandra grullon. All rights reserved.
//

import Foundation

struct Podcast: Decodable {
    let results: [Results]
}
struct Results: Decodable {
    let trackId: Int
    let artistName: String
    let collectionName: String
    let artworkUrl100: String
    let artworkUrl600: String
    let genres: [String]
}

