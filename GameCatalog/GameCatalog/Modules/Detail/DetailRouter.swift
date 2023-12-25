//
//  DetailRouter.swift
//  GameCatalog
//
//  Created by Rizal Fahrudin on 20/12/23.
//

import Core
import Foundation

struct DetailRouter: Router {
    var entry: DetailView?

    static func create(_ request: Int?) -> DetailRouter {
        let detailView: DetailView = UIHelper.getViewController(id: "DetailViewController")
        let presenter = Injection().provideGamePresenter(id: request!)
        var homeRouter = DetailRouter()

        presenter.view = detailView
        presenter.router = homeRouter
        detailView.presenter = presenter
        homeRouter.entry = detailView

        return homeRouter
    }

    func pushViewController(request _: Any?) {}
}
