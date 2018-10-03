//
//  PiligrimageCollectionViewCell.swift
//  Places
//
//  Created by Deekshith Bellare on 27/09/18.
//  Copyright © 2018 Deekshith Bellare. All rights reserved.
//

import UIKit

class PilgrimagePlaceCell: UICollectionViewCell {
    static let reuseIdentifier = "PilgrimagePlaceCell"

    @IBOutlet var placeNameLabel: UILabel!
    @IBOutlet var placeImageView: UIImageView!
    @IBOutlet var detailsLabel: UILabel!
    @IBOutlet var thumbnailImageView: UIImageView!

    override func layoutSubviews(){
        super.layoutSubviews()

        thumbnailImageView.layer.cornerRadius = thumbnailImageView.frame.height / 2
        thumbnailImageView.layer.masksToBounds = true
    }
}
