//
//  HomeRouter.swift
//  GameCatalog
//
//  Created by Rizal Fahrudin on 20/12/23.
//

import Core
import Foundation
import Game
import UIKit

struct HomeRouter: Router {
    var entry: HomeView?

    static func create(_: Any?) -> HomeRouter {
        let homeView: HomeView = UIHelper.getViewController(id: "GamesViewController")
        let presenter = Injection().provideGamesPresenter()
        var homeRouter = HomeRouter()

        presenter.view = homeView
        homeView.presenter = presenter
        homeRouter.entry = homeView
        presenter.router = homeRouter

        return homeRouter
    }

    func pushViewController(request: Int?) {
        let detailRouter = DetailRouter.create(request)

        guard let viewController = entry else { return }
        guard let detailController = detailRouter.entry else { return }

        viewController.navigationController?.pushViewController(detailController, animated: true)
    }
}
