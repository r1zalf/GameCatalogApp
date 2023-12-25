//
//  Game.swift
//
//
//  Created by Rizal Fahrudin on 19/12/23.
//

import Foundation

public struct Game {
    public let id: Int
    public let name, released: String
    public let backgroundImage: String?
    public let rating: Double
    public let description: String?
    public var ratingTopString: String
    public var isFavorite: Bool = false
}
