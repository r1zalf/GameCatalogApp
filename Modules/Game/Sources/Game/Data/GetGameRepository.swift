//
//  GetGameRepository.swift
//
//
//  Created by Rizal Fahrudin on 20/12/23.
//

import Combine
import Core
import Foundation

public struct GetGameRepository<RemoteDataSource: DataSource, LocaleDataSource: DataSource, Transformer: Mapper>: Repository
    where RemoteDataSource.Response == GameResponse,
    RemoteDataSource.Request == Int,
    Transformer.Domain == Game,
    Transformer.Response == GameResponse,
    Transformer.Entity == GameEntity,
    LocaleDataSource.Request == Int,
    LocaleDataSource.Response == GameEntity
{
    public typealias Request = Int

    public typealias Response = Game

    private let remoteDataSource: RemoteDataSource
    private let localeDataSource: LocaleDataSource
    private let mapper: Transformer

    public init(remoteDataSource: RemoteDataSource, localeDataSource: LocaleDataSource, mapper: Transformer) {
        self.remoteDataSource = remoteDataSource
        self.localeDataSource = localeDataSource
        self.mapper = mapper
    }

    public func execute(request: Int?) -> AnyPublisher<Game, Error> {
        return localeDataSource.execute(request: request)
            .map {
                var game = mapper.entityToDomain(entity: $0)
                game.isFavorite = true
                return game
            }
            .catch { _ in
                remoteDataSource.execute(request: request)
                    .map { self.mapper.resposneToDomain(response: $0) }
            }
            .eraseToAnyPublisher()
    }
}
