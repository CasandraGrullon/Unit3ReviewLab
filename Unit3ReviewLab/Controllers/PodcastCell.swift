//
//  PodcastCell.swift
//  Unit3ReviewLab
//
//  Created by casandra grullon on 12/17/19.
//  Copyright © 2019 casandra grullon. All rights reserved.
//

import UIKit

class PodcastCell: UITableViewCell {

    @IBOutlet weak var podcastImage: UIImageView!
    @IBOutlet weak var podcastNameLabel: UILabel!
    
    var podcast: Results?
    
    func configureCell(for podcast: Results){
        podcastNameLabel.text = podcast.collectionName
        podcastNameLabel.numberOfLines = 0
        
        podcastImage.getImage(with: podcast.artworkUrl100 ) { (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self.podcastImage.image = UIImage(systemName: "headphones")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self.podcastImage.image = image
                }
            }
        }
    }

}
