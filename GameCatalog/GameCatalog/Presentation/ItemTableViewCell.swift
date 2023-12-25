//
//  ItemTableViewCell.swift
//  GameCatalog
//
//  Created by Rizal Fahrudin on 07/11/23.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var releaseLabel: UILabel!
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var ratingLabel: UILabel!

    @IBOutlet var loadingView: UIActivityIndicatorView!
    override func awakeFromNib() {
        super.awakeFromNib()
        imgView.layer.cornerRadius = 15
    }
}
