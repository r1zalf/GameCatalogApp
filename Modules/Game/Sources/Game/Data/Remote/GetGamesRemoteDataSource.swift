//
//  GetGamesRemoteDataSource.swift
//
//
//  Created by Rizal Fahrudin on 19/12/23.
//

import Combine
import Core
import Foundation

public struct GetGamesRemoteDataSource: DataSource {
    public typealias Request = Any

    public typealias Response = [GameResponse]

    private var endpoint: String

    public init(endpoint: String) {
        self.endpoint = endpoint
    }

    public func execute(request _: Any?) -> AnyPublisher<[GameResponse], Error> {
        return Future<[GameResponse], Error> { completion in

            guard let url = URL(string: endpoint) else {
                return completion(.failure(URLError.addressUnreachable(endpoint)))
            }

            let urlRequest = URLRequest(url: url)

            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, _, error in

                if let error = error {
                    completion(.failure(error))
                }

                if let data = data {
                    do {
                        let jsonDecoder = JSONDecoder()
                        let gameData = try jsonDecoder.decode(GamesResponse.self, from: data)

                        completion(.success(gameData.results))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }

            dataTask.resume()

        }.eraseToAnyPublisher()
    }
}
