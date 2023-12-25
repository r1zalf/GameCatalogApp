//
//  FavoriteView.swift
//  GameCatalog
//
//  Created by Rizal Fahrudin on 13/11/23.
//

import Combine
import Core
import Game
import UIKit

class FavoriteView: UIViewController, AnyView {
    var presenter: GamesFavPresenterType?

    typealias ViewModelType = [Game]

    func updateDisplay(with data: Core.ViewModel<[Game]>) {
        if let data = data.data {
            if data.isEmpty {
                emptyLabel.isHidden = false
                emptyLabel.text = "You don't have a favorite game"
            } else {
                emptyLabel.isHidden = true
            }
            games = data
            tableView.reloadData()
        }
    }

    @IBOutlet var tableView: UITableView!
    @IBOutlet var emptyLabel: UILabel!

    private var games: [Game] = .init()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Favorite"
        navigationController?.navigationBar.prefersLargeTitles = true

        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemTableViewCell")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        presenter?.getGames()
    }
}

extension FavoriteView: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return games.count
    }
}

extension FavoriteView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as? ItemTableViewCell else {
            fatalError("cell ItemTableViewCell error")
        }

        let game = games[indexPath.row]
        cell.titleLabel.text = game.name
        cell.releaseLabel.text = game.released.dateCustome()
        cell.ratingLabel.text = String(game.rating)
        cell.loadingView.isHidden = false
        cell.loadingView.startAnimating()

        if let img = game.backgroundImage {
            cell.imgView.kf.setImage(with: URL(string: img)) { result in
                switch result {
                case .success:
                    cell.loadingView.isHidden = true
                    cell.loadingView.stopAnimating()
                case let .failure(error):
                    print("Error loading image: \(error.localizedDescription)")
                }
            }
        }
        return cell
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.navigateToDetail(id: games[indexPath.row].id)
    }
}
