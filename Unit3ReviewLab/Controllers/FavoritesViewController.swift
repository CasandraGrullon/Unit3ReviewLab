//
//  FavoritesViewController.swift
//  Unit3ReviewLab
//
//  Created by casandra grullon on 12/16/19.
//  Copyright © 2019 casandra grullon. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var favorites = [Favorite]() {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    var podcast: Results?
    
    var podcastArr = [Results]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        tableView.dataSource = self
        tableView.delegate = self
    }

    func loadData() {
     
        FavoritesAPIClient.getFaves { [weak self] (result) in
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "App Error", message: "\(appError)")
                }
            case .success(let favorite):
                self?.favorites = favorite.filter {$0.favoritedBy == "casandra"}
            }
        }
        
     
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "favorite"{
        guard let podcastDetail = segue.destination as? PodcastDetailsController, let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("issue in segue")
        }
            
        if podcastDetail.podcast?.trackId == podcastArr.first?.trackId {
            podcastDetail.favorite = favorites[indexPath.row]
        }
        }
    }

}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as? FavoriteCell else {
            fatalError("cell incorrect")
        }
        let fave = favorites[indexPath.row]
        
        cell.configureCell(for: fave)
        
        return cell
    }
}

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}
