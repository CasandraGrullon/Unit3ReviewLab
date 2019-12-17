//
//  Favorite.swift
//  Unit3ReviewLab
//
//  Created by casandra grullon on 12/16/19.
//  Copyright © 2019 casandra grullon. All rights reserved.
//

import Foundation

struct Favorite: Codable {
    let trackId : Int
    let favoritedBy: String
    let collectionName: String
    let artworkUrl600: String
}
