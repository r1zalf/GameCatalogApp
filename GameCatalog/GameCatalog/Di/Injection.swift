//
//  Injection.swift
//  GameCatalog
//
//  Created by Rizal Fahrudin on 30/11/23.
//

import Core
import Game
import RealmSwift
import UIKit

typealias GamePresenterType = GamePresenter<Interactor<Int, Game, GetGameRepository<GetGameRemoteDataSource, GetGameLocaleDataSource, GameTransformer>>, Interactor<Game, Any, UpdateGameRepository<UpdateGameLocaleDataSource, GameTransformer>>, DetailView>
typealias GamesPresenterType = GamesPresenter<Interactor<Any, [Game], GetGamesRepository<GetGamesRemoteDataSource, GamesTransformer>>, HomeView, HomeRouter>
typealias GamesFavPresenterType = GamesFavoritePresenter<Interactor<Any, [Game], GetGamesFavoriteRepository<GetGamesLocaleDataSource, GamesTransformer>>, FavoriteView, FavoriteRouter>

class Injection: NSObject {
    private let realm = try? Realm()

    private let gameTransformer = GamesTransformer()

    func provideGamesPresenter() -> GamesPresenterType {
        let getGamesDataSoure = GetGamesRemoteDataSource(endpoint: "\(K.baseUrl)?key=\(K.key)&platform=\(K.platform)")
        let gameTransformer = GamesTransformer()
        let getGamesRepository = GetGamesRepository(remoteDataSource: getGamesDataSoure, mapper: gameTransformer)

        let getGamesInteractor = Interactor(repository: getGamesRepository)

        return GamesPresenter(getGamesInteractor: getGamesInteractor)
    }

    func provideGamesFavoritePresenter() -> GamesFavPresenterType {
        let getGamesDataSoure = GetGamesLocaleDataSource(realm: realm!)
        let getGamesRepository = GetGamesFavoriteRepository(localeDataSource: getGamesDataSoure, mapper: gameTransformer)

        let getGamesInteractor = Interactor(repository: getGamesRepository)

        return GamesFavoritePresenter(getGamesFavoriteInteractor: getGamesInteractor)
    }

    func provideGamePresenter(id: Int) -> GamePresenterType {
        let gameTransformer = GameTransformer()

        let getGameDataSoure = GetGameRemoteDataSource(endpoint: K.baseUrl, key: K.key)
        let getGameLocaleDataSource = GetGameLocaleDataSource(realm: realm!)
        let getGameRepository = GetGameRepository(remoteDataSource: getGameDataSoure, localeDataSource: getGameLocaleDataSource, mapper: gameTransformer)
        let getGamesInteractor = Interactor(repository: getGameRepository)

        let saveGameDataSource = UpdateGameLocaleDataSource(realm: realm!)
        let saveGameRepository = UpdateGameRepository(localeDataSource: saveGameDataSource, mapper: gameTransformer)
        let saveGamesInteractor = Interactor(repository: saveGameRepository)

        return GamePresenter(id: id, getGamesInteractor: getGamesInteractor, saveGameInteractor: saveGamesInteractor)
    }
}
