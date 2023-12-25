//
//  HomeView.swift
//  GameCatalog
//
//  Created by Rizal Fahrudin on 06/11/23.
//

import Combine
import Core
import Game
import UIKit

class HomeView: UIViewController, AnyView {
    typealias ViewModelType = [Game]

    var presenter: GamesPresenterType?

    func updateDisplay(with data: Core.ViewModel<[Game]>) {
        if data.isLoading {
            loading.isHidden = false
            loading.startAnimating()
        } else {
            loading.stopAnimating()
            loading.isHidden = true
        }

        if let error = data.error {
            print("LOG: \(error.localizedDescription)")
        }

        if let games = data.data {
            self.games = games
            tableView.reloadData()
        }
    }

    @IBOutlet var tableView: UITableView!
    @IBOutlet var loading: UIActivityIndicatorView!
    private var cancelables: Set<AnyCancellable> = []
    private var games: [Game] = .init()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "iOS games"
        navigationController?.navigationBar.prefersLargeTitles = true

        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemTableViewCell")

        presenter?.getGames()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }

    @IBAction func aboutPressed(_: UIBarButtonItem) {
        let vc: AboutViewController = UIHelper.getViewController(id: "AboutViewController")
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeView: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return games.count
    }
}

extension HomeView: UITableViewDelegate {
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
