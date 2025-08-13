//
//  GameDetailViewController.swift
//  NexPlay
//
//  Created by J Walcott on 8/4/25.
//

import Foundation
import UIKit
import Nuke


class GameDetailViewController: UIViewController {
    
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var wishListButton: UIButton!
    
    @IBAction func DidTappedwishListButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        guard let game = game else { return }

           if sender.isSelected {
               game.addToFavorites()
           } else {
               game.removeFromFavorites()
           }
       }
    
    
    
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    var game: GameModel!   // from list API
        var gameID: Int!       // passed from list for detail API
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            navigationItem.largeTitleDisplayMode = .never
            wishListButton.configuration = nil // avoid config overriding images
            wishListButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
            wishListButton.setImage(UIImage(systemName: "bookmark.fill"), for: .selected)
            wishListButton.tintColor = .systemYellow
            wishListButton.layer.cornerRadius = wishListButton.frame.width / 2
            wishListButton.clipsToBounds = true
            if let game = game {
                    wishListButton.isSelected = GameModel.isFavorite(game)
                }
            configureViewFromList()
            fetchAndApplyDetail() // <-- get full description
        }
        
        private func configureViewFromList() {
            guard let game = game else {
                print("❌ No game data passed to GameDetailViewController")
                return
            }
            
            // Title + basic info
            navigationItem.title = game.name
            titleLabel.text = game.name
            ratingLabel.text = String(format: "Rating: %.1f", game.rating)
            
            // Release date
            if let releaseDateString = game.released {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                if let date = formatter.date(from: releaseDateString) {
                    formatter.dateStyle = .medium
                    releaseDateLabel.text = "Release Date: \(formatter.string(from: date))"
                } else {
                    releaseDateLabel.text = "Release Date: \(releaseDateString)"
                }
            } else {
                releaseDateLabel.text = "Release Date: N/A"
            }
            
            // Overview from list (often empty)
            let overview = (game.description_raw ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
            overviewLabel.text = overview.isEmpty ? "Overview: N/A" : overview
            overviewLabel.numberOfLines = 0
            
            // Images
            if let urlString = game.background_image,
               let url = URL(string: urlString) {
                headerImageView.loadImage(from: url)
                thumbnailImageView.loadImage(from: url)
            }
            
            // Image polish
            headerImageView.contentMode = .scaleAspectFill
            headerImageView.clipsToBounds = true
            thumbnailImageView.contentMode = .scaleAspectFill
            thumbnailImageView.clipsToBounds = true
        }
        
        private func fetchAndApplyDetail() {
            GameService.fetchGameDetail(id: gameID) { [weak self] detail in
                guard let self = self, let detail = detail else { return }
                
                DispatchQueue.main.async {
                    // Update overview if detail has one
                    let fullOverview = (detail.description_raw ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
                    if !fullOverview.isEmpty {
                        self.overviewLabel.text = fullOverview
                    }
                    
                    // Optionally update image and title from detail
                    if let urlString = detail.background_image,
                       let url = URL(string: urlString) {
                        self.headerImageView.loadImage(from: url)
                        self.thumbnailImageView.loadImage(from: url)
                    }
                    
                    self.navigationItem.title = detail.name
                }
            }
        }
    }
