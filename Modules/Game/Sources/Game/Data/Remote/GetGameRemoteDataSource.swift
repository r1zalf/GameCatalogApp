//
//  GetGameRemoteDataSource.swift
//
//
//  Created by Rizal Fahrudin on 20/12/23.
//

import Combine
import Core
import Foundation

public struct GetGameRemoteDataSource: DataSource {
    public typealias Request = Int

    public typealias Response = GameResponse

    private var endpoint: String

    private var key: String

    public init(endpoint: String, key: String) {
        self.endpoint = endpoint
        self.key = key
    }

    public func execute(request: Int?) -> AnyPublisher<GameResponse, Error> {
        Future<GameResponse, Error> { completion in

            guard let url = URL(string: "\(endpoint)/\(String(describing: request!))?key=\(key)") else {
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

                        let gameData = try jsonDecoder.decode(GameResponse.self, from: data)
                        completion(.success(gameData))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
            dataTask.resume()

        }.eraseToAnyPublisher()
    }
}
