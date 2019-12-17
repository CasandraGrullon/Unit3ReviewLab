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
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func loadData() {
        guard let podcast = podcast else {
            fatalError("no data")
        }
        FavoritesAPIClient.getFaves { [weak self] (result) in
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "App Error", message: "\(appError)")
                }
            case .success(let favorite):
                self?.favorites = favorite.filter { $0.trackId == podcast.trackId }
            }
        }
    }

}
