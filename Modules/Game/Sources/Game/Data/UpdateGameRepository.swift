//
//  UpdateGameRepository.swift
//
//
//  Created by Rizal Fahrudin on 20/12/23.
//

import Combine
import Core
import Foundation

public struct UpdateGameRepository<LocaleDataSource: DataSource, Transformer: Mapper>: Repository
    where LocaleDataSource.Request == GameEntity, LocaleDataSource.Response == Any, Transformer.Domain == Game, Transformer.Entity == GameEntity
{
    public typealias Request = Game

    public typealias Response = Any

    private let localeDataSource: LocaleDataSource
    private let mapper: Transformer

    public init(localeDataSource: LocaleDataSource, mapper: Transformer) {
        self.localeDataSource = localeDataSource
        self.mapper = mapper
    }

    public func execute(request: Game?) -> AnyPublisher<Response, Error> {
        guard let request = request else {
            fatalError()
        }

        return localeDataSource.execute(request: mapper.domainToEntity(domain: request))
    }
}
