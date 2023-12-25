//
//  GetGameLocaleDataSource.swift
//
//
//  Created by Rizal Fahrudin on 23/12/23.
//

import Combine
import Core
import Foundation
import RealmSwift

public struct GetGameLocaleDataSource: DataSource {
    public typealias Request = Int

    public typealias Response = GameEntity

    private var realm: Realm

    public init(realm: Realm) {
        self.realm = realm
    }

    public func execute(request: Int?) -> AnyPublisher<GameEntity, Error> {
        Future<GameEntity, Error> { completion in

            if let request = request {
                if let game = realm.object(ofType: GameEntity.self, forPrimaryKey: request) {
                    completion(.success(game))
                } else {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
}
