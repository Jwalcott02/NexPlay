//
//  GameService.swift
//  NexPlay
//
//  Created by J Walcott on 8/4/25.
//
import Foundation

class GameService {
    static let apiKey = "89a4d139d36f4f1485201802236f66ce"
    static let baseURL = "https://api.rawg.io/api"

    // LIST
    static func fetchGames(completion: @escaping ([GameModel]) -> Void) {
        let urlString = "\(baseURL)/games?key=\(apiKey)&page_size=40"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion([])
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Network error:", error)
                DispatchQueue.main.async { completion([]) }
                return
            }

            guard let data = data else {
                print("No data returned")
                DispatchQueue.main.async { completion([]) }
                return
            }

            do {
                let decoded = try JSONDecoder().decode(GameResponse.self, from: data)
                DispatchQueue.main.async { completion(decoded.results) }
            } catch {
                print("Decoding error:", error)
                DispatchQueue.main.async { completion([]) }
            }
        }.resume()
    }

    // DETAIL
    static func fetchGameDetail(id: Int, completion: @escaping (GameModel?) -> Void) {
        var comps = URLComponents(string: "\(baseURL)/games/\(id)")!
        comps.queryItems = [URLQueryItem(name: "key", value: apiKey)]
        guard let url = comps.url else {
            print("Invalid detail URL")
            DispatchQueue.main.async { completion(nil) }
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Detail network error:", error)
                DispatchQueue.main.async { completion(nil) }
                return
            }

            guard let data = data else {
                print("No detail data returned")
                DispatchQueue.main.async { completion(nil) }
                return
            }

            do {
                let detail = try JSONDecoder().decode(GameModel.self, from: data)
                DispatchQueue.main.async { completion(detail) }
            } catch {
                print("Detail decoding error:", error)
                DispatchQueue.main.async { completion(nil) }
            }
        }.resume()
    }
}
