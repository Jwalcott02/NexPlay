//
//  GameListViewController.swift
//  NexPlay
//
//  Created by J Walcott on 8/4/25.
//


import UIKit
class GameListViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    var games: [GameModel] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle
       override func viewDidLoad() {
           super.viewDidLoad()

           
           navigationController?.navigationBar.prefersLargeTitles = false
           navigationItem.largeTitleDisplayMode = .never

           tableView.delegate = self
           tableView.dataSource = self

           
           setupTrendingHeader()

           // Fetch games
           GameService.fetchGames { [weak self] games in
               DispatchQueue.main.async {
                   self?.games = games
                   self?.tableView.reloadData()
               }
           }
       }

     
       override func viewDidLayoutSubviews() {
           super.viewDidLayoutSubviews()
           guard let header = tableView.tableHeaderView else { return }
           let targetSize = CGSize(width: tableView.bounds.width, height: 0)
           let height = header.systemLayoutSizeFitting(targetSize).height
           if header.frame.height != height {
               header.frame.size.height = height
               tableView.tableHeaderView = header
           }
       }

       // Deselect the tapped row when coming back from detail
       override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           if let selected = tableView.indexPathForSelectedRow {
               tableView.deselectRow(at: selected, animated: animated)
           }
       }

       // MARK: - TableView Data Source
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return games.count
       }

       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 180
       }

       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath) as! GameCell
           let game = games[indexPath.row]

           // Title
           cell.gameTitleLabel.text = game.name

           // Rating
           cell.gameRatingLabel.text = String(format: "Rating: %.1f/5", game.rating)

           // Image (Nuke extension)
           if let urlString = game.background_image, let url = URL(string: urlString) {
               cell.gameImageView.loadImage(from: url)
           } else {
               cell.gameImageView.image = nil
           }

           return cell
       }

       // MARK: - Navigation
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "ShowGameDetail",
              let destinationVC = segue.destination as? GameDetailViewController,
              let indexPath = tableView.indexPathForSelectedRow {
               let selectedGame = games[indexPath.row]
               destinationVC.game = selectedGame      // quick UI fill
               destinationVC.gameID = selectedGame.id // for full fetch
           }
       }

       // MARK: - Header
       private func setupTrendingHeader() {
           let header = UIView()
           header.backgroundColor = .clear

           let title = UILabel()
           title.text = "Trending"
           title.font = .systemFont(ofSize: 32, weight: .bold) // 
           title.textColor = .label
           title.translatesAutoresizingMaskIntoConstraints = false

           header.addSubview(title)
           NSLayoutConstraint.activate([
               title.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 16),
               title.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -16),
               title.topAnchor.constraint(equalTo: header.topAnchor, constant: 24),
               title.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -8)
           ])

           // Size the header before assigning
           header.setNeedsLayout()
           header.layoutIfNeeded()
           let size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
           header.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: size.height)

           tableView.tableHeaderView = header
       }
   }
