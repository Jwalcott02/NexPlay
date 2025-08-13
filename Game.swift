//
//  Game.swift
//  NexPlay
//
//  Created by J Walcott on 8/4/25.
//

//
//  GameModel.swift
//

import Foundation

// MARK: - Model
struct GameModel: Codable, Equatable {
    let id: Int
    let name: String
    let rating: Double
    let released: String?
    let background_image: String?
    let description_raw: String?

    // Equatable by id so it can add/remove from favorites easily
    static func == (lhs: GameModel, rhs: GameModel) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - Favorites (UserDefaults) helpers
extension GameModel {
    // Key used to store favorites array in UserDefaults
    static var favoritesKey: String { "Favorites" }

    //Save an array of favorite games
    static func save(_ games: [GameModel], forKey key: String = favoritesKey) {
        let defaults = UserDefaults.standard
        if let data = try? JSONEncoder().encode(games) {
            defaults.set(data, forKey: key)
        }
    }

    //Load all favorite games
    static func getFavorites(forKey key: String = favoritesKey) -> [GameModel] {
        let defaults = UserDefaults.standard
        guard let data = defaults.data(forKey: key),
              let games = try? JSONDecoder().decode([GameModel].self, from: data)
        else { return [] }
        return games
    }

    //Check if a game is currently a favorite
    static func isFavorite(_ game: GameModel) -> Bool {
        return getFavorites().contains(where: { $0.id == game.id })
    }

    //Add this game to favorites (no duplicates)
    func addToFavorites() {
        var favs = GameModel.getFavorites()
        if !favs.contains(where: { $0.id == self.id }) {
            favs.append(self)
            GameModel.save(favs)
        }
    }

    // Remove this game from favorites
    func removeFromFavorites() {
        var favs = GameModel.getFavorites()
        favs.removeAll { $0.id == self.id }
        GameModel.save(favs)
    }
}
