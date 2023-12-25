//
//  GetGamesLocaleDataSource.swift
//
//
//  Created by Rizal Fahrudin on 20/12/23.
//

import Combine
import Core
import Foundation
import RealmSwift

public struct GetGamesLocaleDataSource: DataSource {
    public typealias Request = Any

    public typealias Response = [GameEntity]
    private var realm: Realm

    public init(realm: Realm) {
        self.realm = realm
    }

    public func execute(request _: Request?) -> AnyPublisher<[GameEntity], Error> {
        Future<[GameEntity], Error> { completion in

            let games = self.realm.objects(GameEntity.self)

            completion(.success(Array(games)))
        }.eraseToAnyPublisher()
    }
}
