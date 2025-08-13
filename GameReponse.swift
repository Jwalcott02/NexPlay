//
//  GameReponse.swift
//  NexPlay
//
//  Created by J Walcott on 8/11/25.
//

import Foundation

struct GameResponse: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [GameModel]
}

//  This file defines the `GameResponse` struct, which is a wrapper
//  for the JSON data returned by the RAWG Video Games Database API
//  when requesting a list or search of games.
