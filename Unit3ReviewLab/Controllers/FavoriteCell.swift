//
//  FavoriteCell.swift
//  Unit3ReviewLab
//
//  Created by casandra grullon on 12/17/19.
//  Copyright © 2019 casandra grullon. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {

    @IBOutlet weak var podcastImage: UIImageView!
    @IBOutlet weak var podcastNameLabel: UILabel!
    
    var podcast: Podcast?
    
    func configureCell(for fave: Podcast){
        podcastNameLabel.text = fave.collectionName
        podcastImage.getImage(with: fave.artworkUrl600) { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.podcastImage.image = UIImage(systemName: "headphones")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.podcastImage.image = image
                }
            }
        }
    }
    
}
