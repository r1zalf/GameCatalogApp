//
//  GamesPresenter.swift
//
//
//  Created by Rizal Fahrudin on 19/12/23.
//

import Combine
import Core
import Foundation
import UIKit

public class GamesPresenter<Interactor: UseCase, ViewType: AnyView, RouterType: Router>: Presenter where Interactor.Request == Any, Interactor.Response == [Game], ViewType.ViewModelType == [Game], RouterType.PushRequestType == Int {
    public var view: ViewType?

    public var router: RouterType?

    private var cancellable = Set<AnyCancellable>()

    var getGamesInteractor: Interactor

    public init(getGamesInteractor: Interactor) {
        self.getGamesInteractor = getGamesInteractor
    }

    private var viewModel = ViewModel<[Game]>()

    public func getGames() {
        view?.updateDisplay(with: viewModel.copy(isLoading: true))
        getGamesInteractor.execute(request: nil)
            .receive(on: RunLoop.main)
            .sink { completion in
                if case let .failure(error) = completion {
                    self.view?.updateDisplay(with: self.viewModel.copy(error: error))
                }
                self.view?.updateDisplay(with: self.viewModel.copy(isLoading: false))

            } receiveValue: { games in
                self.view?.updateDisplay(with: self.viewModel.copy(data: games))
            }.store(in: &cancellable)
    }

    public func navigateToDetail(id: Int) {
        router?.pushViewController(request: id)
    }
}
