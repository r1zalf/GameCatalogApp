//
//  GamesResponse.swift
//
//
//  Created by Rizal Fahrudin on 19/12/23.
//

import CoreData
import Foundation

public struct GamesResponse: Codable {
    let count: Int
    let next: String
    let results: [GameResponse]

    enum CodingKeys: String, CodingKey {
        case count, next, results
    }
}

public struct GameResponse: Codable {
    let id: Int
    let name, released: String
    let backgroundImage: String?
    let rating: Double
    let description: String?
    let ratingTop: Int

    var ratingTopString: String {
        return switch ratingTop {
        case 1:
            "skip"
        case 3:
            "Meh"
        case 4:
            "Recommended"
        case 5:
            "Exceptional"
        default:
            ""
        }
    }

    public enum CodingKeys: String, CodingKey {
        case id, name, released, rating, description
        case backgroundImage = "background_image"
        case ratingTop = "rating_top"
    }
}
