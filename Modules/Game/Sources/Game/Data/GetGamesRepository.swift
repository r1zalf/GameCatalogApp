//
//  GetGamesRepository.swift
//
//
//  Created by Rizal Fahrudin on 19/12/23.
//

import Combine
import Core
import Foundation

public struct GetGamesRepository<RemoteDataSource: DataSource, Transformer: Mapper>: Repository
    where RemoteDataSource.Response == [GameResponse], Transformer.Domain == [Game], Transformer.Response == [GameResponse]
{
    public typealias Request = Any

    public typealias Response = [Game]

    private let remoteDataSource: RemoteDataSource
    private let mapper: Transformer

    public init(remoteDataSource: RemoteDataSource, mapper: Transformer) {
        self.remoteDataSource = remoteDataSource
        self.mapper = mapper
    }

    public func execute(request _: Request?) -> AnyPublisher<[Game], Error> {
        return remoteDataSource.execute(request: nil)
            .map { self.mapper.resposneToDomain(response: $0) }
            .eraseToAnyPublisher()
    }
}
