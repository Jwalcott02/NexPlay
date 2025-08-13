import UIKit
import Nuke

class WishlistViewController: UITableViewController {

    private var favoriteGames: [GameModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Wish List"

        // Uses a fixed height so rows always show while we sort out constraints
        tableView.rowHeight = 150
        tableView.estimatedRowHeight = 150
        tableView.tableFooterView = UIView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        favoriteGames = GameModel.getFavorites()
        print("📌 favorites count:", favoriteGames.count)

        if favoriteGames.isEmpty {
            let label = UILabel()
            label.text = "🎮  Add some favorite games!"
            label.textAlignment = .center
            label.textColor = .secondaryLabel
            label.numberOfLines = 0
            tableView.backgroundView = label
        } else {
            tableView.backgroundView = nil
        }

        tableView.reloadData()
    }

    // MARK: - TableView Data Source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("📦 rows to render:", favoriteGames.count)
        return favoriteGames.count
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell",
                                                 for: indexPath) as! GameCell
        let game = favoriteGames[indexPath.row]

        // Title
        cell.gameTitleLabel.text = game.name
        cell.gameTitleLabel.textColor = .label
        cell.gameTitleLabel.numberOfLines = 2

        // Show rating (match your feed)
        cell.gameRatingLabel.text = String(format: "Rating: %.1f/5", game.rating)
        cell.gameRatingLabel.textColor = .label
        cell.gameRatingLabel.numberOfLines = 1

        // Thumbnail
        if let s = game.background_image, let url = URL(string: s) {
            cell.gameImageView.loadImage(from: url)
        } else {
            cell.gameImageView.image = UIImage(systemName: "gamecontroller")
        }

        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow,
           let detailVC = segue.destination as? GameDetailViewController {
            let game = favoriteGames[indexPath.row]
            detailVC.game = game
            detailVC.gameID = game.id
        }
    }
}

