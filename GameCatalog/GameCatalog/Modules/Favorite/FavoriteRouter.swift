//
//  FavoriteRouter.swift
//  GameCatalog
//
//  Created by Rizal Fahrudin on 20/12/23.
//

import Core
import Foundation
import Game

class FavoriteRouter: Router {
    var entry: FavoriteView?

    static func create(_: Any?) -> FavoriteRouter {
        let view: FavoriteView = UIHelper.getViewController(id: "FavoriteViewController")
        let presenter = Injection().provideGamesFavoritePresenter()
        let router = FavoriteRouter()

        presenter.view = view
        view.presenter = presenter
        router.entry = view
        presenter.router = router

        return router
    }

    func pushViewController(request: Int?) {
        let detailRouter = DetailRouter.create(request)

        guard let viewController = entry else { return }
        guard let detailController = detailRouter.entry else { return }

        viewController.navigationController?.pushViewController(detailController, animated: true)
    }
}
