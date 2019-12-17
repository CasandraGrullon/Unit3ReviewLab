//
//  PodcastDetailsController.swift
//  Unit3ReviewLab
//
//  Created by casandra grullon on 12/16/19.
//  Copyright © 2019 casandra grullon. All rights reserved.
//

import UIKit

class PodcastDetailsController: UIViewController {

    @IBOutlet weak var podcastImage: UIImageView!
    @IBOutlet weak var podcastNameLabel: UILabel!
    @IBOutlet weak var podcastGenreLabel: UILabel!
    
    var podcast: Results?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        guard let podcastPicked = podcast else {
            return
        }
        podcastNameLabel.text = podcastPicked.collectionName
        podcastGenreLabel.text = podcastPicked.genres.first
        podcastImage.getImage(with: podcastPicked.artworkUrl600) { [weak self] (result) in
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
