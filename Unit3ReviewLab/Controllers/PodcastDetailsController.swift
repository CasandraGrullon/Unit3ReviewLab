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
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var podcastGenreLabel: UILabel!
    
    var podcast: Podcast?
    var podcastArr = [Podcast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let vc = segue.destination as? FavoritesViewController else {
            fatalError("segue issue")
        }
        vc.podcast = podcast
    }

    func updateUI() {
        guard let podcastPicked = podcast else {
            return
        }
        podcastNameLabel.text = podcastPicked.collectionName
        artistNameLabel.text = podcastPicked.artistName
        podcastGenreLabel.text = podcastPicked.genres?.first
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
        let favorite = Podcast(trackId: podcast.trackId, artistName: podcast.artistName, collectionName: podcast.collectionName, artworkUrl600: podcast.artworkUrl600, genres: podcast.genres, favoritedBy: "casandra")
        
        PodcastAPIClient.postFaves(favorite: favorite) { [weak self] (result) in
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
