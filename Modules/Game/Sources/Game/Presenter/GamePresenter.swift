//
//  GamePresenter.swift
//
//
//  Created by Rizal Fahrudin on 20/12/23.
//

import Combine
import Core
import Foundation
import UIKit

public class GamePresenter<GetGamesInteractor: UseCase, SaveGameInteractor: UseCase, ViewType: AnyView>: Presenter
    where GetGamesInteractor.Request == Int, GetGamesInteractor.Response == Game, SaveGameInteractor.Request == Game, ViewType.ViewModelType == Game
{
    public var view: ViewType?

    public var router: (any RouterType)?

    public typealias RouterType = Router

    private var cancellable = Set<AnyCancellable>()

    var getGameInteractor: GetGamesInteractor

    var saveGameInteractor: SaveGameInteractor

    public init(id: Int, getGamesInteractor: GetGamesInteractor, saveGameInteractor: SaveGameInteractor) {
        getGameInteractor = getGamesInteractor
        self.saveGameInteractor = saveGameInteractor
        getGame(id: id)
    }

    private var viewModel = ViewModel<Game>()

    public func getGame(id: Int) {
        view?.updateDisplay(with: viewModel.copy(isLoading: true))

        getGameInteractor.execute(request: id)
            .receive(on: RunLoop.main)
            .sink { completion in
                if case let .failure(error) = completion {
                    self.view?.updateDisplay(with: self.viewModel.copy(error: error))
                }
                self.view?.updateDisplay(with: self.viewModel.copy(isLoading: false))
            } receiveValue: { game in
                self.view?.updateDisplay(with: self.viewModel.copy(data: game))
            }.store(in: &cancellable)
    }

    public func saveGame(_ game: Game) {
        saveGameInteractor.execute(request: game)
            .receive(on: RunLoop.main)
            .sink { _ in
                self.getGame(id: game.id)
            } receiveValue: { _ in }
            .store(in: &cancellable)
    }
}
