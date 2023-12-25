//
//  GetGamesFavoriteRepository.swift
//
//
//  Created by Rizal Fahrudin on 20/12/23.
//

import Combine
import Core
import Foundation

public struct GetGamesFavoriteRepository<LocaleDataSource: DataSource, Transformer: Mapper>: Repository
    where LocaleDataSource.Request == Any, LocaleDataSource.Response == [GameEntity], Transformer.Domain == [Game], Transformer.Entity == [GameEntity]
{
    public typealias Request = Any

    public typealias Response = [Game]

    private let localeDataSource: LocaleDataSource
    private let mapper: Transformer

    public init(localeDataSource: LocaleDataSource, mapper: Transformer) {
        self.localeDataSource = localeDataSource
        self.mapper = mapper
    }

    public func execute(request: Request?) -> AnyPublisher<[Game], Error> {
        return localeDataSource.execute(request: request)
            .map { mapper.entityToDomain(entity: $0) }
            .eraseToAnyPublisher()
    }
}
