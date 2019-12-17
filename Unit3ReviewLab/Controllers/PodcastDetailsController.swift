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
    
    var favorited = [Favorite]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let vc = segue.destination as? FavoritesViewController else {
            fatalError("antonio messed up")
        }
        vc.podcast = podcast
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
    
    
    @IBAction func addToFaves(_ sender: UIBarButtonItem) {
        guard let podcast = podcast else {
            showAlert(title: "App Error", message: "Issue uploading data")
            return
        }
        
        let favorite = Favorite(trackId: podcast.trackId, collectionName: podcast.collectionName, artworkUrl600: podcast.artworkUrl600)
        
        FavoritesAPIClient.postFaves(favorite: favorite) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error", message: "\(appError)")
                }
            case .success:
                DispatchQueue.main.async {
                    self?.showAlert(title: "♥️", message: "successfully added to your favorites")
                }
            }
        }
        
    }
    

}
