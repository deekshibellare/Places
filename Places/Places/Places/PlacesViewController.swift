//
//  PlacesViewController.swift
//  Places
//
//  Created by Deekshith Bellare on 27/09/18.
//  Copyright © 2018 Deekshith Bellare. All rights reserved.
//

import UIKit

class PlacesViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!

    let viewModel = PlacesViewModel()

    lazy var featuredPlacesController: FeaturedPlacesController = {
        let storyBoard = UIStoryboard(.main)
        let controller: FeaturedPlacesController = storyBoard.instantiateViewController()
        add(controller: controller)
        return controller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchData()
    }

    private func togglePlacesView() {
        viewModel.isPlacesViewExapanded.toggle()
        collectionView.performBatchUpdates({
            let indexSet = IndexSet(integersIn: 0 ... 0)
            self.collectionView.reloadSections(indexSet)
        }, completion: nil)
    }
}

extension PlacesViewController: UICollectionViewDataSource {
    func numberOfSections(in _: UICollectionView) -> Int {
        return viewModel.numberOfSections()
    }

    func collectionView(_: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows(at: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = viewModel.section(for: indexPath.section)

        switch section {
        case .allPlaces:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaceCell.reuseIdentifier, for: indexPath) as! PlaceCell
            configure(cell: cell, at: indexPath)
            return cell

        case .featuredPlaces:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedPlaceHolderCell.reuseIdentifier, for: indexPath) as! FeaturedPlaceHolderCell
            cell.hostedView = featuredPlacesController.view
            return cell
        case .piligrimagePlaces:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PilgrimagePlaceCell.reuseIdentifier, for: indexPath) as! PilgrimagePlaceCell
            configure(cell: cell, at: indexPath)
            return cell
        }
    }

    func configure(cell: PlaceCell, at indexPath: IndexPath) {
        let item = viewModel.listTtem(at: indexPath)
        if let imageName = item?.imageName {
            cell.placeImageView.clipsToBounds = true
            cell.placeImageView.image = UIImage(named: imageName)
        }
        if let title = item?.name {
            cell.placeNameLabel.text = title
        }
    }

    func configure(cell: PilgrimagePlaceCell, at indexPath: IndexPath) {
        let item = viewModel.item(at: indexPath)
        if let imageName = item?.imageName {
            cell.placeImageView.clipsToBounds = true
            cell.placeImageView.image = UIImage(named: imageName)
            cell.thumbnailImageView.image = UIImage(named: imageName)
        }
        if let title = item?.name {
            cell.placeNameLabel.text = title
        }

        if let details = item?.details {
            cell.detailsLabel.text = details
        }
    }
}

extension PlacesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let section = viewModel.section(for: indexPath.section)
        switch section {
        case .allPlaces:
            return CGSize(width: (collectionView.frame.width - 6) / 4, height: 150)
        case .featuredPlaces:
            return CGSize(width: collectionView.frame.width, height: 340)
        case .piligrimagePlaces:
            return CGSize(width: collectionView.frame.width, height: 330)
        }
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let section = viewModel.section(for: section)
        switch section {
        case .allPlaces:
            return 2
        case .featuredPlaces:
            return 0
        case .piligrimagePlaces:
            return 50
        }
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let section = viewModel.section(for: section)
        switch section {
        case .allPlaces:
            return 2
        case .featuredPlaces:
            return 0
        case .piligrimagePlaces:
            return 0
        }
    }
}

extension PlacesViewController: UICollectionViewDelegate {
    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 3 {
            togglePlacesView()
        }
    }
}

extension PlacesViewController {
    private func add(controller childViewController: UIViewController) {
        addChild(childViewController)
        childViewController.didMove(toParent: self)
    }
}
