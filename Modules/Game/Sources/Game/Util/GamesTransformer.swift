//
//  GamesTransformer.swift
//
//
//  Created by Rizal Fahrudin on 19/12/23.
//

import Core
import Foundation

open class GamesTransformer: NSObject, Mapper {
    public typealias Domain = [Game]

    public typealias Response = [GameResponse]

    public typealias Entity = [GameEntity]

    public func resposneToDomain(response: [GameResponse]) -> [Game] {
        return response.map { game in
            Game(id: game.id, name: game.name, released: game.released, backgroundImage: game.backgroundImage, rating: game.rating, description: game.description, ratingTopString: game.ratingTopString)
        }
    }

    public func entityToDomain(entity: [GameEntity]) -> [Game] {
        return entity.map { game in
            Game(id: game.id, name: game.name, released: game.released, backgroundImage: game.backgroundImage, rating: game.rating, description: game.description, ratingTopString: game.ratingTopString)
        }
    }

    public func domainToEntity(domain _: [Game]) -> [GameEntity] {
        return []
    }
}
