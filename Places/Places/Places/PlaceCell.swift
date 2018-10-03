//
//  PlaceCollectionViewCell.swift
//  Places
//
//  Created by Deekshith Bellare on 27/09/18.
//  Copyright © 2018 Deekshith Bellare. All rights reserved.
//

import UIKit

class PlaceCell: UICollectionViewCell {
    static let reuseIdentifier = "PlaceCell"

    @IBOutlet var placeNameLabel: UILabel!
    @IBOutlet var placeImageView: UIImageView!

    override func layoutSubviews() {
        super.layoutSubviews()
        placeImageView.layer.cornerRadius = placeImageView.frame.height / 2
        placeImageView.layer.masksToBounds = true
    }
}
