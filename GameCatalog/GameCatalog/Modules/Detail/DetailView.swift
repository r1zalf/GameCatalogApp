//
//  DetailView.swift
//  GameCatalog
//
//  Created by Rizal Fahrudin on 08/11/23.
//

import Combine
import Core
import Game
import Kingfisher
import UIKit

class DetailView: UIViewController, AnyView {
    typealias PresenterType = GamePresenterType

    typealias ViewModelType = Game

    var presenter: PresenterType?

    func updateDisplay(with data: Core.ViewModel<Game>) {
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

        if let game = data.data {
            self.game = game

            titleLabel.text = game.name
            releaseLabel.text = game.released.dateCustome()
            if let bgImg = game.backgroundImage, let url = URL(string: bgImg) {
                imgView.kf.setImage(with: url)
            }

            ratingLabel.text = "\(game.rating) \(game.ratingTopString)"

            if let desc = game.description, let attributedString = try? NSAttributedString(data: desc.data(using: .utf8)!, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
                aboutLabel.attributedText = attributedString
            } else {
                aboutLabel.text = ""
            }
            favorite(isFavorite: game.isFavorite)
        }
    }

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var aboutLabel: UILabel!
    @IBOutlet var loading: UIActivityIndicatorView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var favoriteButton: UIBarButtonItem!
    @IBOutlet var releaseLabel: UILabel!
    private var cancelables: Set<AnyCancellable> = []
    var game: Game!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        tabBarController?.tabBar.isHidden = true
    }

    func favorite(isFavorite: Bool) {
        if isFavorite {
            favoriteButton.image = UIImage(systemName: "heart.fill")
            favoriteButton.tag = 0
        } else {
            favoriteButton.image = UIImage(systemName: "heart")
            favoriteButton.tag = 1
        }
    }

    @IBAction func favoritePressed(_: UIBarButtonItem) {
        presenter?.saveGame(game)
    }
}
