//
//  FeaturedPlaceHolderCell.swift
//  Places
//
//  Created by Deekshith Bellare on 27/09/18.
//  Copyright © 2018 Deekshith Bellare. All rights reserved.
//

import UIKit

class FeaturedPlaceHolderCell: UICollectionViewCell {
    static let reuseIdentifier = "FeaturedPlaceHolderCell"

    // MARK: - HostedView

    var hostedView: UIView? {
        didSet {
            guard let hostedView = hostedView else {
                return
            }

            hostedView.frame = contentView.bounds
            contentView.addSubview(hostedView)
        }
    }

    // MARK: - Reuse

    override func prepareForReuse() {
        super.prepareForReuse()

        if hostedView?.superview == contentView { // Make sure that hostedView hasn't been added as a subview to a different cell
            hostedView?.removeFromSuperview()
        } else {
            print("hostedView is no longer attached to this cell")
        }
        hostedView = nil
    }
}
