//
//  GameTransformer.swift
//
//
//  Created by Rizal Fahrudin on 20/12/23.
//

import Core
import Foundation

public class GameTransformer: NSObject, Mapper {
    public func resposneToDomain(response: GameResponse) -> Game {
        return Game(id: response.id, name: response.name, released: response.released, backgroundImage: response.backgroundImage, rating: response.rating, description: response.description, ratingTopString: response.ratingTopString)
    }

    public func entityToDomain(entity: GameEntity) -> Game {
        return Game(id: entity.id, name: entity.name, released: entity.released, backgroundImage: entity.backgroundImage, rating: entity.rating, description: entity.desc, ratingTopString: entity.ratingTopString)
    }

    public func domainToEntity(domain: Game) -> GameEntity {
        let gameEntity = GameEntity()
        gameEntity.id = domain.id
        gameEntity.name = domain.name
        gameEntity.released = domain.released
        gameEntity.backgroundImage = domain.backgroundImage ?? ""
        gameEntity.rating = domain.rating
        gameEntity.desc = domain.description ?? ""
        gameEntity.ratingTopString = domain.ratingTopString

        return gameEntity
    }

    public typealias Domain = Game

    public typealias Response = GameResponse

    public typealias Entity = GameEntity
}
