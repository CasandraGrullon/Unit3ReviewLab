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
    var podcastArr = [Results]()
    var favorite: Favorite?
    
    var favorited = [Favorite]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        updateFavoriteUI()
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
    
    func updateFavoriteUI() {
        guard let idNumber = favorite?.trackId else {
            return
        }
        PodcastAPIClient.getID(for: idNumber) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "App Error", message: "\(appError)")
                }
            case .success(let podcast):
                self?.podcastArr = podcast
                DispatchQueue.main.async {
                    self?.podcastNameLabel.text = self?.podcastArr.first?.collectionName
                    self?.podcastGenreLabel.text = self?.podcastArr.first?.genres.first
                    self?.podcastImage.getImage(with: self?.podcastArr.first?.artworkUrl600 ?? "") { [weak self] (result) in
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
        }
        
        
        
        
        
        
    }
    
    @IBAction func addToFaves(_ sender: UIBarButtonItem) {
        guard let podcast = podcast else {
            showAlert(title: "App Error", message: "Issue uploading data")
            return
        }
        
        let favorite = Favorite(trackId: podcast.trackId, favoritedBy: "casandra", collectionName: podcast.collectionName, artworkUrl600: podcast.artworkUrl600)
        
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
