//
//  AboutViewController.swift
//  GameCatalog
//
//  Created by Rizal Fahrudin on 08/12/23.
//

import UIKit

class AboutViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        tabBarController?.tabBar.isHidden = true
    }
}
