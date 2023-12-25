//
//  UpdateGameLocaleDataSource.swift
//
//
//  Created by Rizal Fahrudin on 20/12/23.
//

import Combine
import Core
import Foundation
import RealmSwift

public struct UpdateGameLocaleDataSource: DataSource {
    public typealias Request = GameEntity

    public typealias Response = Any

    private var realm: Realm

    public init(realm: Realm) {
        self.realm = realm
    }

    public func execute(request: GameEntity?) -> AnyPublisher<Response, Error> {
        Future<Response, Error> { completion in
            do {
                if let request = request {
                    try self.realm.write {
                        if let existingObject = self.realm.object(ofType: GameEntity.self, forPrimaryKey: request.id) {
                            self.realm.delete(existingObject)
                        } else {
                            self.realm.add(request)
                        }
                        completion(.success(true))
                    }
                } else {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } catch {
                completion(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
}
